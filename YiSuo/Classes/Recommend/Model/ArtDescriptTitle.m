//
//  ArtDescriptTitle.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtDescriptTitle.h"

@implementation ArtDescriptTitle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.author=@"作者:";
        self.size=@"尺寸:";
        self.weight=@"重量:";
        self.createdDate=@"创作年代:";
        self.uploadDate=@"上架时间:";
        self.descript=@"简介:";
        self.marketDesc=@"市场行情:";
        
    }
    return self;
}

@end
