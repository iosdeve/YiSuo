//
//  RegistInfoController.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/5.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "RegistInfoController.h"
#import "CustomTextField.h"
#import "CustomTabBarController.h"
#import "CommonUtil.h"
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"
#import "OAuthInfo.h"

@interface RegistInfoController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CustomTextField *nickName;
@property (weak, nonatomic) IBOutlet CustomTextField *password;
@property (weak, nonatomic) IBOutlet CustomTextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (strong, nonatomic) NSArray *textFields;

@end

@implementation RegistInfoController

- (void)viewDidLoad {
    self.title=@"注册";
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupUI{
    self.textFields=@[self.nickName,self.password,self.confirmPassword];
    self.nickName.background=[UIImage imageResize:@"input_bg2"];
    self.password.background=[UIImage imageResize:@"input_bg2"];
    self.confirmPassword.background=[UIImage imageResize:@"input_bg2"];
    self.nickName.delegate=self;
    self.password.delegate=self;
    self.confirmPassword.delegate=self;
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateHighlighted];
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void) nextStepBtnClick{
    if (self.nickName.text.length<1) {
        [MBProgressHUD showError:@"请输入用户昵称"];
        return;
    }else if(self.password.text.length<6){
        [MBProgressHUD showError:@"密码必须大于6位"];
        return;
    }else if(![self.password.text isEqual:self.confirmPassword.text]){
        [MBProgressHUD showError:@"密码不一致"];
        return;
    }
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"t"]=self.phoneNum;
    parameters[@"uuid"]=self.uuid;
    parameters[@"nickname"]=self.nickName.text;
    parameters[@"password"]=self.password.text;
    self.nextStepBtn.enabled=NO;
    [HttpTool postURL:RegistUserInfo parameter:parameters success:^(id responseObject) {
        MyLog(@"11%@",responseObject);
        NSInteger result=[responseObject[@"result"] integerValue];
        if (result!=0) {
            CustomTabBarController *tabBarVC=[[CustomTabBarController alloc] init];
            self.view.window.rootViewController=tabBarVC;
        }else{
            [MBProgressHUD showError:@"用户注册失败"];
        }
        self.nextStepBtn.enabled=YES;
        
    } faile:^(NSError *error) {
        MyLog(@"error%@",error);
        self.nextStepBtn.enabled=YES;
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //如果是最后一个，点击return提交
    if (textField==self.confirmPassword) {
        [textField resignFirstResponder];
        [self nextStepBtnClick];
        return true;
    }
    
    NSInteger nextTextFieldIndex=textField.tag+1;
    if (nextTextFieldIndex<self.textFields.count) {
        [self.textFields[nextTextFieldIndex] becomeFirstResponder];
    }
    return true;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UIView *responderView=[CommonUtil findFirstResponderBeneathView:self.view];
    if (![responderView isExclusiveTouch]) {
        [responderView resignFirstResponder];
    }
}

@end
