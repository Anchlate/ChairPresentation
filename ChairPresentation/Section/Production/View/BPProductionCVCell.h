//
//  BPProductionCVCell.h
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BPProduction.h"
#import "BPChair.h"

#import "BPUILabel.h"

@interface BPProductionCVCell : UICollectionViewCell


@property (nonatomic , strong) UIImageView *face;

@property (nonatomic , strong) UILabel *price;

@property (nonatomic , strong) BPUILabel *style;


//@property (nonatomic , strong) BPProduction *production;

@property (nonatomic , strong) BPChair *production;


@end
