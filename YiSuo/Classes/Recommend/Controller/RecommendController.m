//
//  RecommendController.m
//  YiSuo
//
//  Created by 陈欣 on 15/4/26.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "RecommendController.h"
#import "SearchTextField.h"
#import "ArtCellModel.h"
#import "ArtViewCell.h"
#import "ArtDetailController.h"

#define SearchBarHeight 44.0
#define CellLineMargin 5

@interface RecommendController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray *artDataArray;
@property(nonatomic, weak) SearchTextField *searchField;
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation RecommendController
static NSString *const ID = @"artCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchTextField];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupSearchTextField{
    UIView *searchBar=[[UIView alloc] init];
    CGFloat width=self.view.frame.size.width;
    searchBar.frame=CGRectMake(0, 0, width, SearchBarHeight);
    searchBar.backgroundColor=[UIColor blackColor];
    SearchTextField *searchField=[[SearchTextField alloc] init];
    CGFloat margin=5;
    searchField.frame=CGRectMake(margin, margin, width-2*margin, SearchBarHeight-2*margin);
    searchField.delegate=self;
    [searchBar addSubview:searchField];
    self.searchField=searchField;
    [self.view addSubview:searchBar];
}

-(void) setupCollectionView{
    CGRect collectViewFrame=CGRectMake(0, SearchBarHeight, self.view.frame.size.width, self.view.frame.size.height-SearchBarHeight);
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    CGFloat cellHW=(self.view.frame.size.width-CellLineMargin)/2;
    MyLog(@"%f",cellHW);
    flowLayout.itemSize=CGSizeMake(cellHW, cellHW);
    flowLayout.minimumLineSpacing=CellLineMargin;
    flowLayout.minimumInteritemSpacing=CellLineMargin;
    //collection view底部空出一部分距离，防止tabBar遮挡
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 54, 0);
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:collectViewFrame collectionViewLayout:flowLayout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    collectionView.backgroundColor=MyColor(32, 67, 117);
    //设置高度自动伸缩
    collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [collectionView registerNib:[UINib nibWithNibName:@"ArtViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView=collectionView;
    
}

-(NSMutableArray *)artDataArray{
    if (!_artDataArray) {
        _artDataArray=[NSMutableArray array];
        for (int i=0; i<30; i++) {
            ArtCellModel *artData=[[ArtCellModel alloc] init];
            artData.imageName=[NSString stringWithFormat:@"%d.jpg",(i%2)+1];
            artData.playCount=i*888;
            artData.artName=[NSString stringWithFormat:@"人体艺术%d",i];
            [_artDataArray addObject:artData];
        }
    }
    return _artDataArray;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.artDataArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ArtViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.artCellModel=self.artDataArray[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ArtViewCell *cell=(ArtViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    MyLog(@"cell frame:%@",NSStringFromCGRect(cell.frame));
    MyLog(@"View frame:%@",NSStringFromCGRect(self.view.frame));
    MyLog(@"collectionView frame:%@",NSStringFromCGRect(self.collectionView.frame));
    ArtDetailController *artDetailVC=[[ArtDetailController alloc] init];
    [self.navigationController pushViewController:artDetailVC animated:YES];
    
}

//点击了搜索框,让搜索框为不可编辑状态，不弹出键盘
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    MyLog(@"%s",__func__);
    return NO;
}

@end
