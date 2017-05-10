//
//  BPFilters.h
//  ChairPresentation
//
//  Created by chf on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPKeyValue;

@interface BPKeyValue:NSObject

/** 1-系列  , 2-用途 ， 3-面料 ，4-功能 , 5-输入搜索 ， 6-价格*/
@property (nonatomic , assign) NSInteger tag;

@property (nonatomic , strong) NSString *key;

@property (nonatomic , strong) NSString *value;

+ (instancetype) objectWithValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag;

@end


@interface BPFilters : NSObject


+ (BPFilters *)sharedFilter;

@property (nonatomic , strong) NSMutableDictionary *dictionary;

@property (nonatomic , strong) NSMutableArray *fieldItems;

-(void)addReplaceFilters:(BPKeyValue *)filters key:(NSString *)key;

-(NSMutableArray *)getfiltersList;

-(void)clear;

-(void)deleteFilters:(BPKeyValue *)keyvalue;


@end
