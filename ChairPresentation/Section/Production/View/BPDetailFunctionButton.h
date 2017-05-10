//
//  BPDetailFunctionButton.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPDetailFunctionButton : UIButton

@property (nonatomic, strong) UIImageView *functionImgView;
@property (nonatomic, strong) UILabel *functionLabel;

@property (nonatomic, retain) UIImage *functionImage;
@property (nonatomic, retain) UIImage *functionSelectedImage;
@property (nonatomic, copy) NSString *functionTitle;

@end
