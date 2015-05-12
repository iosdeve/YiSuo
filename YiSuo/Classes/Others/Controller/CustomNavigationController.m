//
//  CustomNavigationController.m
//  MyWeibo
//
//  Created by ChenXin on 3/3/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// 自定义Navigation

#import "CustomNavigationController.h"
#import "UIBarButtonItem+Custom.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

//类初始化时候只被调用一次
+(void)initialize{
    
    UINavigationBar *navBar=[UINavigationBar appearance];
    UIBarButtonItem *barItem=[UIBarButtonItem appearance];
    if (!iOS7) {
        //设置NavigationBar的主题
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        
        //设置ios6的状态栏为黑色，如果不设置，会被主题背景同化
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleBlackOpaque;
        //设置barButtionItem的背景主题
        [barItem setBackgroundImage:[UIImage imageResize:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageResize:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageResize:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    //设置barButtionItem的文字主题
    NSMutableDictionary *dictItemTitle=[NSMutableDictionary dictionary];
    dictItemTitle[UITextAttributeFont]=[UIFont systemFontOfSize:iOS7?14:12];
    dictItemTitle[UITextAttributeTextColor]=iOS7? [UIColor orangeColor]:[UIColor darkGrayColor];
    dictItemTitle[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    [barItem setTitleTextAttributes:dictItemTitle forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dictItemTitle forState:UIControlStateHighlighted];
    //设置barbuttonitem disabled的时候字体颜色和字体大小
    NSMutableDictionary *dictDisableItemTitle=[NSMutableDictionary dictionary];
    dictDisableItemTitle[UITextAttributeTextColor]=[UIColor lightGrayColor];
    [barItem setTitleTextAttributes:dictDisableItemTitle forState:UIControlStateDisabled];
    //设置NavigationBar的文字主题
    NSMutableDictionary *dictBarTitle=[NSMutableDictionary dictionary];
    dictBarTitle[UITextAttributeFont]=[UIFont boldSystemFontOfSize:19];
    dictBarTitle[UITextAttributeTextColor]=[UIColor whiteColor];
    dictBarTitle[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    [navBar setTitleTextAttributes:dictBarTitle];
    [navBar setBackgroundImage:[UIImage imageWithName:@"navbar_bg"] forBarMetrics:UIBarMetricsDefault];
}

/**
 *  当push新控制器当时候，自动隐藏底部当tabBar
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //不是根控制器当时候才设置隐藏
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem barButtonItemWithIcon:@"back" hilightIcon:@"back" target:self action:@selector(back)];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_more" hilightIcon:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
