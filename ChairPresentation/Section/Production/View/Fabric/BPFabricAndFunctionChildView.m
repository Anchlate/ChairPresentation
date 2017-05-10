
//
//  BPFabricAndFunctionChildView.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricAndFunctionChildView.h"
#import "BPFabricAndFunctionChild.h"
#import "BPFabricAndFunctionChildTableViewCell.h"


@interface BPFabricAndFunctionChildView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BPFabricAndFunctionChildView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF(weakSelf);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
}

#pragma mark -DelegateMethod
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPFabricAndFunctionChildTableViewCell *cell = [BPFabricAndFunctionChildTableViewCell cellWithTableView:tableView];
    
    BPFabricAndFunctionChild *child = self.datasource[indexPath.row];
    
    cell.child = child;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    self.selectedIndexPath = indexPath;
    
    //
    BPFabricAndFunctionChild *child = self.datasource[indexPath.row];
    
    
    /*********************************************/

    Log(@"............??key:%@--value:%@", child.field,child.fabricItem);
    
    [self searchWithKey:child.field value:child.fabricItem data:^(BOOL data) {
        if (data) {
            if (!child.isSelected) {
                
                child.isSelected = YES;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildView:didSelectedFabricItem:field:)]) {
                    [self.delegate fabricAndFunctionChildView:self didSelectedFabricItem:child.fabricItem field:child.field];
                }
                
            } else {
                
                child.isSelected = NO;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildView:didCanceledFabricItem:field:)]) {
                    [self.delegate fabricAndFunctionChildView:self didCanceledFabricItem:child.fabricItem field:child.field];
                }
                
            }
        }
    }];
    
    /*********************************************/
    
//    if (!child.isSelected) {
//        
//        child.isSelected = YES;
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildView:didSelectedFabricItem:)]) {
//            [self.delegate fabricAndFunctionChildView:self didSelectedFabricItem:child.fabricItem];
//        }
//        
//    } else {
//        
//        child.isSelected = NO;
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildView:didCanceledFabricItem:)]) {
//            [self.delegate fabricAndFunctionChildView:self didCanceledFabricItem:child.fabricItem];
//        }
//        
//    }
}

/*
- (void)fabricAndFunctionChildTableViewCell:(BPFabricAndFunctionChildTableViewCell *)cell didSelectedChild:(BPFabricAndFunctionChild *)child
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Log(@"......indexPath:%@", indexPath);
    
    //
    self.selectedIndexPath = indexPath;
    
    //
//    BPFabricAndFunctionChild *child = self.datasource[indexPath.row];
 
    
    [self searchWithKey:self.nameEN value:child.fabricItem data:^(BOOL data) {
        if (data) {
            if (!child.isSelected) {
                
                child.isSelected = YES;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildView:didSelectedFabricItem:)]) {
                    [self.delegate fabricAndFunctionChildView:self didSelectedFabricItem:child.fabricItem];
                }
                
            } else {
                
                child.isSelected = NO;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildView:didCanceledFabricItem:)]) {
                    [self.delegate fabricAndFunctionChildView:self didCanceledFabricItem:child.fabricItem];
                }
                
            }
        }
    }];

}
*/

#pragma mark -PublickMethod
- (void)reloadDatasource:(NSArray *)datasource nameEN:(NSString *)nameEN
{
    self.nameEN = nameEN;
    [self.datasource removeAllObjects];
    [self.datasource addObjectsFromArray:datasource];
    
    [self.tableView reloadData];
}

#pragma mark -GetterMethod
- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(void)searchWithKey:(NSString *)key value:(NSString *)value  data:(void (^)(BOOL data))data{
    
    NSMutableArray *array =  [BPFilters sharedFilter].getfiltersList;
    [array addObject:[BPKeyValue objectWithValue:value key:key tag:2]];
    
    for (BPKeyValue *keyvalue in array) {
        Log(@"%@:%@",keyvalue.key,keyvalue.value);
    }
    NSArray *searchs = [BPSearchChairDB searchChairsWithFieldItems:array];
    Log(@"%@",searchs);
    if (searchs.count == 0) {
        data(NO);
    }else{
        data(YES);
    }
}


@end