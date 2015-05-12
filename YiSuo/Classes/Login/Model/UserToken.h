//
//  UserToken.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/10.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserToken : NSObject <NSCoding>

@property(nonatomic, copy) NSString *value;
@property(nonatomic, copy) NSString *expiration;
@property(nonatomic, copy) NSString *tokenType;
@property(nonatomic, strong) UserToken *refreshToken;
@property(nonatomic, strong) NSDictionary *scope;
//归档的时间
@property(nonatomic, strong) NSDate *savedTime;

//格式化过期时间字符串转换日期
-(NSDate *) expirationDate;

@end
