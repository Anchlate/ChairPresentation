//
//  BPFabricAndFunction.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricAndFunction.h"


@implementation BPFabricAndFunction

- (id)initWithNameCH:(NSString *)nameCH nameEN:(NSString *)nameEN
{
    if (self = [super init]) {
        
        self.nameCH = nameCH;
        self.nameEN = nameEN;
        self.isShow = NO;
        self.fabricItems = [self searchFabriItemsWithFabriNameEN:nameEN];
        self.cellHeight = 44.0 * (self.fabricItems.count + 1);
        
    }
    return self;
}

+ (id)fabricAndFunctionWithNameCH:(NSString *)nameCH nameEN:(NSString *)nameEN
{
    return [[BPFabricAndFunction alloc]initWithNameCH:nameCH nameEN:nameEN];
}

// 获取字段所有值
- (NSMutableArray *)searchFabriItemsWithFabriNameEN:(NSString *)nameEN
{
    //用数据库进行查找
    NSMutableArray *childs = [NSMutableArray array];
    
    Log(@"..:%@", self.nameEN);
    
    NSString *sql = [NSString stringWithFormat:@"SELECT DISTINCT %@ FROM %@ WHERE %@ NOT IN  ('无', '')", self.nameEN, kChairTable, self.nameEN];
    
    NSArray *fieldValues = [BPSearchChairDB searchFieldValueNorepeateFromDatabase:kDataBase sql:sql];
    
    //    chairBack_waist chairBack_waistAdjust
    NSMutableArray *allFields = [NSMutableArray arrayWithArray:fieldValues];
    
    for (NSString *fabricItem in allFields) {
        BPFabricAndFunctionChild *child = [BPFabricAndFunctionChild fabricAndFunctionChildWithFabricItem:fabricItem field:self.nameEN];
        [childs addObject:child];
    }
    
    // 将chairBack_waist 和 chairBack_waistAdjust并在一起
    if ([self.nameEN isEqualToString:@"chairBack_waist"]) {
        
        NSArray *chairBackAdjusts = [BPSearchChairDB searchFieldValueNorepeateFromDatabase:kDataBase sql:[NSString stringWithFormat:@"SELECT DISTINCT chairBack_waistAdjust FROM %@ WHERE chairBack_waistAdjust NOT IN  ('无', '')", kChairTable]];
        
        Log(@"..:%@", chairBackAdjusts);
        
        for (NSString *fabricItem in chairBackAdjusts) {
            
            BPFabricAndFunctionChild *child = [BPFabricAndFunctionChild fabricAndFunctionChildWithFabricItem:fabricItem field:@"chairBack_waistAdjust"];
            
            [childs addObject:child];
        }
        
//        [allFields addObjectsFromArray:chairBackAdjusts];
    }
    
    // 将cushion_height 和 cushion_deep、cushion_angle 可调并在一起
    if ([self.nameEN isEqualToString:@"cushion_height"]) {
        
        NSArray *cushionDeeps = [BPSearchChairDB searchFieldValueNorepeateFromDatabase:kDataBase sql:[NSString stringWithFormat:@"SELECT DISTINCT cushion_deep FROM %@ WHERE cushion_deep NOT IN  ('无', '')", kChairTable]];
        
        for (NSString *fabricItem in cushionDeeps) {
            
            BPFabricAndFunctionChild *child = [BPFabricAndFunctionChild fabricAndFunctionChildWithFabricItem:fabricItem field:@"cushion_deep"];
            
            [childs addObject:child];
        }
        
//        [allFields addObjectsFromArray:cushionDeeps];
        
        NSArray *cushionAndlges = [BPSearchChairDB searchFieldValueNorepeateFromDatabase:kDataBase sql:[NSString stringWithFormat:@"SELECT DISTINCT cushion_angle FROM %@ WHERE cushion_angle NOT IN  ('无', '')", kChairTable]];
        
        for (NSString *fabricItem in cushionAndlges) {
            
            BPFabricAndFunctionChild *child = [BPFabricAndFunctionChild fabricAndFunctionChildWithFabricItem:fabricItem field:@"cushion_angle"];
            
            [childs addObject:child];
        }
//        [allFields addObjectsFromArray:cushionAndlges];
        
        [childs exchangeObjectAtIndex:1 withObjectAtIndex:3];
        [childs exchangeObjectAtIndex:1 withObjectAtIndex:2];
        
    }
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"fabricItem" ascending:YES];
    
    if (!([self.nameEN isEqualToString:@"chairBack_height"] || [self.nameEN isEqualToString:@"chairBack_waist"]|| [self.nameEN isEqualToString:@"cushion_height"])) {
        
        [childs sortUsingDescriptors:@[des]];
        
    }
    
    return childs;
}

@end