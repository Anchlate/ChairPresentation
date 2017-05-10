//
//  BPSearchChairDB.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSearchChairDB.h"
#import "BPChair.h"
#import "BPFilters.h"

@implementation BPSearchChairDB

+ (NSArray *)searchChairsFromChairDB:(NSString *)dataBase sql:(NSString *)sql
{
    NSMutableArray *chairs = [NSMutableArray array];
    
    NSString *dbPath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:dataBase];
    
    // 1. 创建db
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if (![db open]) {
        return nil;
    }
    
    // 2. 进行查询并获取结果
    FMResultSet *resultSet = [db executeQuery:sql];
    
    // 3. 获取到记录所有的字段
    NSArray *columnNames = [[resultSet columnNameToIndexMap]allKeys];
    
    // 4. 遍历 组成key-value字典
    while ([resultSet next]) {
        
        NSMutableDictionary *productDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in columnNames) {
            
            NSString *value = [resultSet stringForColumn:key];
            
            if (!value || value.length == 0) {
                [productDict setObject:@"" forKey:key];
            } else {
                [productDict setObject:value forKey:key];
            }
        }
        
        NSError *error = nil;
        
        // 转换为 BPChair 模型
        BPChair *chair = [[BPChair alloc]initWithDictionary:productDict error:&error];
        
        if (!error) {
            [chairs addObject:chair];
        }
    }
    
    // 5. 关闭数据库
    [db close];
    db = nil;
    
    // 6. 返回
    return chairs;
}

+ (NSArray *)searchFieldValueNorepeateFromDatabase:(NSString *)database sql:(NSString *)sql
{
    NSMutableArray *fieldValues = [NSMutableArray array];
    
    NSString *dbPath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:database];
    
    // 1. 创建db
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if (![db open]) {
        return nil;
    }
    
    // 2. 进行查询并获取结果
    FMResultSet *resultSet = [db executeQuery:sql];
    
    // 3. 获取到记录所有的字段
    NSArray *columnNames = [[resultSet columnNameToIndexMap]allKeys];
    
    // 4. 遍历 组成key-value字典
    while ([resultSet next]) {
        
        for (NSString *key in columnNames) {
            
            NSString *value = [resultSet stringForColumn:key];
            
            if (!value || value.length == 0) {
                
            } else {
                [fieldValues addObject:value];
            }
        }
        
    }
    
    // 5. 关闭数据库
    [db close];
    db = nil;
    
    // 6. 返回
    return fieldValues;
}

+ (NSArray *)searchAllChairs
{
    NSMutableArray *chairs = [NSMutableArray array];
    
    NSString *dbPath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:kDataBase];
    
    // 1. 创建db
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if (![db open]) {
        return nil;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@", kChairTable];
    
    // 2. 进行查询并获取结果
    FMResultSet *resultSet = [db executeQuery:sql];
    
    // 3. 获取到记录所有的字段
    NSArray *columnNames = [[resultSet columnNameToIndexMap]allKeys];
    
    // 4. 遍历 组成key-value字典
    while ([resultSet next]) {
        
        NSMutableDictionary *productDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in columnNames) {
            
            NSString *value = [resultSet stringForColumn:key];
            
            if (!value || value.length == 0) {
                [productDict setObject:@"" forKey:key];
            } else {
                [productDict setObject:value forKey:key];
            }
        }
        
        NSError *error = nil;
        
        // 转换为 BPChair 模型
        BPChair *chair = [[BPChair alloc]initWithDictionary:productDict error:&error];
        
        if (!error) {
            [chairs addObject:chair];
        }
    }
    
    // 5. 关闭数据库
    [db close];
    db = nil;
    
    // 6. 返回
    return chairs;
}

+ (NSString *)sqlStringWithFieldItems:(NSArray *)fieldItems
{
    NSString *originSql = [NSString stringWithFormat:@"select * from %@ where ", kChairTable];
    NSString *sql = [NSString stringWithFormat:@"%@", originSql];
    
    NSMutableArray *fieldItemsMut = [NSMutableArray arrayWithArray:fieldItems];
    
    BPKeyValue *firstKeyValue = [fieldItemsMut firstObject];
    
    if ([firstKeyValue.key isEqualToString:@"discount3_price"] || [firstKeyValue.key isEqualToString:@"discount35_price"]) {
        
        NSArray *prices = [firstKeyValue.value componentsSeparatedByString:@"-"];
        
        CGFloat minPrice = [[prices firstObject] floatValue];
        CGFloat maxPrice = [[prices lastObject] floatValue];
        
        sql = [sql stringByAppendingFormat:@"%@ > %f and %@ < %f", firstKeyValue.key, minPrice, firstKeyValue.key, maxPrice];
        
    } else {
        sql = [sql stringByAppendingFormat:@"%@ is '%@'", firstKeyValue.key, firstKeyValue.value];
    }
    
    [fieldItemsMut removeObject:firstKeyValue];
    
    for (BPKeyValue *keyValue in fieldItemsMut) {
        if ([keyValue.key isEqualToString:@"discount3_price"] || [keyValue.key isEqualToString:@"discount35_price"]) {
            
            NSArray *prices = [keyValue.value componentsSeparatedByString:@"-"];
            
            CGFloat minPrice = [[prices firstObject] floatValue];
            CGFloat maxPrice = [[prices lastObject] floatValue];
            
            sql = [sql stringByAppendingFormat:@"%@ > %f and %@ < %f", keyValue.key, minPrice, keyValue.key, maxPrice];
            
        } else {
            sql = [sql stringByAppendingFormat:@" and %@ is '%@'", keyValue.key, keyValue.value];
        }
    }
    
    if ([sql isEqualToString:originSql]) {
        return nil;
    }
    
    return sql;
}

+ (NSArray *)searchChairsWithFieldItems:(NSArray *)fieldItems
{
    
    NSString *sql = [self sqlStringWithFieldItems:fieldItems];
    
    Log(@"..搜索sql语句:%@", sql);
    
    NSArray *chairs = [self searchChairsFromChairDB:kDataBase sql:sql];
    
    return chairs;
}




@end