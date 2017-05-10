//
//  BPFabricAndFunctionChildView.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFabricAndFunctionChildView;

@protocol BPFabricAndFunctionChildViewDelegate <NSObject>

- (void)fabricAndFunctionChildView:(BPFabricAndFunctionChildView *)childView didSelectedFabricItem:(NSString *)fabricItem;
- (void)fabricAndFunctionChildView:(BPFabricAndFunctionChildView *)childView didCanceledFabricItem:(NSString *)fabricItem;

/**********/
- (void)fabricAndFunctionChildView:(BPFabricAndFunctionChildView *)childView didSelectedFabricItem:(NSString *)fabricItem field:(NSString *)field;
- (void)fabricAndFunctionChildView:(BPFabricAndFunctionChildView *)childView didCanceledFabricItem:(NSString *)fabricItem field:(NSString *)field;


@end

@interface BPFabricAndFunctionChildView : UIView

@property (nonatomic, assign) id<BPFabricAndFunctionChildViewDelegate>delegate;

- (void)reloadDatasource:(NSArray *)datasource nameEN:(NSString *)nameEN;

@property (nonatomic, copy) NSMutableArray *datasource;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

@property (nonatomic, copy) NSString *nameEN;

@end
