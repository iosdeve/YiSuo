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

@interface ArtDetailController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) ArtMovieCell *artMovieCell;

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
