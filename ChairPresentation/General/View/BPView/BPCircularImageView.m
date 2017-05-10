//
//  BPCircularImageView.m
//  Converse
//
//  Created by chf on 16/1/20.
//  Copyright © 2016年 baiPeng. All rights reserved.
//

#import "BPCircularImageView.h"

@implementation BPCircularImageView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setting];
    }
    return self;
}

//-(void)setFrame:(CGRect)frame{
//    [self setting];
//}

-(void)setting{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.clipsToBounds = YES;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self setting];
    
}

@end
