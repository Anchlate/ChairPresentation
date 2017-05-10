//
//  BPProductionView.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPSettingButton.h"
#import "BPMenuTabView.h"
#import "BPProductionCView.h"
#import "BPPopSettingV.h"
#import "BPExampleView.h"
#import "BPProductionCVCellHeaderV.h"
#import "BPPSequenceView.h"
#import "BPSearchView.h"
#import "BPSeriesView.h"
#import "BPApplicationView.h"
#import "BPFabricsView.h"
#import "BPFunctionView.h"


@class BPProductionView;

@protocol BPProductionViewDelegate <NSObject>
@optional

/**  tag: 1-左边菜单栏 、2-设置子项回调 、3-产品列表子项 、4-搜索列表子项 、5-系列筛选框空回调、6-系列筛选框子项回调、7-用途筛选框空回调、8-用途筛选框子项回调、9-面料筛选框空回调、10-面料筛选子项回调、11-功能筛选空回调、12-功能筛选子项回调*/
- (void) productionView:(BPProductionView *)view sender:(id) sender tag:(NSInteger)tag;

- (void) productionView:(BPProductionView *)view sender:(id) sender tag:(NSInteger)tag chair:(BPChair *)chair;

@end



@interface BPProductionView : UIView


@property (nonatomic , strong) UIView *contentV;

@property (nonatomic , strong) UIView *lView;

@property (nonatomic , strong) UIView *rView;


//@property (nonatomic , strong) NSMutableArray *filters;

/** 已选的筛选条件的view */
@property (nonatomic , strong) BPProductionCVCellHeaderV *productionConditionView;

/** 排序选择 view*/
@property (nonatomic , strong) BPPSequenceView *psequenceView;

/** 搜索 view*/
@property (nonatomic , strong) BPSearchView *searchView;

/** 系列选择 view*/
@property (nonatomic , strong) BPSeriesView *seriesView;

/** 用途选择 view*/
@property (nonatomic , strong) BPApplicationView *applicationView;

/** 面料选择view*/
@property (nonatomic , strong) BPFabricsView *fabricsView;

/** 功能选择 view*/
@property (nonatomic , strong) BPFunctionView *functionView;

/** 设置按钮  */
@property (nonatomic , strong) BPSettingButton *settingBtn;

/** 设置页面*/
@property (nonatomic , strong)  BPPopSettingV *settingView;

/** 左边菜单栏 view*/
@property (nonatomic , strong) BPMenuTabView *menuTabView;

/** 产品列表 view*/
@property (nonatomic , strong) BPProductionCView *productionCView;


@property (nonatomic,weak) id<BPProductionViewDelegate> delegate;


//@property (nonatomic , assign) NSInteger sequenceType;


@end




