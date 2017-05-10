//
//  BPButton.m
//  CaiPu
//
//  Created by andjo on 15/12/27.
//  Copyright © 2015年 bp1010. All rights reserved.
//

#import "BPCheckButton.h"
#define TG_IMAGE_AND_TITLE_BUTTON_SPACE_5          5.0f
#define TG_IMAGE_AND_TITLE_BUTTON_IMAGE_HEIGHT     20.0f
#define TG_IMAGE_AND_TITLE_BUTTON_IMAGE_WIDTH      20.0f

@implementation BPCheckButton



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleSize=[self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    [self.imageView setFrame:CGRectMake(0, self.frame.size.height/2-TG_IMAGE_AND_TITLE_BUTTON_IMAGE_HEIGHT/2, TG_IMAGE_AND_TITLE_BUTTON_IMAGE_WIDTH, TG_IMAGE_AND_TITLE_BUTTON_IMAGE_HEIGHT)];
    
    [self.titleLabel setFrame:CGRectMake(TG_IMAGE_AND_TITLE_BUTTON_IMAGE_WIDTH+TG_IMAGE_AND_TITLE_BUTTON_SPACE_5, self.frame.size.height/2-titleSize.height/2, self.frame.size.width-TG_IMAGE_AND_TITLE_BUTTON_IMAGE_WIDTH-TG_IMAGE_AND_TITLE_BUTTON_SPACE_5, titleSize.height)];
}


@end
