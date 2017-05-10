//
//  BPFabricAndFunctionTableView.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPFabricAndFunctionTableViewDelegate <NSObject>

- (void)selections:(NSArray *)selections;

- (void)selectedFabricAndFunctionItemKey:(NSString *)key value:(NSString *)value;
- (void)canceledFabricAndFunctionItemKey:(NSString *)key value:(NSString *)value;


@end


@interface BPFabricAndFunctionTableView : UIView

@property (nonatomic, assign) id<BPFabricAndFunctionTableViewDelegate>delegate;

- (id)initWithTitle:(NSString *)title datasource:(NSArray *)datasource;

//- (void)deselectCellWithKey:(NSString *)key value:(NSString *)value;

@property (nonatomic, copy) NSMutableArray *datasource;

@property (nonatomic, strong) UITableView *tableView;


@end