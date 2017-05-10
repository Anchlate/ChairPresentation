//
//  BPImgTxtButton.m
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPImgTxtButton.h"

@implementation BPITBItem

-(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag{
    if (self = [super init]) {
        self.title = title;
        self.image = image;
        self.tag = tag;
    }
    return self;
}


@end




@implementation BPImgTxtButton


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = MATCHSIZE(2);
        self.layer.borderColor = [RGBColorAndAlpha(216, 236, 251, 1) CGColor];
        self.layer.cornerRadius = MATCHSIZE(8);
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLable];
        
    }
    return self;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    }
    return _imageView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0,MATCHSIZE(28))];
        _titleLable.textColor = RGBColorAndAlpha(216, 236, 251, 1);
        _titleLable.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(void)setItem:(BPITBItem *)item{
    
    UIImage *icon = item.image;
    self.imageView.frame = CGRectMake(0, 0, icon.size.width, icon.size.height);
    self.imageView.center = CGPointMake(self.frame.size.width/2, icon.size.height/2+MATCHSIZE(14));
    self.imageView.image = icon;
    
    CGSize txtCGSize = [item.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(28)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLable.font} context:nil].size;
    self.titleLable.text = item.title;
    self.titleLable.frame = CGRectMake(0,0, txtCGSize.width, txtCGSize.height);
    self.titleLable.center = CGPointMake(self.frame.size.width/2, self.imageView.frame.origin.y+self.imageView.frame.size.height+MATCHSIZE(20)+txtCGSize.height/2);
    
}

@end
