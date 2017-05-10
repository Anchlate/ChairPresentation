//
//  BPApplicationView.h
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BPApplicationView;

@protocol BPApplicationViewDelegate <NSObject>
@optional

- (void) applicationView:(BPApplicationView *)view sender:(id)sender;

@end


@interface BPApplicationView : UIView



@property (nonatomic,weak) id<BPApplicationViewDelegate> delegate;


@property (nonatomic , assign) CGPoint startPoint;

-(void)refreshApplicationStatus;


@end