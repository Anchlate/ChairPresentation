//
//  BPPopSettingV.h
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPPopSettingV;

@protocol BPPopSettingVDelegate <NSObject>
@optional

- (void) popSettingView:(BPPopSettingV *)view sender:(id) sender;

@end


@interface BPPopSettingV : UIView



@property (nonatomic , strong) UIButton *logOut;


-(instancetype)initWithFrame:(CGRect)frame point:(CGPoint)point;

@property (nonatomic,weak) id<BPPopSettingVDelegate> delegate;


@end
