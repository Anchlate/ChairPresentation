//
//  BPButton.m
//  ChairPresentation
//
//  Created by chf on 16/3/27.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPButton.h"

@implementation BPButton


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)layoutSubviews{
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

@end
