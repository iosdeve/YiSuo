//
//  ArtDescriptionCell.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/12.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtDescriptionCell.h"

#define LabelFont [UIFont systemFontOfSize:15]
#define Margin 5.0

@interface ArtDescriptionCell ()

@property(nonatomic, weak) UILabel *author;
@property(nonatomic, weak) UILabel *size;
@property(nonatomic, weak) UILabel *weight;
@property(nonatomic, weak) UILabel *createdDate;
@property(nonatomic, weak) UILabel *uploadDate;
@property(nonatomic, weak) UILabel *descript;
@property(nonatomic, weak) UILabel *marketDesc;

@end

@implementation ArtDescriptionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void) setupUI{
    UILabel *titile=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,44.0)];
    titile.text=@"作品介绍";
    [self addSubview:titile];
    
    NSString *authorText=@"作者:";
    CGSize authorSize=[authorText sizeWithFont:LabelFont];
    UILabel *author=[[UILabel alloc] init];
    author.frame=(CGRect){{Margin,Margin},authorSize};
    [self addSubview:author];
    self.author=author;
    
    NSString *sizeText=@"尺寸:";
    CGSize sizeSize=[sizeText sizeWithFont:LabelFont];
    CGFloat sizeY=CGRectGetMaxY(author.frame)+Margin;
    UILabel *size=[[UILabel alloc] init];
    size.frame=(CGRect){{Margin,sizeY},sizeSize};
    [self addSubview:size];
    self.size=size;
    
    NSString *weightText=@"重量:";
    CGSize weightSize=[weightText sizeWithFont:LabelFont];
    CGFloat weightY=CGRectGetMaxY(size.frame)+Margin;
    UILabel *weight=[[UILabel alloc] init];
    weight.frame=(CGRect){{Margin,weightY},weightSize};
    [self addSubview:weight];
    self.weight=weight;
    
    NSString *createdText=@"创作年代:";
    CGSize createdSize=[createdText sizeWithFont:LabelFont];
    CGFloat createdY=CGRectGetMaxY(weight.frame)+Margin;
    UILabel *createdDate=[[UILabel alloc] init];
    createdDate.frame=(CGRect){{Margin,createdY},createdSize};
    [self addSubview:createdDate];
    self.createdDate=createdDate;
    
    NSString *uploadText=@"上架时间:";
    CGSize uploadSize=[uploadText sizeWithFont:LabelFont];
    CGFloat uploadY=CGRectGetMaxY(createdDate.frame)+Margin;
    UILabel *uploadDate=[[UILabel alloc] init];
    uploadDate.frame=(CGRect){{Margin,uploadY},uploadSize};
    [self addSubview:uploadDate];
    self.uploadDate=uploadDate;
    
    NSString *descriptText=@"简介:";
    CGSize descriptSize=[descriptText sizeWithFont:LabelFont];
    CGFloat descriptY=CGRectGetMaxY(uploadDate.frame)+Margin;
    UILabel *descript=[[UILabel alloc] init];
    descript.frame=(CGRect){{Margin,descriptY},descriptSize};
    [self addSubview:descript];
    self.descript=descript;
    
    NSString *marketDescText=@"市场行情:";
    CGSize marketDescSize=[marketDescText sizeWithFont:LabelFont];
    CGFloat marketDescY=CGRectGetMaxY(descript.frame)+Margin;
    UILabel *marketDesc=[[UILabel alloc] init];
    marketDesc.frame=(CGRect){{Margin,marketDescY},marketDescSize};
    [self addSubview:marketDesc];
    self.marketDesc=marketDesc;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
