//
//  ArtDescriptionCell.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/12.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtDescriptionCell.h"
#import "ArtDescriptionCellFrame.h"
#import "ArtDescriptTitle.h"
#import "ArtDetail.h"

@interface ArtDescriptionCell ()
@property(nonatomic, weak) UILabel *title;
@property(nonatomic, weak) UILabel *author;
@property(nonatomic, weak) UILabel *authorValue;

@property(nonatomic, weak) UILabel *size;
@property(nonatomic, weak) UILabel *sizeValue;

@property(nonatomic, weak) UILabel *weight;
@property(nonatomic, weak) UILabel *weightValue;
@property(nonatomic, weak) UILabel *createdDate;
@property(nonatomic, weak) UILabel *createdDateValue;
@property(nonatomic, weak) UILabel *uploadDate;
@property(nonatomic, weak) UILabel *uploadDateValue;
@property(nonatomic, weak) UILabel *descript;
@property(nonatomic, weak) UILabel *descriptValue;
@property(nonatomic, weak) UILabel *marketDesc;
@property(nonatomic, weak) UILabel *marketDescValue;
@property(nonatomic, weak) UILabel *line;

@end

@implementation ArtDescriptionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void) setupUI{
    UILabel *title=[[UILabel alloc] init];
    title.textColor=MyColor(33, 67, 112);
    title.text=@"作品介绍";
    [self.contentView addSubview:title];
    self.title=title;
    UILabel *line=[[UILabel alloc] init];
    line.backgroundColor=MyColor(228, 228, 228);
    [self.contentView addSubview:line];
    self.line=line;

    //作者
    UILabel *author=[[UILabel alloc] init];
    [self.contentView addSubview:author];
    self.author=author;
    
    UILabel *authorValue=[[UILabel alloc] init];
    authorValue.numberOfLines=0;
    [self.contentView addSubview:authorValue];
    self.authorValue=authorValue;

    

    UILabel *size=[[UILabel alloc] init];
    [self.contentView addSubview:size];
    self.size=size;
    
    UILabel *sizeValue=[[UILabel alloc] init];
    sizeValue.numberOfLines=0;
    [self.contentView addSubview:sizeValue];
    self.sizeValue=sizeValue;
    
    UILabel *weight=[[UILabel alloc] init];
    [self.contentView addSubview:weight];
    self.weight=weight;
    
    UILabel *weightValue=[[UILabel alloc] init];
    weightValue.numberOfLines=0;
    [self.contentView addSubview:weightValue];
    self.weightValue=weightValue;
    
    UILabel *createdDate=[[UILabel alloc] init];
    [self.contentView addSubview:createdDate];
    self.createdDate=createdDate;
    
    UILabel *createdDateValue=[[UILabel alloc] init];
    createdDateValue.numberOfLines=0;
    [self.contentView addSubview:createdDateValue];
    createdDateValue.text=@"ssss";
    self.createdDateValue=createdDateValue;
    
    UILabel *uploadDate=[[UILabel alloc] init];
    [self.contentView addSubview:uploadDate];
    self.uploadDate=uploadDate;
    
    UILabel *uploadDateValue=[[UILabel alloc] init];
    uploadDateValue.numberOfLines=0;
    [self.contentView addSubview:uploadDateValue];
    self.uploadDateValue=uploadDateValue;
    

    UILabel *descript=[[UILabel alloc] init];
    [self.contentView addSubview:descript];
    self.descript=descript;
    
    UILabel *descriptValue=[[UILabel alloc] init];
    descriptValue.numberOfLines=0;
    [self.contentView addSubview:descriptValue];
    self.descriptValue=descriptValue;
    

    UILabel *marketDesc=[[UILabel alloc] init];
    [self.contentView addSubview:marketDesc];
    self.marketDesc=marketDesc;
    
    UILabel *marketDescValue=[[UILabel alloc] init];
    marketDescValue.numberOfLines=0;
    [self.contentView addSubview:marketDescValue];
    self.marketDescValue=marketDescValue;
}

-(void)setCellFrame:(ArtDescriptionCellFrame *)cellFrame{
    _cellFrame=cellFrame;
    self.title.font=LabelFont;
    self.author.font=LabelFont;
    self.authorValue.font=LabelFont;
    self.size.font=LabelFont;
    self.sizeValue.font=LabelFont;
     self.weight.font=LabelFont;
     self.weightValue.font=LabelFont;
     self.createdDate.font=LabelFont;
     self.createdDateValue.font=LabelFont;
     self.uploadDate.font=LabelFont;
    self.uploadDateValue.font=LabelFont;
    self.descript.font=LabelFont;
    self.descriptValue.font=LabelFont;
    self.marketDesc.font=LabelFont;
    self.marketDescValue.font=LabelFont;
    
    self.title.frame=cellFrame.titleF;
    self.line.frame=cellFrame.lineF;
    self.author.frame=cellFrame.authorF;
    self.author.text=cellFrame.artDetail.artDesTitle.author;
    self.authorValue.frame=cellFrame.authorValueF;
    self.authorValue.text=cellFrame.artDetail.name;
    self.size.frame=cellFrame.sizeF;
    self.size.text=cellFrame.artDetail.artDesTitle.size;
    self.sizeValue.frame=cellFrame.sizeValueF;
    self.sizeValue.text=cellFrame.artDetail.size;
    
    self.weight.frame=cellFrame.weightF;
    self.weight.text=cellFrame.artDetail.artDesTitle.weight;
    self.weightValue.frame=cellFrame.weightValueF;
    self.weightValue.text=cellFrame.artDetail.weight;
    
    self.createdDate.frame=cellFrame.createdDateF;
    self.createdDate.text=cellFrame.artDetail.artDesTitle.createdDate;
    self.createdDateValue.frame=cellFrame.createdDateValueF;
    self.createdDateValue.text=cellFrame.artDetail.createDate;
    
    self.uploadDate.frame=cellFrame.uploadDateF;
    self.uploadDate.text=cellFrame.artDetail.artDesTitle.uploadDate;
    self.uploadDateValue.frame=cellFrame.uploadDateValueF;
    self.uploadDateValue.text=cellFrame.artDetail.uploadDate;
    
    self.descript.frame=cellFrame.descriptF;
    self.descript.text=cellFrame.artDetail.artDesTitle.descript;
    self.descriptValue.frame=cellFrame.descriptValueF;
    self.descriptValue.text=cellFrame.artDetail.descript;
    
    self.marketDesc.frame=cellFrame.marketDescF;
    self.marketDesc.text=cellFrame.artDetail.artDesTitle.marketDesc;
    self.marketDescValue.frame=cellFrame.marketDescValueF;
    self.marketDescValue.text=cellFrame.artDetail.marketQuotation;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
