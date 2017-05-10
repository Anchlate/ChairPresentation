
//
//  NSFileManager+BPFileManager.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "NSFileManager+BPFileManager.h"

@implementation NSFileManager (BPFileManager)

+ (NSArray *)filesInDicretoryPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *fileList = [NSArray array];
    
    fileList = [manager contentsOfDirectoryAtPath:path error:&error];
    
    if (error) {
        fileList = nil;
    }
    
    return fileList;
}

+ (NSArray *)filesInDicretoryPath:(NSString *)path hasPrefix:(NSString *)prefix
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *fileList = [NSArray array];
    
    fileList = [manager contentsOfDirectoryAtPath:path error:&error];
    
    if (error || fileList.count == 0) {
        fileList = nil;
        return nil;
    }
        
    NSMutableArray *dirArray = [NSMutableArray array];
    
    for (NSString *file in fileList) {

        if ([file hasPrefix:prefix]) {
            
            [dirArray addObject:[path stringByAppendingPathComponent:file]];
        }
    }
    
    return dirArray;
}

+ (NSArray *)foldsInDiredtoryPath:(NSString *)path
{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *fileList = [NSArray array];
    
    fileList = [manager contentsOfDirectoryAtPath:path error:&error];
    
    if (error || fileList.count == 0) {
        fileList = nil;
        return nil;
    }
    
    NSMutableArray *dirArray = [NSMutableArray array];
    
    for (NSString *file in fileList) {
        
        NSString *foldPath = [path stringByAppendingPathComponent:file];
        
        if ([NSFileManager isFilePathDirectory:foldPath]) {
            [dirArray addObject:file];
        }
    }
    
    return dirArray;
    
}

+ (NSArray *)foldsPathInDiredtoryPath:(NSString *)path
{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *fileList = [NSArray array];
    
    fileList = [manager contentsOfDirectoryAtPath:path error:&error];
    
    if (error || fileList.count == 0) {
        fileList = nil;
        return nil;
    }
    
    NSMutableArray *dirArray = [NSMutableArray array];
    
    for (NSString *file in fileList) {
        
        NSString *foldPath = [path stringByAppendingPathComponent:file];
        
        if ([NSFileManager isFilePathDirectory:foldPath]) {
            [dirArray addObject:foldPath];
        }
    }
    
    return dirArray;
    
}

+ (BOOL)isFilePathDirectory:(NSString *)path
{
    BOOL isDir = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    
    return isDir;
}

@end