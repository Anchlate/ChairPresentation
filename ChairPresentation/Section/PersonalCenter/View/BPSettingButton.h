//
//  BPSettingView.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPItem.h"


@class BPSettingButton;

@protocol BPSettingButtonDelegate <NSObject>
@optional

- (void) settingButton:(BPSettingButton *)view sender:(id) sender;

@end



@interface BPSettingButton : UIView


@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic , strong) UILabel *textLabel;

@property (nonatomic , strong) BPItem *item;

@property (nonatomic,weak) id<BPSettingButtonDelegate> delegate;


@end
