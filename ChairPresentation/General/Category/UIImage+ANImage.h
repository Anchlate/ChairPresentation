//
//  UIImage+ANImage.h
//  FaceKTV
//
//  Created by PENG BAI on 15/9/7.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ANImage)


// 生成一个指定size的Image
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

// 等比例压缩
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
