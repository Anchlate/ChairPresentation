//
//  BPMenuTabView.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMenuCell.h"


@class BPMenuTabView;

@protocol BPMenuTabViewDelegate <NSObject>
@optional

- (void) menuTabView:(BPMenuTabView *)view sender:(id) sender;

@end



@interface BPMenuTabView : UIView

@property (nonatomic,weak) id<BPMenuTabViewDelegate> delegate;


@end


