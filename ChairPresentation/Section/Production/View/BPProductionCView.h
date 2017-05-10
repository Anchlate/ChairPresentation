//
//  BPProductionCView.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPProductionCVCell.h"
#import "BPCollectionViewFlowLayout.h"


@class BPProductionCView;

@protocol BPProductionCViewDelegate <NSObject>
@optional

- (void) productionCView:(BPProductionCView *)view sender:(id) sender chair:(BPChair *)chair;

@end



@interface BPProductionCView : UIView

@property (nonatomic,weak) id<BPProductionCViewDelegate> delegate;


@property (nonatomic , strong) BPCollectionViewFlowLayout *cvFlayout;

@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray *dataSource;


//@property (nonatomic , strong) NSMutableArray *filters;

-(void)searchAllData;

-(void)hotSequence;

-(void)highToLowSequence;

-(void)lowToHighSequence;


@end
