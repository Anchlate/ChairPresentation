//
//  BPSearchChairDB.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPChair;

@interface BPSearchChairDB : NSObject


// 根据数据库和sql语句来查询chairs
+ (NSArray *)searchChairsFromChairDB:(NSString *)dataBase sql:(NSString *)sql;

// 根据数据库和sql语句来查询某字段不重所有复值
+ (NSArray *)searchFieldValueNorepeateFromDatabase:(NSString *)database sql:(NSString *)sql;

// 获取所有的数据库中所有的数据
+ (NSArray *)searchAllChairs;

// 将查询字段与值转换为sql语句
+ (NSString *)sqlStringWithFieldItems:(NSArray *)fieldItems;


// 根据条件来查询数据chair
+ (NSArray *)searchChairsWithFieldItems:(NSArray *)fieldItems;


@end