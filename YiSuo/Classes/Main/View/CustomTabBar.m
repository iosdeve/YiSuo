//
//  CustomTabBar.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//自定义TabBar

#import "CustomTabBar.h"
#import "TabBarButton.h"

@interface CustomTabBar ()
//当前选中的按钮
@property(nonatomic, weak) TabBarButton *selectedButton;

//底部按钮集合
@property(nonatomic, strong) NSMutableArray *items;

@end

@implementation CustomTabBar

-(NSMutableArray *)items{
    if (_items==nil) {
        _items=[NSMutableArray array];
    }
    return _items;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 如果不是ios7设置TabBar的背景图片，黑色
        if (!iOS7) {
            self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}

/**
 *  根据UITabBarItem添加自定义item
 *
 *  @param item 参照的UITabBarItem
 */
-(void)addBarButtionWithItem:(UITabBarItem *)item{
    TabBarButton *button=[[TabBarButton alloc] init];
    button.item=item;
    [self addSubview:button];
    //添加到集合中
    [self.items addObject:button];
    
    //为按钮添加点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.subviews.count==1) {
        [self buttonClick:button];
    }
}

/**
 * 调整每个BarButton的Frame位置
 * 让其平均分配
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=self.frame.size.width/self.subviews.count;
    CGFloat h=self.frame.size.height;
    CGFloat y=0;
    for (int i=0; i<self.items.count; i++) {
        CGFloat x=i*w;
        UIButton *button=self.items[i];
        button.frame=CGRectMake(x, y, w, h);
        //设置按钮的索引tag，用于后续点击时显示对应的controller
        button.tag=i;
    }
}

/**
 *  处理点击按钮事件，改变按钮的状态
 */
-(void) buttonClick:(TabBarButton *) button{
    //执行代理方法
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectFromIndex:toIndex:)]) {
        [self.delegate tabBar:self didSelectFromIndex:((int)self.selectedButton.tag) toIndex:((int)button.tag)];
    }
    
    self.selectedButton.selected=NO;
    button.selected=YES;
    self.selectedButton=button;
}
/**
 *  处理加号按钮的点击
 */
-(void) plusButtonClick{
    if ([self.delegate respondsToSelector:@selector(tabBarPlusButtonClick:)]) {
        [self.delegate tabBarPlusButtonClick:self];
    }
}

@end
