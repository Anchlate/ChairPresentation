//
//  BPMenuCell.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPMenuCell.h"


@interface BPMenuCell()



@end


@implementation BPMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - override
-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [RGBColorAndAlpha(224, 224, 224, 1) CGColor]);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - MATCHSIZE(1), rect.size.width, MATCHSIZE(1)));
}

-(instancetype) initWithIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView width:(CGFloat)width{
    
    self = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!self) {
        self = [[BPMenuCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    if (self) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, MATCHSIZE(120));
        self.backgroundColor = RGBColorAndAlpha(247, 247, 247, 1);
        self.selectedBackgroundView.backgroundColor = RGBColorAndAlpha(255, 255, 255, 1);
        
        self.textLabel.textColor = RGBColorAndAlpha(145, 145, 145, 1);
        self.textLabel.highlightedTextColor = [UIColor blackColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.textLabel.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
    }
    return self;
    
}

-(instancetype)initCellHeightID:(NSString *)ID{
    self = [[BPMenuCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    if (self) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, MATCHSIZE(120));
    }
    return self;
}


- (void)setItem:(BPItem *)item
{
    _item = item;
    if(_item.title) {
        self.textLabel.text = _item.title;
    }
    
    if (_item.icon) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
    
    if (_item.selectedicon) {
        self.imageView.highlightedImage = [UIImage imageNamed:_item.selectedicon];
    }
    
}



@end
