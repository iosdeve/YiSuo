//
//  LoginController.m
//  YiSuo
//
//  Created by 陈欣 on 15/4/26.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "LoginController.h"
#import "ThirdPartyLoginController.h"
#import "CustomTextField.h"
#import "RegistController.h"
#import "CommonUtil.h"
#import "CustomTabBarController.h"
#import "FindPasswordController.h"
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"
#import "OAuthInfo.h"
#import "MJExtension.h"
#import "UserToken.h"

@interface LoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (weak, nonatomic) IBOutlet CustomTextField *userName;
@property (weak, nonatomic) IBOutlet CustomTextField *userPwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotPwd;

@property (strong, nonatomic) NSArray *textFields;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    //如果不是3.5英寸，布局整体下移，适配不同尺寸iphone
    if (is47Inch||is55Inch||is4Inch) {
        self.topCons.constant+=40;
    }
    
    [self setupUI];
}

/**
 *  设置UI背景相关图片
 */
-(void) setupUI{
    self.userName.background=[UIImage imageResize:@"input_bg"];
    self.userPwd.background=[UIImage imageResize:@"input_bg"];
    self.userName.delegate=self;
    self.userPwd.delegate=self;
    self.textFields=@[self.userName,self.userPwd];
    [self.loginBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateNormal];
    [self.registBtn setBackgroundImage:[UIImage imageResize:@"regist_btn"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageResize:@"button_bg"] forState:UIControlStateHighlighted];
    [self.registBtn setBackgroundImage:[UIImage imageResize:@"regist_btn"] forState:UIControlStateHighlighted];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotPwd addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//点击login
-(void) login{
    if (self.userName.text.length<1) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }else if(self.userPwd.text.length<6){
        [MBProgressHUD showError:@"密码必须大于6位"];
        return;
    }
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"client_id"]=@"mobile_yisuo";
    parameters[@"client_secret"]=@"secret_yisuo";
    parameters[@"grant_type"]=@"password";
    parameters[@"username"]=self.userName.text;
    parameters[@"password"]=self.userPwd.text;
    [MBProgressHUD showMessage:@"登录中..."];
    [HttpTool postURL:Login_UserToken parameter:parameters success:^(id responseObject) {
        UserToken *userToken=[UserToken objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUD];
        [CommonUtil saveUserToken:userToken];
        CustomTabBarController *tabBarVC=[[CustomTabBarController alloc] init];
        self.view.window.rootViewController=tabBarVC;
        MyLog(@"userToken--%@",userToken);
        
    } faile:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"用户名或密码错误"];
        MyLog(@"error--%@",error);
    }];
}

//点击忘记密码
-(void) forgotPasswordBtnClick{
    FindPasswordController *findPwdVC=[[FindPasswordController alloc] init];
    [self.navigationController pushViewController:findPwdVC animated:YES];
}

/**
 *  QQ登录
 */
- (IBAction)loginWithQQ:(id)sender {
    ThirdPartyLoginController *thirdPartyLoginVC=[[ThirdPartyLoginController alloc] init];
    thirdPartyLoginVC.loginType=LoginTypeQQ;
    [self.navigationController pushViewController:thirdPartyLoginVC animated:YES];
}

/**
 *  微信登录
 */
- (IBAction)loginWithWexin:(id)sender {
}

/**
 *  新浪登录
 */
- (IBAction)loginWithSina:(id)sender {
    ThirdPartyLoginController *thirdPartyLoginVC=[[ThirdPartyLoginController alloc] init];
    thirdPartyLoginVC.loginType=LoginTypeSina;
    [self.navigationController pushViewController:thirdPartyLoginVC animated:YES];
}

- (IBAction)registClick:(id)sender {
    RegistController *registVC=[[RegistController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField==self.userPwd){
        [self.userPwd resignFirstResponder];
        [self login];
        return YES;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
