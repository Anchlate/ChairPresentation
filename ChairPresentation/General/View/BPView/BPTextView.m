
//
//  BPTextView.m
//  CaiPu
//
//  Created by chf on 15/12/7.
//  Copyright © 2015年 bp1010. All rights reserved.
//

#import "BPTextView.h"

@interface BPTextView ()

@property (nonatomic) BOOL defaultEdgeInsets;

@end


@implementation BPTextView


@synthesize insets=_insets;


-(instancetype)initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets{
    self = [super initWithFrame:frame];
    _defaultEdgeInsets = NO;
    if (self) {
        self.insets = insets;
        self.textContainerInset = self.insets;
    }
    return self;
    
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _defaultEdgeInsets = YES;
    if (self) {
        if (_defaultEdgeInsets) {
            self.insets = UIEdgeInsetsMake(10, 10, 10, 10);
            self.textContainerInset = self.insets;
        }
        
    }
    return self;
    
}

- (id)init
{
    _defaultEdgeInsets = YES;
    if (self = [super init]) {
       
    }
    return self;
}



@end
