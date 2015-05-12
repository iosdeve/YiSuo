//
//  ChangePasswordController.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/6.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ChangePasswordController.h"
#import "CustomTextField.h"
#import "CommonUtil.h"
#import "MBProgressHUD+MJ.h"
#import "OAuthInfo.h"
#import "HttpTool.h"
#import "LoginController.h"

@interface ChangePasswordController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CustomTextField *password;
@property (weak, nonatomic) IBOutlet CustomTextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@property (strong, nonatomic) NSArray *textFields;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    self.title=@"修改密码";
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupUI{
    self.password.background=[UIImage imageResize:@"input_bg2"];
    self.confirmPassword.background=[UIImage imageResize:@"input_bg2"];
    self.password.delegate=self;
    self.confirmPassword.delegate=self;
    self.textFields=@[self.password,self.confirmPassword];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateHighlighted];
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.confirmPassword) {
        [self.confirmPassword resignFirstResponder];
        [self nextStepBtnClick];
        return YES;
    }
    NSInteger nextTextFieldIndex=textField.tag+1;
    if (nextTextFieldIndex<self.textFields.count) {
        [self.textFields[nextTextFieldIndex] becomeFirstResponder];
    }
    return true;
}

-(void) nextStepBtnClick{
    if(self.password.text.length<6){
        [MBProgressHUD showError:@"密码必须大于6位"];
        return;
    }else if(![self.password.text isEqual:self.confirmPassword.text]){
        [MBProgressHUD showError:@"密码不一致"];
        return;
    }
    self.nextStepBtn.enabled=NO;
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    parameters[@"t"]=self.phoneNum;
    parameters[@"uuid"]=self.uuid;
    parameters[@"password"]=self.password.text;
    [HttpTool postURL:Forgot_ChangePassword parameter:parameters success:^(id responseObject) {
        self.nextStepBtn.enabled=YES;
        NSInteger result=[responseObject[@"result"] integerValue];
        if (result!=0) {
            [MBProgressHUD showSuccess:@"密码修改成功"];
            [self performSelector:@selector(showLoginUI) withObject:self afterDelay:1.5];
            
        }else{
            [MBProgressHUD showError:@"密码修改失败"];
        }
    } faile:^(NSError *error) {
        [MBProgressHUD showError:@"网络请求错误，请重试"];
        self.nextStepBtn.enabled=YES;
    }];
}
//显示登录界面
-(void) showLoginUI{
    LoginController *loginVC=[[LoginController alloc] init];
    self.view.window.rootViewController=loginVC;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UIView *responderView=[CommonUtil findFirstResponderBeneathView:self.view];
    if (![responderView isExclusiveTouch]) {
        [responderView resignFirstResponder];
    }
}

@end
