//
//  ArtMovieCell.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/12.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtMovieCell.h"
#import "ALMoviePlayerController.h"

@interface ArtMovieCell ()
@property (weak, nonatomic) IBOutlet UIView *artMovieView;

@end

@implementation ArtMovieCell

+(ArtMovieCell *) artMovieCell{
    ArtMovieCell *cell=[[NSBundle mainBundle] loadNibNamed:@"ArtMovieCell" owner:nil options:nil][0];
    //设置单元选中无背景高亮
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)awakeFromNib{
    
    CGFloat screenWidth=[UIScreen mainScreen].applicationFrame.size.width;
    ALMoviePlayerController *moviePlayerVC=[[ALMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth)];
//    moviePlayerVC.view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    //moviePlayerVC.view.alpha = 1.0f;
        //create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:moviePlayerVC style:ALMoviePlayerControlsStyleDefault];
    //[movieControls setAdjustsFullscreenImage:NO];
    //设置进度条背景颜色
    [movieControls setBarColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [movieControls setTimeRemainingDecrements:YES];
    //设置进度条消失时间
    [movieControls setFadeDelay:4.0];
    [movieControls setBarHeight:25.f];
    [moviePlayerVC setControls:movieControls];
    [self.artMovieView addSubview:moviePlayerVC.view];
    self.moviePlayerVC=moviePlayerVC;
//
    [moviePlayerVC setContentURL:[NSURL URLWithString:@"http://192.168.235.160:8080/upload/videos/2015/4/11/48ec861d-2d71-428f-ba5d-fa47805cb4e8_1.mp4"]];
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMoive:)];
//    [self.artMovieView addGestureRecognizer:tap];
}

-(void)setMovieFrame{
    MyLog(@"movie frame %@",NSStringFromCGRect(self.artMovieView.frame));
    [self.moviePlayerVC setFrame:self.artMovieView.bounds];
    [self.moviePlayerVC setContentURL:[NSURL URLWithString:@"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]];
}
-(void) clickMoive:(UITapGestureRecognizer *) tap{
    MyLog(@"movie frame %@",NSStringFromCGRect(self.artMovieView.frame));
}
@end
