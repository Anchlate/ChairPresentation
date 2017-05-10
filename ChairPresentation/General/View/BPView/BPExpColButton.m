//
//  BPExpColButton.m
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPExpColButton.h"


@interface  BPExpColButton()

@property (nonatomic , strong) UIButton *arrow;


@end


@implementation BPExpColButton{
    
    UIImage *collapseIcon;
    UIImage *expansionIcon;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    collapseIcon = [UIImage imageNamed:@"collapse_icon"];
    expansionIcon = [UIImage imageNamed:@"expansion_icon"];
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.arrow];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+MATCHSIZE(10)+collapseIcon.size.width, self.frame.size.height);
        
    }
    return self;
}


-(UIButton *)arrow{
    if (!_arrow) {
        
        _arrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, collapseIcon.size.width, collapseIcon.size.height)];
        _arrow.center = CGPointMake(self.frame.size.width+collapseIcon.size.width+MATCHSIZE(10), self.frame.size.height/2);
        [_arrow setImage:expansionIcon forState:UIControlStateNormal];
        [_arrow setImage:collapseIcon forState:UIControlStateSelected];
    }
    return _arrow;
}


-(void)setStatus:(BOOL)status{
    _status = status;
    if (!status) {
        self.selected = NO;
        self.arrow.selected = NO;
    }else{
        self.selected = YES;
        self.arrow.selected = YES;
    }
}



@end
