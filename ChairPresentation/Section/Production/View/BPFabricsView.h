//
//  BPFabricsView.h
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFabricsView;

@protocol BPFabricsViewDelegate <NSObject>
@optional

- (void) fabricsView:(BPFabricsView *)view sender:(id) sender;

@end


@interface BPFabricsView : UIView



@property (nonatomic,weak) id<BPFabricsViewDelegate> delegate;


@property (nonatomic , assign) CGPoint startPoint;

-(void)refreshFabricsStatus;

@end