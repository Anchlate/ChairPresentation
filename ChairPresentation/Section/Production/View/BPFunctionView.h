//
//  BPFunctionView.h
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BPFunctionView;

@protocol BPFunctionViewDelegate <NSObject>
@optional

- (void) functionView:(BPFunctionView *)view sender:(id) sender;

@end


@interface BPFunctionView : UIView



@property (nonatomic,weak) id<BPFunctionViewDelegate> delegate;


@property (nonatomic , assign) CGPoint startPoint;


-(void)refreshFunctionStatus;

@end