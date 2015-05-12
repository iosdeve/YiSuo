//
//  SearchTextField.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/6.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.背景
        self.font = [UIFont systemFontOfSize:14];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{UITextAttributeTextColor : [UIColor grayColor]}];
        self.background = [UIImage imageResize:@"searchbar_textfield_background"];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        // 2.左边的放大镜
        self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_searchlist_search_icon"]];
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


@end
