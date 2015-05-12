//
//  FindPasswordController.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/6.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "FindPasswordController.h"
#import "CustomTextField.h"
#import "ChangePasswordController.h"
#import "OAuthInfo.h"
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"
#import "ChangePasswordController.h"
#import "VerifyCodeController.h"
#import "CommonUtil.h"

@interface FindPasswordController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CustomTextField *phoneNum;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@end

@implementation FindPasswordController

- (void)viewDidLoad {
    self.title=@"找回密码";
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupUI{
    self.phoneNum.placeHolderColor=[UIColor darkGrayColor];
    self.phoneNum.background=[UIImage imageResize:@"input_bg2"];
    self.phoneNum.delegate=self;
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateHighlighted];
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

-(void) nextStepBtnClick{
    BOOL validatePhone=[CommonUtil validateMobile:self.phoneNum.text];
    if (validatePhone==NO) {
        [MBProgressHUD showError:@"无效的手机号码"];
        return;
    }
    self.nextStepBtn.enabled=NO;
    [HttpTool postURL:Forgot_RequestVerfiyCode parameter:@{@"t":self.phoneNum.text} success:^(id responseObject) {
        self.nextStepBtn.enabled=YES;
        NSInteger valid=[responseObject[@"result"] integerValue];
        if (valid!=0){
            VerifyCodeController *verifyCodeVC=[[VerifyCodeController alloc] init];
            verifyCodeVC.isRequestChangePassword=YES;
            verifyCodeVC.phoneNum=self.phoneNum.text;
            [self.navigationController pushViewController:verifyCodeVC animated:YES];
        }else{
            [MBProgressHUD showError:@"手机号码不存在"];
        }
    } faile:^(NSError *error) {
        [MBProgressHUD showError:@"网络请求错误，请重试"];
        self.nextStepBtn.enabled=YES;
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.phoneNum resignFirstResponder];
    [self nextStepBtnClick];
    return YES;
}

@end
