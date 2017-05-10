//
//  BPSearchView.h
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BPSearchView;

@protocol BPSearchViewDelegate <NSObject>
@optional

- (void) pSearchView:(BPSearchView *)view sender:(id) sender;

@end



@interface BPSearchView : UIView


@property (nonatomic , assign) CGPoint startPoint;


@property (nonatomic,weak) id<BPSearchViewDelegate> delegate;

-(void)searchRequest:(NSString *)search;

@end
