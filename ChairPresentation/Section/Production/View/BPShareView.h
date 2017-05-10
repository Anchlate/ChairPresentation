//
//  BPShareView.h
//  ChairPresentation
//
//  Created by chf on 16/3/26.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BPShareView : UIView


@property (nonatomic , assign) CGPoint startPoint;


@end



@interface BPShareItem : NSObject

@property (nonatomic , strong) NSString *title;

@property (nonatomic , strong) NSString *image;

@end