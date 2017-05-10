//
//  BPPSequenceView.h
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BPPSequenceView;

@protocol BPPSequenceViewDelegate <NSObject>
@optional

- (void) psequenceView:(BPPSequenceView *)view sender:(id) sender;

@end


@interface BPPSequenceView : UIView



@property (nonatomic,weak) id<BPPSequenceViewDelegate> delegate;


@property (nonatomic , assign) CGPoint startPoint;


@end



@interface BPSequenceItem : NSObject

@property (nonatomic , strong) NSString *title;

@property (nonatomic , strong) NSString *image;

@end