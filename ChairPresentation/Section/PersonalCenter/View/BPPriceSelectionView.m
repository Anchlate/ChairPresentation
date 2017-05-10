//
//  BPPriceSelection.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPPriceSelectionView.h"


@interface BPPriceSelectionView()<BPRangSliderDelegate>

@property (nonatomic , strong) UIView *contentV;

@property (nonatomic , strong) UILabel *title;

@property (nonatomic , strong) UIView *line;




@end

@implementation BPPriceSelectionView{
    
    CGFloat marginT;
    CGFloat marginL;
    CGFloat marginB;
    CGFloat marginR;
    
}


-(instancetype) initWithFrame:(CGRect)frame{
   
    marginT = 10;
    marginL = 10;
    marginB = 10;
    marginR = 10;
    
    if (self = [super initWithFrame:frame]) {
       
        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.title];
        
        [self.contentV addSubview:self.rangSlider];
        
    }
    return self;
}


-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _contentV;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(40), MATCHSIZE(80), self.contentV.frame.size.width, MATCHSIZE(32))];
        _title.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
        _title.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _title.text = @"价钱区间";
    }
    return _title;
}


-(BPRangSlider *)rangSlider{
    if (!_rangSlider) {
        _rangSlider = [[BPRangSlider alloc]initWithFrame:CGRectMake(MATCHSIZE(40), self.title.frame.origin.y+self.title.frame.size.height+MATCHSIZE(80), self.contentV.frame.size.width-MATCHSIZE(80), MATCHSIZE(142))];
        _rangSlider.unit = @"￥";
        _rangSlider.minNum = 500;
        _rangSlider.maxNum = 6150;
        _rangSlider.minTintColor = RGBColorAndAlpha(224, 224, 224, 1);
        _rangSlider.maxTintColor = RGBColorAndAlpha(224, 224, 224, 1);
        _rangSlider.mainTintColor = RGBColorAndAlpha(191, 203, 217, 1);
        _rangSlider.delegate = self;
    }
    return _rangSlider;
}

-(void)rangSlider:(BPRangSlider *)view minNum:(CGFloat)nimNum maxNum:(CGFloat)maxNum{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([[userDefault valueForKey:Role] isEqualToString:@"1"]){
        [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:[NSString stringWithFormat:@"%.0f-%0.f",nimNum,maxNum] key:@"discount35_price" tag:6] key:BPPRICE];
    }else if([[userDefault valueForKey:Role] isEqualToString:@"2"]){
        [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:[NSString stringWithFormat:@"%.0f-%0.f",nimNum,maxNum] key:@"discount3_price" tag:6] key:BPPRICE];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
    
}


@end