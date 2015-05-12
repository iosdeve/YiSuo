//
//  ArtViewCell.h
//  YiSuo
//
//  Created by 陈欣 on 15/5/7.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArtCellModel;

@interface ArtViewCell : UICollectionViewCell

@property(nonatomic, strong) ArtCellModel *artCellModel;
@property (weak, nonatomic) IBOutlet UILabel *artName;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
