//
//  BPTextField.m
//  YunKang
//
//  Created by PENG BAI on 15/8/4.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import "BPTextField.h"

@interface BPTextField ()

@property (nonatomic, strong) UIView *indentationView;

@property (nonatomic) BOOL defaultEdgeInsets;

@end

@implementation BPTextField

@synthesize insets=_insets;


-(instancetype)initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets{
    self = [super initWithFrame:frame];
    _defaultEdgeInsets = NO;
    if (self) {
        self.insets = insets;
    }
    return self;
    
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _defaultEdgeInsets = YES;
    if (self) {
        if (_defaultEdgeInsets) {
            self.insets = UIEdgeInsetsMake(0, 10, 0, 10);
            
            self.leftView = self.indentationView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
        
    }
    return self;

}

- (id)init
{
    _defaultEdgeInsets = YES;
    if (self = [super init]) {
        if (_defaultEdgeInsets) {
            self.insets = UIEdgeInsetsMake(0, 10, 0, 10);
            
            self.leftView = self.indentationView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame = CGRectMake(0, 0, self.insets.left, CGRectGetHeight(self.frame));
    
}
#pragma mark 重设编辑区域范围
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return UIEdgeInsetsInsetRect(bounds, self.insets);
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return UIEdgeInsetsInsetRect(bounds, self.insets);
}

#pragma mark - 重设提示区域范围
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, self.insets);
}

- (UIView *)indentationView
{
    if (!_indentationView) {
        _indentationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.insets.left+self.insets.right, CGRectGetHeight(self.frame))];
        _indentationView.backgroundColor = [UIColor clearColor];
    }
    return _indentationView;
}

@end
