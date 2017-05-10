//
//  BPProductionDetailViewController.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPProductionDetailViewController : UIViewController

@property (nonatomic, retain) BPChair *chair;

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, copy) NSString *nameEN;
@property (nonatomic, copy) NSString *searial;

@end
