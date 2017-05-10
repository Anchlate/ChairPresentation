//
//  BPDetailFunctionButton.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPDetailFunctionButton.h"

@interface BPDetailFunctionButton()

@end

@implementation BPDetailFunctionButton

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.functionImgView];
        [self addSubview:self.functionLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF(weakSelf);
    
    // functionImgView
    [self.functionImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_centerY).offset(-2);
        
    }];
    
    // functionLabel
    [self.functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_centerY).offset(2);
        make.leading.trailing.bottom.equalTo(weakSelf);
        
    }];
    
}


#pragma mark -SetterMethod
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    Log(@"......button is selected:%d", selected);
    
    if (self.selected) {
        self.functionImgView.image = self.functionSelectedImage;
    } else {
        self.functionImgView.image = self.functionImage;
    }
    
}

- (void)setFunctionImage:(UIImage *)functionImage
{
    _functionImage = functionImage;
    
    CGFloat w = _functionImage.size.width;
    CGFloat h = _functionImage.size.height;
    
    self.functionImgView.image = [_functionImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
}

- (void)setFunctionSelectedImage:(UIImage *)functionSelectedImage
{
    _functionSelectedImage = functionSelectedImage;
    if (self.selected) {
        self.functionImgView.image = _functionSelectedImage;
    } else {
        self.functionImgView.image = self.functionImage;
    }
}

- (void)setFunctionTitle:(NSString *)functionTitle
{
    _functionTitle = functionTitle;
    self.functionLabel.text = _functionTitle;
}



#pragma mark -GetterMethod
- (UIImageView *)functionImgView
{
    if (!_functionImgView) {
        _functionImgView = [[UIImageView alloc]init];
        [_functionImgView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_functionImgView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _functionImgView;
}

- (UILabel *)functionLabel
{
    if (!_functionLabel) {
        _functionLabel = [[UILabel alloc]init];
        _functionLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _functionLabel;
}

@end