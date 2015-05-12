//
//  CommonUtil.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/6.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "CommonUtil.h"
#import "UserToken.h"

@implementation CommonUtil

/**
 *  获取一个view中第一响应者
 *
 *  @param view
 *
 *  @return
 */
+(UIView*)findFirstResponderBeneathView:(UIView*) view{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
            return childView;
        UIView *result = [CommonUtil findFirstResponderBeneathView:childView];
        if ( result )
            return result;
    }
    return nil;
}
/**
 *  校验手机号码
 */
+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  保存UserToken对象到文件
 */
+(void) saveUserToken:(UserToken *) userToken{
    userToken.savedTime=[NSDate date];
    [NSKeyedArchiver archiveRootObject:userToken toFile:ArchiveAccountPath];
    MyLog(@"userToken path:%@",ArchiveAccountPath);
}

/**
 *  从文件中获取保存到Account
 */
/**
 *  从文件中获取保存到UserToken
 */
+(UserToken *) getUserToken{
    MyLog(@"userToken path:%@",ArchiveAccountPath);
    UserToken *userToken=[NSKeyedUnarchiver unarchiveObjectWithFile:ArchiveAccountPath];
    NSDate *now=[NSDate date];
    //计算出token过期时间
    NSDate *expireDate=[userToken expirationDate];
    //如果过期时间大于现在时间，返回account，否则返回null
    if ([expireDate compare:now]==NSOrderedDescending) {
        return userToken;
    }
    return nil;
}


@end
