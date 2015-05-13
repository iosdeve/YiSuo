//
//  ArtCommentCell.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *created;
@property (weak, nonatomic) IBOutlet UILabel *comment;

+(ArtCommentCell *) artCommentCell;

@end
