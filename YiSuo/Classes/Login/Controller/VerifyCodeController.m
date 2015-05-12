//
//  VerifyCodeController.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/5.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "VerifyCodeController.h"
#import "CustomTextField.h"
#import "RegistInfoController.h"
#import "HttpTool.h"
#import "OAuthInfo.h"
#import "MBProgressHUD+MJ.h"
#import "ChangePasswordController.h"

#define RequestVerfiyCodeInterval 10

@interface VerifyCodeController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CustomTextField *verifyCode;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (strong, nonatomic) NSTimer *resendTimer;
@property (weak, nonatomic) IBOutlet UILabel *tipMsg;

@property (assign, nonatomic) int waitTime;

@end

@implementation VerifyCodeController

- (void)viewDidLoad {
    self.title=@"请填写验证码";
    self.waitTime=RequestVerfiyCodeInterval;
    [super viewDidLoad];
    [self setupUI];
    [self resendVerfiyCodeTimer];
}

-(void) setupUI{
    self.verifyCode.background=[UIImage imageResize:@"input_bg2"];
    self.verifyCode.delegate=self;
    [self.sendBtn setBackgroundImage:[UIImage imageResize:@"button_bg2"] forState:UIControlStateNormal];
    [self.sendBtn setBackgroundImage:[UIImage imageResize:@"button_bg2"] forState:UIControlStateHighlighted];
    [self.sendBtn addTarget:self action:@selector(requestVerfiyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateHighlighted];
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tipMsg.text=[NSString stringWithFormat:@"请输入%@收到的验证码",self.phoneNum];
}
//定时器显示还有多久可以请求验证码
-(void) resendVerfiyCodeTimer{
    self.sendBtn.enabled=NO;
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshBtnText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.resendTimer=timer;
}

//定时器调用的方法，倒计时显示，多久后可以请求发送验证码
-(void) refreshBtnText{
    self.waitTime--;
    [self.sendBtn setTitle:[NSString stringWithFormat:@"%ds后重发", self.waitTime] forState:UIControlStateNormal];
    if (self.waitTime==0) {
        [self.resendTimer invalidate];
        self.waitTime=RequestVerfiyCodeInterval;
        self.sendBtn.enabled=YES;
        [self.sendBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    }
}

//请求验证码
-(void) requestVerfiyCode{
    [self resendVerfiyCodeTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) nextStepBtnClick{
    self.nextStepBtn.enabled=NO;
    NSString *url=self.isRequestChangePassword?Forgot_CheckVerfiyCode:RegistCheckVerfiyCode;
    [HttpTool postURL:url parameter:@{@"t":self.phoneNum,@"code":self.verifyCode.text} success:^(id responseObject) {
        self.nextStepBtn.enabled=YES;
        MyLog(@"--%@",responseObject);
        NSString *result=responseObject[@"result"];
        if ([@"-1" isEqualToString:result]) {
            [MBProgressHUD showError:@"验证码错误"];
        }else{
            //如果是请求修改密码
            if (self.isRequestChangePassword) {
                ChangePasswordController *cpVC=[[ChangePasswordController alloc] init];
                cpVC.uuid=result;
                cpVC.phoneNum=self.phoneNum;
                [self.navigationController pushViewController:cpVC animated:YES];
            } else{//如果是请求注册
                RegistInfoController *registInfoVC=[[RegistInfoController alloc] init];
                registInfoVC.uuid=result;
                registInfoVC.phoneNum=self.phoneNum;
                [self.navigationController pushViewController:registInfoVC animated:YES];
            }
        }
        
        
    } faile:^(NSError *error) {
        self.nextStepBtn.enabled=YES;
    }];
}

//关闭键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![self.verifyCode isExclusiveTouch]) {
        [self.verifyCode resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.verifyCode resignFirstResponder];
    [self nextStepBtnClick];
    return YES;
}

@end
