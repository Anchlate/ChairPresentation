//
//  BPSettingView.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSettingButton.h"


@interface BPSettingButton()


@property (nonatomic , strong) UIView *contentV;




@end


@implementation BPSettingButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.contentV];
        [self.contentV addSubview:self.imageView];
        [self.contentV addSubview:self.textLabel];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

#pragma mark - gesture handle  tag touch click
- (void)viewTapGesture:(UITapGestureRecognizer *)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(settingButton:sender:)]) {
        [_delegate settingButton:self sender:self];
    }
    
}


-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _contentV;
}


-(UIImageView *)imageView{
    if (!_imageView) {
       
        UIImage *icon = [UIImage imageNamed:@"setting_icon"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
        _imageView.center = CGPointMake(20+_imageView.frame.size.width/2, self.contentV.frame.size.height/2);
        _imageView.image = icon;
        
    }
    return _imageView;
}

-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentV.frame.size.width-(20+self.imageView.frame.size.width), 45)];
        _textLabel.center = CGPointMake(20+self.imageView.frame.size.width+20 + (self.contentV.frame.size.width-(20+self.imageView.frame.size.width))/2, self.contentV.frame.size.height/2);
        _textLabel.textColor = RGBColorAndAlpha(145, 145, 145, 1);
        _textLabel.text = @"设置";
    }
    return _textLabel;
}

- (void)setItem:(BPItem *)item
{
    _item = item;
    if(_item.title) self.textLabel.text = _item.title;
    
    if (_item.icon) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
    
    if (_item.selectedicon) {
        self.imageView.highlightedImage = [UIImage imageNamed:_item.selectedicon];
    }
    
}




@end
