//
//  BPFabricAndFunctionChildTableViewCell.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFabricAndFunctionChild, BPFabricAndFunctionChildTableViewCell;

@protocol BPFabricAndFunctionChildTableViewCellDelegate <NSObject>

//- (void)fabricAndFunctionChildTableViewCell:(BPFabricAndFunctionChildTableViewCell *)cell didSelectedChild:(BPFabricAndFunctionChild *)child;

@end

@interface BPFabricAndFunctionChildTableViewCell : UITableViewCell

@property (nonatomic, retain) BPFabricAndFunctionChild *child;
@property (nonatomic, assign) id<BPFabricAndFunctionChildTableViewCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end