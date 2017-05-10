//
//  BPApplicationCell.m
//  ChairPresentation
//
//  Created by chf on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPApplicationCell.h"


@implementation BPApplicationCellModel

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.key = dict[@"key"];
    }
    return self;
}

+ (instancetype) objectWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}



@end



@implementation BPApplicationCell{
    UIImage *icon_s;
    UIImage *icon_n;
}

#pragma mark - override
-(void)layoutSubviews{
    [super layoutSubviews];
    
    icon_n =[UIImage imageNamed:@"unselected"];
    
    self.imageView.frame = CGRectMake(0, 0, icon_n.size.width, icon_n.size.height);
    self.imageView.center = CGPointMake(MATCHSIZE(40), self.frame.size.height/2);
    self.imageView.image = icon_n;
    
    self.textLabel.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    self.textLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1);
  
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [RGBColorAndAlpha(224, 224, 224, 1) CGColor]);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - MATCHSIZE(1), rect.size.width, MATCHSIZE(1)));
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    icon_s =[UIImage imageNamed:@"selected"];
    icon_n =[UIImage imageNamed:@"unselected"];

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = frame;
    }
    
    return self;
}

-(void)setModel:(BPApplicationCellModel *)model{

    icon_s =[UIImage imageNamed:@"selected"];
    icon_n =[UIImage imageNamed:@"unselected"];
    
    if (model.selected) {
        self.imageView.image = icon_s;
    }else{
        self.imageView.image = icon_n;
    }
    self.textLabel.text = model.name;

}

-(void)setStatus:(BOOL)status{
    _status = status;
    if (status) {
        self.imageView.image = icon_s;
    }else{
        self.imageView.image = icon_n;
    }
    
}

@end


@implementation BPApplicationCellHeader{

}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [RGBColorAndAlpha(224, 224, 224, 1) CGColor]);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - MATCHSIZE(1), rect.size.width, MATCHSIZE(1)));
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = frame;
        [self addSubview:self.titleLabel];
        [self addSubview:self.doneButton];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        NSString *text = @"用途选择";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        CGSize textCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(52)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textCGSize.width, MATCHSIZE(52))];
        _titleLabel.center = CGPointMake(MATCHSIZE(30)+textCGSize.width/2,self.frame.size.height/2);
        _titleLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _titleLabel.font = font;
        _titleLabel.text = text;
        
    }
    return _titleLabel;
}

-(UIButton *)doneButton{
    if (!_doneButton) {
        NSString *text = @"确定";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,MATCHSIZE(100), MATCHSIZE(52))];
        _doneButton.center = CGPointMake(self.frame.size.width-(MATCHSIZE(30)+MATCHSIZE(100)/2), self.frame.size.height/2);
        _doneButton.layer.borderWidth = MATCHSIZE(2);
        _doneButton.layer.borderColor = [RGBColorAndAlpha(89, 177, 227, 1) CGColor];
        _doneButton.layer.cornerRadius = MATCHSIZE(10);
        _doneButton.clipsToBounds = YES;
        [_doneButton setTitle:text forState:UIControlStateNormal];
        [_doneButton setTitleColor:MainColor forState:UIControlStateNormal];
        _doneButton.titleLabel.font = font;
        [_doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _doneButton;
}

-(void)doneAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(applicationCellHeader:sender:)]) {
        [_delegate applicationCellHeader:self sender:self];
    }
}

@end


