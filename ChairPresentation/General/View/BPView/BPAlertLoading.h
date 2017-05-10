//
//  BPAlertLoading.h
//  Converse
//
//  Created by chf on 16/2/15.
//  Copyright © 2016年 baiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_RIGHTIMG 100

#define TGSystemFontAlert [UIFont systemFontOfSize:15]

@interface BPAlertLoading : UIView

+(UIView *)alertLoadingWithMessage:(NSString *)msg andFrame:(CGRect)frame isBelowNav:(BOOL)isBelowNav;

+(UIView *)alertLoadingWithMessage:(NSString *)msg Image:(UIImage *)img AndTestBg:(UIColor *)color;

+(UIView *)alertLoadingWithMessage:(NSString *)msg leftImage:(UIImage *)imgleft rightImage:(UIImage *)imgRight;

@end
