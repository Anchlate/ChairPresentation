//
//  BPFilters.m
//  ChairPresentation
//
//  Created by chf on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFilters.h"


@implementation BPKeyValue

- (id) initWithValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    if (self = [super init]) {
        _key = key;
        _value = value;
        _tag = tag;
    }
    return self;
}

+ (instancetype) objectWithValue:(NSString *)value key:(NSString *)key tag:(NSInteger) tag
{
    return [[self alloc]initWithValue:value key:key tag:tag];
}

@end



@implementation BPFilters


+ (BPFilters *)sharedFilter
{
    static BPFilters *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
        /** array = {[BPKeyValue alloc],[BPKeyValue alloc]} */
        sharedManagerInstance.dictionary = [NSMutableDictionary dictionaryWithDictionary:@{BPPRICE:[BPKeyValue alloc],BPSERIES:[BPKeyValue alloc],BPAPPLICATION:[NSMutableArray array],BPFABRICS:[NSMutableArray array],BPFUNCTION:[NSMutableArray array],BPSEARCH:[BPKeyValue alloc]}];
        sharedManagerInstance.fieldItems = [NSMutableArray array];
    });
    return sharedManagerInstance;
}

-(void)clear{
    _dictionary =  [NSMutableDictionary dictionaryWithDictionary:@{BPPRICE:[BPKeyValue alloc],BPSERIES:[BPKeyValue alloc],BPAPPLICATION:[NSMutableArray array],BPFABRICS:[NSMutableArray array],BPFUNCTION:[NSMutableArray array],BPSEARCH:[BPKeyValue alloc]}];
}

-(void)addReplaceFilters:(BPKeyValue *)filters key:(NSString *)key{
    
    if ([key isEqualToString:BPPRICE]) {
        [self.dictionary setObject:filters forKey:BPPRICE];
    }else if ([key isEqualToString:BPSERIES]){
        BPKeyValue *object = self.dictionary[BPSERIES];
        if ([object.value isEqualToString:filters.value]) {
            Log(@"移除 - %@",filters.value);
            [self.dictionary setObject:[BPKeyValue alloc] forKey:BPSERIES];
        }else{
            Log(@"%@ 替换 %@",filters.value,object.value);
            [self.dictionary setObject:filters forKey:BPSERIES];
            [self.fieldItems addObject:filters];
        }
    }else if ([key isEqualToString:BPAPPLICATION]){
        
        NSMutableArray *selArray = self.dictionary[BPAPPLICATION];
        if (selArray.count == 0) {
            Log(@"添加用途选项");
            [selArray addObject:filters];
        }else{
            BPKeyValue *kv = nil;
            for (int i=0; i<selArray.count; i++) {
                BPKeyValue *object = selArray[i];
                if ([object.key isEqualToString:filters.key]) {

                    kv = selArray[i];
                    break;
                }
            }
            
            if (kv) {
                [selArray removeObject:kv];
            } else {
                [selArray addObject:filters];
            }

        }
        [self.dictionary setObject:selArray forKey:BPAPPLICATION];
    }else if ([key isEqualToString:BPFABRICS]){
        NSMutableArray *selArray = self.dictionary[BPFABRICS];
        if (selArray.count == 0) {
            [selArray addObject:filters];
        }else{
            BPKeyValue *kv = nil;
            for (int i=0; i<selArray.count; i++) {
                
                BPKeyValue *object = selArray[i];
                if ([object.key isEqualToString:filters.key] && [object.value isEqualToString:filters.value]) {
                    kv = selArray[i];
                    break;
                }
            }
            if (kv) {
                [selArray removeObject:kv];
            } else {
                [selArray addObject:filters];
            }
            
        }
        [self.dictionary setObject:selArray forKey:BPFABRICS];
    }else if ([key isEqualToString:BPFUNCTION]){
        NSMutableArray *selArray = self.dictionary[BPFUNCTION];
        if (selArray.count == 0) {
            [selArray addObject:filters];
        }else{
            BPKeyValue *kv = nil;
            for (int i=0; i<selArray.count; i++) {
                
                BPKeyValue *object = selArray[i];
                if ([object.key isEqualToString:filters.key] && [object.value isEqualToString:filters.value]) {
                    kv = selArray[i];
                    break;
                }
            }
            if (kv) {
                [selArray removeObject:kv];
            } else {
                [selArray addObject:filters];
            }
            
        }
        [self.dictionary setObject:selArray forKey:BPFUNCTION];
    }else if ([key isEqualToString:BPSEARCH]){
        BPKeyValue *object = self.dictionary[BPSEARCH];
        if ([object.value isEqualToString:filters.value]) {
            Log(@"移除 - %@",filters.value);
            [self.dictionary setObject:[BPKeyValue alloc] forKey:BPSEARCH];
        }else{
            Log(@"%@ 替换 %@",filters.value,object.value);
            [self.dictionary setObject:filters forKey:BPSEARCH];
            [self.fieldItems addObject:filters];
        }
    }
    
}

-(NSMutableArray *)getfiltersList{
    NSMutableArray *mutArray = [NSMutableArray array];
    if (self.dictionary[BPPRICE]) {
        BPKeyValue *object = self.dictionary[BPPRICE];
        if (object.value) {
            [mutArray addObject:object];
        }
    }else{
        Log(@"已选条件-无价格这项");
    }
    if (self.dictionary[BPSERIES]) {
        BPKeyValue *object = self.dictionary[BPSERIES];
        if (object.value) {
            [mutArray addObject:object];
        }
    }else{
         Log(@"已选条件-无系列这项");
    }
    if (self.dictionary[BPAPPLICATION]) {
        [mutArray addObjectsFromArray:self.dictionary[BPAPPLICATION]];
    }else{
         Log(@"已选条件-无用途这项");
    }
    if (self.dictionary[BPFABRICS]) {
        [mutArray addObjectsFromArray:self.dictionary[BPFABRICS]];
    }else{
         Log(@"已选条件-无面料这项");
    }
    if (self.dictionary[BPFUNCTION]) {
        [mutArray addObjectsFromArray:self.dictionary[BPFUNCTION]];

    }else{
         Log(@"已选条件-无功能这项");
    }
    if (self.dictionary[BPSEARCH]) {
        BPKeyValue *object = self.dictionary[BPSEARCH];
        if (object.value) {
            [mutArray addObject:object];
        }
    }else{
        Log(@"已选条件-无功能这项");
    }
    
    return mutArray;
}



-(void)deleteFilters:(BPKeyValue *)keyvalue{
    [self.dictionary setObject:[BPKeyValue alloc] forKey:BPPRICE];
}


@end
