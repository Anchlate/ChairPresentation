//
//  BPImgTxtButton.h
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BPITBItem : NSObject

@property (nonatomic , strong) UIImage *image;

@property (nonatomic , strong) NSString *title;

@property (nonatomic , assign) NSInteger tag;

-(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag;


@end


@interface BPImgTxtButton : UIView


@property (nonatomic , strong) UIImageView *imageView;


@property (nonatomic , strong) UILabel *titleLable;

@property (nonatomic , strong) BPITBItem *item;


@end
