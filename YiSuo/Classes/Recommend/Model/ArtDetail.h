//
//  ArtDetail.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArtDescriptTitle;

@interface ArtDetail : NSObject

@property(nonatomic, assign) long ID;
@property(nonatomic, copy) NSString *picture;
@property(nonatomic, copy) NSString *video;
@property(nonatomic, assign) long viewCount;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *descript;
@property(nonatomic, copy) NSString *size;
@property(nonatomic, copy) NSString *weight;
@property(nonatomic, copy) NSString *marketQuotation;
@property(nonatomic, copy) NSString *createDate;
@property(nonatomic, copy) NSString *uploadDate;

@property(nonatomic, strong) ArtDescriptTitle *artDesTitle;

@end
