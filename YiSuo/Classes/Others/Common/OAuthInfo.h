//
//  OAuthInfo.h
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// OAuth网络请求相关参数


#define ServerHost @"http://192.168.235.160:8080/"
//检查手机号码是否已经被注册
#define RegistCheckPhoneNum [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/add/1.mapi"]
//检查验证码是否有效
#define RegistCheckVerfiyCode [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/add/2.mapi"]
//注册用户信息
#define RegistUserInfo [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/add/3.mapi"]
//注册用户信息,第三方登录用
#define RegistUserInfoForThirdpartLogin [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/add"]
//忘记密码填写手机号码
#define Forgot_RequestVerfiyCode [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/fp/1.mapi"]
//忘记密码填,校验手机验证码
#define Forgot_CheckVerfiyCode [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/fp/2.mapi"]
//忘记密码填,修改密码
#define Forgot_ChangePassword [NSString stringWithFormat:@"%@%@",ServerHost,@"client/user/fp/3.mapi"]
//用户登录
#define Login_UserToken [NSString stringWithFormat:@"%@%@",ServerHost,@"oauth/token"]