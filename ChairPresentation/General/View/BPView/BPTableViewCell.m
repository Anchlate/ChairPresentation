//
//  BPTableViewCell.m
//  Converse
//
//  Created by chf on 16/2/2.
//  Copyright © 2016年 baiPeng. All rights reserved.
//

#import "BPTableViewCell.h"

@implementation BPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
        self.textLabel.textColor = RGBColorAndAlpha(105, 105, 105, 1);
        self.detailTextLabel.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
        self.detailTextLabel.textColor = RGBColorAndAlpha(83, 83, 83, 1);
    }
    return self;
}



@end
