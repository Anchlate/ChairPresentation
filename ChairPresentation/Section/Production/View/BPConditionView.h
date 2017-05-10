//
//  BPFiltersView.h
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


//@class BPFiltersView;
//
//@protocol BPFiltersViewDelegate <NSObject>
//@optional
//
//- (void) filtersView:(BPFiltersView *)view sender:(id) sender;
//
//@end


@interface BPConditionView : UIView


@property (nonatomic , strong) UILabel *title;


@property (nonatomic , strong) BPKeyValue *keyValue;


-(instancetype) initWithKV:(BPKeyValue *)keyValue;

//+(CGSize)viewSize:(NSString *)text;

@property (nonatomic ,assign) CGSize vSize;


//@property (nonatomic,weak) id<BPFiltersViewDelegate> delegate;


@end
