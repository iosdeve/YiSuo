//
//  VerifyCodeController.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/5.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeController : UIViewController

@property(nonatomic, copy) NSString *phoneNum;
//标记是否为忘记密码的校验验证码
@property(nonatomic, assign) BOOL isRequestChangePassword;

@end
