//
//  BPTextView.h
//  CaiPu
//可以设置内容离边界的距离
//  Created by chf on 15/12/7.
//  Copyright © 2015年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPTextView : UITextView

@property (copy, nonatomic) NSString *placeholder;


-(instancetype)initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;

@property(nonatomic) UIEdgeInsets insets;


@end
