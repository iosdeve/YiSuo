//
//  ArtViewCell.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/7.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtViewCell.h"
#import "ArtCellModel.h"

@implementation ArtViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setArtCellModel:(ArtCellModel *)artCellModel{
    _artCellModel=artCellModel;
    self.artName.text=artCellModel.artName;
    self.playCount.text=[NSString stringWithFormat:@"%ld",artCellModel.playCount];
    self.imageView.image=[UIImage imageNamed:artCellModel.imageName];
}

@end
