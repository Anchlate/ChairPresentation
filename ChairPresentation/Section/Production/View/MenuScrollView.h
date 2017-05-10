//
//  HXMenuScrollView.h
//  HXScrollerMenu
//
//  Created by ichay on 14/11/3.
//  Copyright (c) 2014年 ichay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TITLEKEY @"title"

#define TOTALWIDTH @"totalwidth"


#pragma mark 代理方法
@protocol MenuScrollViewDelegate <NSObject>

-(void)didMenuScrollViewClickedAtIndex:(NSInteger)index;

@end

@interface MenuScrollView : UIView
{
    float totalWidth;
    NSMutableArray * _ItemsInfo;
//    UIImageView * _directionview;
}
@property(nonatomic,assign) id<MenuScrollViewDelegate> delegate;

@property(nonatomic,strong) UIScrollView * mScrollerView;

@property(nonatomic,strong) NSMutableArray * mButtons;

@property (nonatomic, strong) UIButton *appendButton;

@property (nonatomic, copy) NSMutableArray *mImages;

//初始化方法
-(id)initWithFrame:(CGRect)frame andButtonItems:(NSArray *)items;

- (id)initWithFrame:(CGRect)frame andButtonItems:(NSArray *)items andImages:(NSArray *)images;

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images;


//点击触发 button
-(void)selectAtIndex:(NSInteger)index;

//将 button 改为选中状态,不发送 delegate
-(void)changeButtonStateAtIndex:(NSInteger)index;



@end
