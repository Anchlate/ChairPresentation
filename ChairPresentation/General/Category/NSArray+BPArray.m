
//
//  NSArray+BPArray.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/26.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "NSArray+BPArray.h"

@implementation NSArray (BPArray)

+ (NSArray *)sortChairsWithPrice:(NSArray *)chairs Accending:(BOOL)accending
{
    NSSortDescriptor *des1 = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:accending];
    NSArray *arr = [chairs sortedArrayUsingDescriptors:@[des1]];
    return arr;
}

+ (NSArray *)sortChairsWithHot:(NSArray *)chairs accending:(BOOL)accending
{
    NSSortDescriptor *des1 = [NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:accending];
    NSArray *arr = [chairs sortedArrayUsingDescriptors:@[des1]];
    return arr;
}


@end
