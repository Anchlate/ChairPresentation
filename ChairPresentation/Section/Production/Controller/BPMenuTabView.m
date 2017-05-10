//
//  BPMenuTabView.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPMenuTabView.h"
#import "BPPriceSelectionView.h"

@interface BPMenuTabView()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , strong) BPPriceSelectionView *priceSelectionView;

@end



@implementation BPMenuTabView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initData];
        
        [self addSubview:self.tableView];
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
    }
    return self;
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BPMenuCell *cell;
    cell = [[BPMenuCell alloc] initCellHeightID:@"menuCell"];
    return cell.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _priceSelectionView = [[BPPriceSelectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    return _priceSelectionView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BPItem *item = self.dataSource[indexPath.row];
    
    BPMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
         cell = [[BPMenuCell alloc] initWithIdentifier:@"menuCell" tableView:tableView width:self.frame.size.width];
    }

    cell.item = item;
    cell.tag = indexPath.row;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(menuTabView:sender:)]) {
        [_delegate menuTabView:self sender:[tableView cellForRowAtIndexPath:indexPath]];
    }

}


-(UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.userInteractionEnabled = YES;
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

-(void)initData{
    
    {
        BPItem *item =[[BPItem alloc] init];
        item.title = @"首页";
        item.icon = @"menu_home_icon";
        item.selectedicon = @"menu_home_h_icon";
        [self.dataSource addObject:item];
    }
    {
        BPItem *item =[[BPItem alloc] init];
        item.title = @"全部产品";
        item.icon = @"menu_allproduction_icon";
        item.selectedicon = @"menu_allproduction_h_icon";
        [self.dataSource addObject:item];
    }
    {
        BPItem *item =[[BPItem alloc] init];
        item.title = @"案例";
        item.icon = @"menu_case_icon";
        item.selectedicon = @"menu_case_h_icon";
        [self.dataSource addObject:item];
    }
  
}

@end
