//
//  BPTextField.h
//  YunKang
//  可以设置内容离边界的距离
//  Created by PENG BAI on 15/8/4.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPTextField : UITextField

-(instancetype)initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;

@property(nonatomic) UIEdgeInsets insets;

@end
