//
//  NSFileManager+BPFileManager.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (BPFileManager)

// 获取某目录下的所有文件
+ (NSArray *)filesInDicretoryPath:(NSString *)path;

// 获取某目录下的多有相同prefix的文件路径
+ (NSArray *)filesInDicretoryPath:(NSString *)path hasPrefix:(NSString *)prefix;

// 获取某目录下的所有文件夹路径
+ (NSArray *)foldsInDiredtoryPath:(NSString *)path;

// 获取某目录下的所有相同prefix文件夹的路径
+ (NSArray *)foldsPathInDiredtoryPath:(NSString *)path;

@end
