//
//  BPSequenceTCell.m
//  ChairPresentation
//
//  Created by chf on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSequenceTCell.h"

@implementation BPSequenceTCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [RGBColorAndAlpha(224, 224, 224, 1) CGColor]);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - MATCHSIZE(1), rect.size.width, MATCHSIZE(1)));
}


@end
