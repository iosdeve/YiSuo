//
//  ArtCommentCell.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtCommentCell.h"

@implementation ArtCommentCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        MyLog(@"comment cell init");
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(ArtCommentCell *)artCommentCell{
    ArtCommentCell *commentCell=[[NSBundle mainBundle] loadNibNamed:@"ArtCommentCell" owner:nil options:nil][0];
    commentCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return commentCell;
}

@end
