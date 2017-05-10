//
//  BPFabricAndFunctionChild.h
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPFabricAndFunctionChild : NSObject

@property (nonatomic, copy) NSString *field;
@property (nonatomic, copy) NSString *fabricItem;
@property (nonatomic, assign) BOOL isSelected;

- (id)initWithFabricItem:(NSString *)fabricItem;
+ (id)fabricAndFunctionChildWithFabricItem:(NSString *)fabricItem;

- (id)initWithFabricItem:(NSString *)fabricItem field:(NSString *)field;
+ (id)fabricAndFunctionChildWithFabricItem:(NSString *)fabricItem field:(NSString *)field;


@end
