//
//  UserToken.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/10.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "UserToken.h"

@implementation UserToken

//格式化过期时间字符串转换日期
-(NSDate *) expirationDate{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    //May 10, 2015 5:45:46 PM
    format.dateFormat=@"MMM dd, yyyy h:mm:ss a";
    NSDate *date=[format dateFromString:_expiration];
    return date;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.expiration forKey:@"expiration"];
    [aCoder encodeObject:self.tokenType forKey:@"tokenType"];
    [aCoder encodeObject:self.refreshToken forKey:@"refreshToken"];
    [aCoder encodeObject:self.scope forKey:@"scope"];
    [aCoder encodeObject:self.savedTime forKey:@"savedTime"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.value=[aDecoder decodeObjectForKey:@"value"];
        self.expiration=[aDecoder decodeObjectForKey:@"expiration"];
        self.tokenType=[aDecoder decodeObjectForKey:@"tokenType"];
        self.refreshToken=[aDecoder decodeObjectForKey:@"refreshToken"];
        self.scope=[aDecoder decodeObjectForKey:@"scope"];
        self.savedTime=[aDecoder decodeObjectForKey:@"savedTime"];
    }
    return self;
}

@end
