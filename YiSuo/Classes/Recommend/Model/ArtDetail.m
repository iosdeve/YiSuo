//
//  ArtDetail.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtDetail.h"
#import "ArtDescriptTitle.h"

@implementation ArtDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.artDesTitle=[[ArtDescriptTitle alloc] init];
    }
    return self;
}

@end
