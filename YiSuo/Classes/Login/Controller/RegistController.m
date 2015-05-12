//
//  RegistController.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/5.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "RegistController.h"
#import "VerifyCodeController.h"
#import "HttpTool.h"
#import "OAuthInfo.h"
#import "CommonUtil.h"
#import "MBProgressHUD+MJ.h"

@interface RegistController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoheNum;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation RegistController

- (void)viewDidLoad {
    self.title=@"注册";
    [super viewDidLoad];
    [self setupUI];
}

-(void) setupUI{
    self.phoheNum.background=[UIImage imageResize:@"input_bg2"];
    self.phoheNum.delegate=self;
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateHighlighted];
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) nextStepBtnClick{
    BOOL validatePhone=[CommonUtil validateMobile:self.phoheNum.text];
    if (validatePhone==NO) {
        [MBProgressHUD showError:@"无效的手机号码"];
        return;
    }
    NSDictionary *parameter=@{@"t":self.phoheNum.text};
    self.nextStepBtn.enabled=NO;
    [HttpTool postURL:RegistCheckPhoneNum parameter:parameter success:^(id responseObject) {
        self.nextStepBtn.enabled=YES;
        MyLog(@"--%@",responseObject);
        NSInteger valid=[responseObject[@"result"] integerValue];
        if (valid!=0) {
            VerifyCodeController *verifyCodeVC=[[VerifyCodeController alloc] init];
            verifyCodeVC.phoneNum=self.phoheNum.text;
            [self.navigationController pushViewController:verifyCodeVC animated:YES];
        }else{
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"手机号码已被注册" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        
    } faile:^(NSError *error) {
        [MBProgressHUD showError:@"网络请求错误，请重试"];
        self.nextStepBtn.enabled=YES;
    }];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![self.phoheNum isExclusiveTouch]) {
        [self.phoheNum resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.phoheNum resignFirstResponder];
    [self nextStepBtnClick];
    return YES;
}


@end
