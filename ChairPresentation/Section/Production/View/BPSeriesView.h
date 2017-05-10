//
//  BPSeriesView.h
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPSeriesView;

@protocol BPSeriesViewDelegate <NSObject>
@optional

- (void) seriesView:(BPSeriesView *)view sender:(id) sender;

@end


@interface BPSeriesView : UIView



@property (nonatomic,weak) id<BPSeriesViewDelegate> delegate;


@property (nonatomic , assign) CGPoint startPoint;

-(void)refreshSeriesSelStatus;


@end