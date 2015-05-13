//
//  ArtDescriptionCellFrame.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArtDetail;

#define LabelFont [UIFont systemFontOfSize:15]
#define MarginCellLR 10
#define Margin 5.0

@interface ArtDescriptionCellFrame : NSObject
@property(nonatomic, strong) ArtDetail *artDetail;
@property(nonatomic, assign) CGRect titleF;
@property(nonatomic, assign) CGRect lineF;
@property(nonatomic, assign) CGRect authorF;
@property(nonatomic, assign) CGRect authorValueF;
@property(nonatomic, assign) CGRect sizeF;
@property(nonatomic, assign) CGRect sizeValueF;
@property(nonatomic, assign) CGRect weightF;
@property(nonatomic, assign) CGRect weightValueF;
@property(nonatomic, assign) CGRect createdDateF;
@property(nonatomic, assign) CGRect createdDateValueF;
@property(nonatomic, assign) CGRect uploadDateF;
@property(nonatomic, assign) CGRect uploadDateValueF;
@property(nonatomic, assign) CGRect descriptF;
@property(nonatomic, assign) CGRect descriptValueF;
@property(nonatomic, assign) CGRect marketDescF;
@property(nonatomic, assign) CGRect marketDescValueF;
@property(nonatomic, assign) CGFloat cellHeight;


@end
