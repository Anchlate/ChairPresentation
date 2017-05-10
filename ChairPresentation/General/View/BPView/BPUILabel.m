//
//  BPUILabel.m
//  CaiPu
//
//  Created by chf on 15/12/26.
//  Copyright © 2015年 bp1010. All rights reserved.
//
/**
 调用部分
 
 BPUILabel * lblTitle=[[BPUILabel alloc] initWithFrame:CGRectMake(0, 35+25*i, 185, 22)];
 [lblTitle setInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
 
 */
#import "BPUILabel.h"


@implementation BPUILabel

@synthesize insets=_insets;

-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

#pragma mark - 重写 ，设置 边距
-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}


@end
