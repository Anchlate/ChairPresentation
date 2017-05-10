//
//  BPProductionCVCellHeaderV.h
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPConditionView.h"



@class BPProductionCVCellHeaderV;

@protocol BPProductionCVCellHeaderVDelegate <NSObject>
@optional

- (void) productionCVCellHeaderV:(BPProductionCVCellHeaderV *)view sender:(id) sender;

/**act: 1-refresh */
- (void) productionCVCellHeaderV:(BPProductionCVCellHeaderV *)view atc:(NSInteger) action;


@end


@interface BPProductionCVCellHeaderV : UIView


@property (nonatomic , strong) UIButton *deleteAll;



@property (nonatomic , strong) NSMutableArray *filtersViews;


@property (nonatomic,weak) id<BPProductionCVCellHeaderVDelegate> delegate;


@end
