//
//  BPApplicationCell.h
//  ChairPresentation
//
//  Created by chf on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BPApplicationCell;
@class BPApplicationCellHeader;

@protocol BPApplicationCellDelegate <NSObject>
@optional

- (void) applicationCell:(BPApplicationCell *)view sender:(id) sender;


- (void) applicationCellHeader:(BPApplicationCellHeader *)view sender:(id) sender;


@end




@interface BPApplicationCellModel:NSObject

@property (nonatomic , strong) NSString *key;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , assign) BOOL selected;

+ (instancetype) objectWithDict:(NSDictionary *)dict;

@end



@interface BPApplicationCell : UITableViewCell


@property (nonatomic , assign) BOOL status;

@property (nonatomic ,strong) BPApplicationCellModel *model;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;


@end


@interface BPApplicationCellHeader : UITableViewCell


@property (nonatomic ,strong) UIButton *doneButton;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic,weak) id<BPApplicationCellDelegate> delegate;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;


@end