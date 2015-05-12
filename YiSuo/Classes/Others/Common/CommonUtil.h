//
//  CommonUtil.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/6.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserToken;

#define ArchiveAccountPath [DocumentPath stringByAppendingPathComponent:@"account.data"]

@interface CommonUtil : NSObject

/**
 *  获取一个view中第一响应者
 *
 *  @param view
 *
 *  @return
 */
+(UIView*)findFirstResponderBeneathView:(UIView*) view;

/**
 *  校验手机号码
 */
+(BOOL)validateMobile:(NSString *)mobileNum;

/**
 *  保存UserToken对象到文件
 */
+(void) saveUserToken:(UserToken *) userToken;

/**
 *  从文件中获取保存到UserToken
 */
+(UserToken *) getUserToken;

@end
