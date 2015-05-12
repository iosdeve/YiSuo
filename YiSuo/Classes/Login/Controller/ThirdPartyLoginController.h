//
//  ThirdPartyLoginController.h
//  YiSuo
//
//  Created by 陈欣 on 15/4/27.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <UIKit/UIKit.h>

//第三方账号类型
typedef enum : NSUInteger {
    LoginTypeQQ,
    LoginTypeWexin,
    LoginTypeSina,
} LoginType;

@interface ThirdPartyLoginController : UIViewController

//第三方账号类型
@property(nonatomic, assign) LoginType loginType;

@end
