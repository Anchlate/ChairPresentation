//
//  BPProductionVNavBarV.h
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTextField.h"
#import "BPExpColButton.h"


@class BPProductionVNavBarV;

@protocol BPProductionVNavBarVDelegate <NSObject>
@optional

- (void) productionVNavBarV:(BPProductionVNavBarV *)view sender:(id) sender;

@end



@interface BPProductionVNavBarV : UIView


@property (nonatomic , strong) UIButton *search;

@property (nonatomic , strong) UIButton *sequence;

@property (nonatomic , strong) BPTextField *searchTF;


@property (nonatomic , strong) BPExpColButton *series;

@property (nonatomic , strong) BPExpColButton *application;

@property (nonatomic , strong) BPExpColButton *fabrics;

@property (nonatomic , strong) BPExpColButton *function;


@property (nonatomic,weak) id<BPProductionVNavBarVDelegate> delegate;

-(void)conditionButton:(UIButton *)sender;

-(void)searchAndSequenceAction:(UIButton *)sender;

@end
