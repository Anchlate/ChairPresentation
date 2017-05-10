//
//  BPFabricAndFunctionTableViewCell.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFabricAndFunction, BPFabricAndFunctionTableViewCell;

@protocol BPFabricAndFunctionTableViewCellDelegate <NSObject>

/*
- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell fabricDict:(NSDictionary *)fabricDict;
- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell cancelFabricDict:(NSDictionary *)fabricDict;
*/

- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell didAddAKey:(NSString *)key andValue:(NSString *)value;
- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell didCancledAKey:(NSString *)key andValue:(NSString *)value;

- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell didClickButton:(UIButton *)button;

@end

@interface BPFabricAndFunctionTableViewCell : UITableViewCell

@property (nonatomic, retain) BPFabricAndFunction *fabricAndFunction;
@property (nonatomic, assign) id<BPFabricAndFunctionTableViewCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

//- (void)deselectCellWithKey:(NSString *)key value:(NSString *)value;

@end