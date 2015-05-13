//
//  ArtDescriptionCellFrame.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/13.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtDescriptionCellFrame.h"
#import "ArtDescriptTitle.h"
#import "ArtDetail.h"

@implementation ArtDescriptionCellFrame

-(void)setArtDetail:(ArtDetail *)artDetail{
    _artDetail=artDetail;
    CGFloat cellWidth=ScreenWidth;
    CGFloat titleW=cellWidth-2*MarginCellLR;
    CGFloat titleX=MarginCellLR;
    _titleF=CGRectMake(MarginCellLR, MarginCellLR+5, titleW, 30);
    CGFloat lineY=CGRectGetMaxY(_titleF);
    _lineF=CGRectMake(titleX, lineY, titleW, 2);
    //作者
    CGSize authorSize=[artDetail.artDesTitle.author sizeWithFont:LabelFont];
    CGFloat authorY=CGRectGetMaxY(_lineF)+Margin;
    CGFloat authorX=MarginCellLR;
    _authorF=(CGRect){{MarginCellLR,authorY},authorSize};
    CGFloat authorValueW=cellWidth-CGRectGetMaxX(_authorF)-MarginCellLR-Margin;
    CGSize authorValueSize=[artDetail.name sizeWithFont:LabelFont constrainedToSize:CGSizeMake(authorValueW, MAXFLOAT)];
    CGFloat authorValueX=CGRectGetMaxX(_authorF)+Margin;
    _authorValueF=CGRectMake(authorValueX, authorY, authorValueW,authorValueSize.height);
    
    //尺寸
    CGFloat sizeY=MAX(CGRectGetMaxY(_authorF),CGRectGetMaxY(_authorValueF))+Margin;
    CGSize sizeSize=[artDetail.artDesTitle.size sizeWithFont:LabelFont];
    _sizeF=(CGRect){{authorX,sizeY},sizeSize};
    CGFloat sizeValueW=cellWidth-CGRectGetMaxX(_sizeF)-MarginCellLR-Margin;
    CGSize sizeValueSize=[artDetail.size sizeWithFont:LabelFont constrainedToSize:CGSizeMake(sizeValueW, MAXFLOAT)];
    CGFloat sizeValueX=CGRectGetMaxX(_sizeF)+Margin;
    _sizeValueF=CGRectMake(sizeValueX, sizeY, sizeValueW, sizeValueSize.height);
    self.cellHeight=CGRectGetMaxY(_sizeValueF)+Margin;
    
    //重量
    CGFloat weightY=MAX(CGRectGetMaxY(_sizeF),CGRectGetMaxY(_sizeValueF))+Margin;
    CGSize weightSize=[artDetail.artDesTitle.weight sizeWithFont:LabelFont];
    _weightF=(CGRect){{authorX,weightY},weightSize};
    CGFloat weightValueW=cellWidth-CGRectGetMaxX(_weightF)-MarginCellLR-Margin;
    CGSize weightValueSize=[artDetail.weight sizeWithFont:LabelFont constrainedToSize:CGSizeMake(weightValueW, MAXFLOAT)];
    CGFloat weightValueX=CGRectGetMaxX(_weightF)+Margin;
    _weightValueF=CGRectMake(weightValueX, weightY, weightValueW, weightValueSize.height);
    
    //创作年代
    CGFloat createdDateY=MAX(CGRectGetMaxY(_weightF),CGRectGetMaxY(_weightValueF))+Margin;
    CGSize createdDateSize=[artDetail.artDesTitle.createdDate sizeWithFont:LabelFont];
    _createdDateF=(CGRect){{authorX,createdDateY},createdDateSize};
    CGFloat createdDateValueW=cellWidth-CGRectGetMaxX(_createdDateF)-MarginCellLR-Margin;
    CGSize createdDateValueSize=[artDetail.createDate sizeWithFont:LabelFont constrainedToSize:CGSizeMake(createdDateValueW, MAXFLOAT)];
    CGFloat createdDateValueX=CGRectGetMaxX(_createdDateF)+Margin;
    _createdDateValueF=CGRectMake(createdDateValueX, createdDateY, createdDateValueW, createdDateValueSize.height);
    MyLog(@"_createdDateValueF%@",NSStringFromCGRect(_createdDateValueF));
    
    //上架时间
    CGFloat uploadDateY=MAX(CGRectGetMaxY(_createdDateF),CGRectGetMaxY(_createdDateValueF))+Margin;
    CGSize uploadDateSize=[artDetail.artDesTitle.uploadDate sizeWithFont:LabelFont];
    _uploadDateF=(CGRect){{authorX,uploadDateY},uploadDateSize};
    CGFloat uploadDateValueW=cellWidth-CGRectGetMaxX(_uploadDateF)-MarginCellLR-Margin;
    CGSize uploadDateValueSize=[artDetail.uploadDate sizeWithFont:LabelFont constrainedToSize:CGSizeMake(createdDateValueW, MAXFLOAT)];
    CGFloat uploadDateValueX=CGRectGetMaxX(_uploadDateF)+Margin;
    _uploadDateValueF=CGRectMake(uploadDateValueX, uploadDateY, uploadDateValueW, uploadDateValueSize.height);
    
    //简介
    CGFloat descriptY=MAX(CGRectGetMaxY(_uploadDateF),CGRectGetMaxY(_uploadDateF))+Margin;
    CGSize descriptSize=[artDetail.artDesTitle.descript sizeWithFont:LabelFont];
    _descriptF=(CGRect){{authorX,descriptY},descriptSize};
    CGFloat descriptValueW=cellWidth-2*MarginCellLR;
    CGSize descriptValueSize=[artDetail.descript sizeWithFont:LabelFont constrainedToSize:CGSizeMake(descriptValueW, MAXFLOAT)];
    CGFloat descriptValueY=CGRectGetMaxY(_descriptF)+Margin;
    _descriptValueF=CGRectMake(authorX, descriptValueY, descriptValueW, descriptValueSize.height+Margin);
    
    //市场行情
    CGFloat marketDescY=MAX(CGRectGetMaxY(_descriptF),CGRectGetMaxY(_descriptValueF))+Margin;
    CGSize marketDescSize=[artDetail.artDesTitle.marketDesc sizeWithFont:LabelFont];
    _marketDescF=(CGRect){{authorX,marketDescY},marketDescSize};
    CGFloat marketDescValueW=cellWidth-2*MarginCellLR;
    CGSize marketDescValueSize=[artDetail.marketQuotation sizeWithFont:LabelFont constrainedToSize:CGSizeMake(marketDescValueW, MAXFLOAT)];
    CGFloat marketDescValueY=CGRectGetMaxY(_marketDescF)+Margin;
    _marketDescValueF=CGRectMake(authorX, marketDescValueY, marketDescValueW, marketDescValueSize.height);
    
    _cellHeight=CGRectGetMaxY(_marketDescValueF)+MarginCellLR;
   
}



@end
