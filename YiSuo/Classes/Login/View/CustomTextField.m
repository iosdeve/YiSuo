//
//  CustomTextField.m
//  YiSuo
//
//  Created by 陈欣 on 15/4/26.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "CustomTextField.h"

#define PlaceHolderFont [UIFont systemFontOfSize:15]
#define TextLeftMargin 10.0

@implementation CustomTextField

//设置placeholder距离左边间距10px，并且文字垂直对齐
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGFloat xMargin=TextLeftMargin;
    CGSize size=[self.placeholder sizeWithFont:PlaceHolderFont];
    CGFloat yMargin=(bounds.size.height-size.height)/2+2;
    CGRect inset = CGRectMake(bounds.origin.x+xMargin, bounds.origin.y+yMargin, bounds.size.width, bounds.size.height);
    return inset;
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect{
    if (self.placeHolderColor==nil) {
        self.placeHolderColor=[UIColor whiteColor];
    }
    [self.placeHolderColor setFill];
    [[self placeholder] drawInRect:rect withFont:PlaceHolderFont];
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+TextLeftMargin, bounds.origin.y, bounds.size.width -TextLeftMargin, bounds.size.height);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x +TextLeftMargin, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

@end
