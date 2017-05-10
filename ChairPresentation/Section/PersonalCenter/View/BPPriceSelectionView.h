//
//  BPPriceSelection.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPRangSlider.h"


@class BPPriceSelectionView;

@protocol BPPriceSelectionViewDelegate <NSObject>
@optional

- (void) priceSelectView:(BPPriceSelectionView *)view sender:(id) sender;

@end




@interface BPPriceSelectionView : UIView



@property (nonatomic,weak) id<BPPriceSelectionViewDelegate> delegate;

@property (nonatomic , strong) BPRangSlider *rangSlider;


@end
