//
//  BPUILabel.h
//  CaiPu
//  可以设置内容离边界的距离
//  Created by chf on 15/12/26.
//  Copyright © 2015年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPUILabel : UILabel

@property(nonatomic) UIEdgeInsets insets;

/** 
 初始化
 并设置了 frame
 而且是带 edge insets 的
 */
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;

/** 
 带edge insets的初始化
 初始化完毕 要设置frame
 */
-(id) initWithInsets: (UIEdgeInsets) insets;


@end
