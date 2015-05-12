//
//  CustomTabBarController.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "CustomNavigationController.h"
#import "RecommendController.h"
#import "InformationController.h"
#import "MapViewController.h"
#import "CycleController.h"


@interface CustomTabBarController () <CustomTabBarDelegate>
@property(nonatomic ,weak) CustomTabBar *customTabbar;
@property(nonatomic, weak) RecommendController *recommendVC;
@property(nonatomic, weak) InformationController *infoVC;
@property(nonatomic, weak) MapViewController *mapVC;
@property(nonatomic, weak) CycleController *cycleVC;

@end

@implementation CustomTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化自定义TabBar
    [self setupCustomTabBar];
    
    RecommendController *recommendVC=[[RecommendController alloc] init];
    recommendVC.tabBarItem.badgeValue=@"4";
    [self setupChildrenViewController:recommendVC title:@"推荐" imageName:@"tab_recommend" selectedImageName:@"tab_recommend_hl"];
    InformationController *infoVC=[[InformationController alloc] init];
    infoVC.tabBarItem.badgeValue=@"2";
    [self setupChildrenViewController:infoVC title:@"资讯" imageName:@"tab_info" selectedImageName:@"tab_info_hl"];
    MapViewController *mapVC=[[MapViewController alloc] init];
    [self setupChildrenViewController:mapVC title:@"地图" imageName:@"tab_map" selectedImageName:@"tab_map_hl"];
    CycleController *cycleVC=[[CycleController alloc] init];
    [self setupChildrenViewController:cycleVC title:@"圈子" imageName:@"tab_cycle" selectedImageName:@"tab_cycle_hl"];
    self.recommendVC=recommendVC;
    self.infoVC=infoVC;
    self.mapVC=mapVC;
    self.cycleVC=cycleVC;
}

/**
 *  当view即将出现时，tabBar才被初始化，所以要在此方法中移除原有tabBar中的view
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //移除原有tabBar中的view
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

/**
 *  设置controller的导航标题，底部item图标和文字
 *
 *  @param controller        被设置controller
 *  @param title             导航标题，底部item显示的文字
 *  @param imageName         底部item的图标名称
 *  @param selectedImageName 选中的item名称
 */
-(void) setupChildrenViewController:(UIViewController *) controller title:(NSString *) title imageName:(NSString *) imageName selectedImageName:(NSString *) selectedImageName

{
    //设置导航标题和底部Item标题
    //也可以统一使用controller.navigationItem.title来设置
    controller.tabBarItem.title=title;
    controller.navigationItem.title=title;
    controller.tabBarItem.image=[UIImage imageWithName:imageName];
    //设置选中图标不被系统渲染，默认iOS7渲染成蓝色。
    UIImage *selectImage=[UIImage imageWithName:selectedImageName];
    if (iOS7) {
        controller.tabBarItem.selectedImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        //iOS6不支持imageWithRenderingMode方法
        controller.tabBarItem.selectedImage=selectImage;
    }
    CustomNavigationController *nav=[[CustomNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    
    [self.customTabbar addBarButtionWithItem:controller.tabBarItem];
}

/**
 *  初始化自定义tabBar
 */
-(void) setupCustomTabBar{
    CustomTabBar *customTabbar=[[CustomTabBar alloc] init];
    //设置自定义Tabbar的frame大小和自带的大小相同
    customTabbar.frame=self.tabBar.bounds;
    //为自定义tabbar设置代理
    customTabbar.delegate=self;
    [self.tabBar addSubview:customTabbar];
    self.customTabbar=customTabbar;
}

/**
 *  点击tabbar按钮时的代理方法
 */
-(void)tabBar:(CustomTabBar *)tabBar didSelectFromIndex:(int)from toIndex:(int)to{
    //切换TabBarController的子控制器
    self.selectedIndex=to;
    if (to==0) {
        
    }
}
/**
 *  点击加号按钮的代理方法
 */
-(void)tabBarPlusButtonClick:(CustomTabBar *)tabBar{
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
