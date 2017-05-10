
//
//  BPFabricAndFunctionChild.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricAndFunctionChild.h"

@implementation BPFabricAndFunctionChild

- (id)initWithFabricItem:(NSString *)fabricItem
{
    if (self = [super init]) {
        self.fabricItem = fabricItem;
        self.isSelected = NO;
    }
    return self;
}

+ (id)fabricAndFunctionChildWithFabricItem:(NSString *)fabricItem
{
    return [[BPFabricAndFunctionChild alloc]initWithFabricItem:fabricItem];
}

- (id)initWithFabricItem:(NSString *)fabricItem field:(NSString *)field
{
    if (self = [super init]) {
        self.fabricItem = fabricItem;
        self.field = field;
        self.isSelected = NO;
    }
    return self;
}

+ (id)fabricAndFunctionChildWithFabricItem:(NSString *)fabricItem field:(NSString *)field
{
    return [[BPFabricAndFunctionChild alloc]initWithFabricItem:fabricItem field:field];
}

@end