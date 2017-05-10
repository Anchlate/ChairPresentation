//
//  NSArray+BPArray.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/26.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BPArray)

+ (NSArray *)sortChairsWithHot:(NSArray *)chairs accending:(BOOL)accending;

+ (NSArray *)sortChairsWithPrice:(NSArray *)chairs Accending:(BOOL)accending;

@end
