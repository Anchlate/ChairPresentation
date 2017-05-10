//
//  BPHomeView.h
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPImgTxtButton.h"

@class BPHomeView;

@protocol BPHomeViewDelegate <NSObject>
@optional

- (void) homeView:(BPHomeView *)view sender:(id) sender;

@end


@interface BPHomeView : UIView

@property (nonatomic,weak) id<BPHomeViewDelegate> delegate;


@property (nonatomic , strong) UIButton *allProduct;

@property (nonatomic , strong) UIImageView *headerIV;


@property (nonatomic , strong) NSArray *classArray;


@property (nonatomic , strong) NSArray *adArray;


@end
