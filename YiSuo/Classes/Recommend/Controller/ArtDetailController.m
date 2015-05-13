//
//  ArtDetailController.m
//  YiSuo
//
//  Created by 陈欣 on 15/5/12.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ArtDetailController.h"
#import "ArtMovieCell.h"
#import "ALMoviePlayerController.h"
#import "ArtDetail.h"
#import "ArtDescriptTitle.h"
#import "ArtDescriptionCellFrame.h"
#import "ArtDescriptionCell.h"

@interface ArtDetailController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) ArtMovieCell *artMovieCell;
@property(nonatomic, strong) ArtDescriptionCell *descriptCell;

@end

@implementation ArtDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

-(void) setupTableView{
    UITableView *tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView=tableView;
    [self.view addSubview:tableView];
    
    ArtMovieCell *artMovieCell=[ArtMovieCell artMovieCell];
    self.artMovieCell=artMovieCell;
    
    ArtDescriptionCell *descriptCell=[[ArtDescriptionCell alloc] init];
    ArtDescriptionCellFrame *descriptCellFrame=[[ArtDescriptionCellFrame alloc] init];
    ArtDetail *detail=[[ArtDetail alloc] init];
    detail.name=@"马踏飞燕";
    detail.size=@"100*100*100";
    detail.weight=@"200T";
    detail.createDate=@"2015/10/15";
    detail.uploadDate=@"2011/11/20";
    detail.descript=@"克强总理12日出席全国推进简政放权放管结合职能转变工作电视电话会议时说，新时期的深化行政体制改革、转变政府职能要简政放权、放管结合、优化服务同时推进，加快建设法治政府、创新政府、廉洁政府、服务型政府，逐步实现政府治理能力现代化。";
    detail.marketQuotation=@"一批审批过程中的繁文缛节，再砍掉一批企业登记注册和办事的关卡，再砍掉一批不合法不合规不合理的收费。";
    descriptCellFrame.artDetail=detail;
    descriptCell.cellFrame=descriptCellFrame;
    self.descriptCell=descriptCell;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.artMovieCell setMovieFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section>1 ? 10 :1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [UIScreen mainScreen].applicationFrame.size.width+44;
    }else if(indexPath.section==1){
        MyLog(@"descript cell height %f",self.descriptCell.cellFrame.cellHeight);
        return self.descriptCell.cellFrame.cellHeight;
    }
    return 44.0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifer=@"commentCell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifer];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifer];
//        cell.textLabel.text=@"test";
//    }
//    return cell;
    if (indexPath.section==0) {
        return self.artMovieCell;
    }else if(indexPath.section==1){
        return self.descriptCell;
    }else{
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifer];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifer];
            cell.textLabel.text=@"test";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

@end
