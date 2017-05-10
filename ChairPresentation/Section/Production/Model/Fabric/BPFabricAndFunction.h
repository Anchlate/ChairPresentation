//
//  BPFabricAndFunction.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPFabricAndFunctionChild.h"

@interface BPFabricAndFunction : NSObject

@property (nonatomic, copy) NSString *nameCH;
@property (nonatomic, copy) NSString *nameEN;
@property (nonatomic, copy) NSMutableArray *fabricItems;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGFloat cellHeight;


- (id)initWithNameCH:(NSString *)nameCH nameEN:(NSString *)nameEN;
+ (id)fabricAndFunctionWithNameCH:(NSString *)nameCH nameEN:(NSString *)nameEN;

@end
