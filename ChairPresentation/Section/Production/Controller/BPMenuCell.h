//
//  BPMenuCell.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPItem.h"


@interface BPMenuCell : UITableViewCell

@property (nonatomic , strong) BPItem *item;

-(instancetype) initWithIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView width:(CGFloat)width;

-(instancetype)initCellHeightID:(NSString *)ID;


@end
