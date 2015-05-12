//
//  ArtMovieCell.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/12.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALMoviePlayerController;

@interface ArtMovieCell : UITableViewCell

@property (strong, nonatomic) ALMoviePlayerController *moviePlayerVC;

+(ArtMovieCell *) artMovieCell;

-(void) setMovieFrame;

@end
