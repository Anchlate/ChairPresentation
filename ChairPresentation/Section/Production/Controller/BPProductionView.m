//
//  BPProductionView.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionView.h"


@interface BPProductionView()<BPMenuTabViewDelegate , BPSettingButtonDelegate , BPProductionCViewDelegate , BPProductionCVCellHeaderVDelegate , BPPopSettingVDelegate ,BPPSequenceViewDelegate , BPSearchViewDelegate , BPSeriesViewDelegate , BPApplicationViewDelegate , BPFabricsViewDelegate , BPFunctionViewDelegate>




@end


@implementation BPProductionView


-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.lView];
        
        [self.contentV addSubview:self.rView];
        
        [self.lView addSubview:self.menuTabView];
        
        [self.lView addSubview:self.settingBtn];
        
        
        [self.rView addSubview:self.productionConditionView];
        
        if ([BPFilters sharedFilter].getfiltersList.count != 0) {
            self.productionConditionView.hidden = NO;
        }else{
            self.productionConditionView.hidden = YES;
        }
        
        [self.rView addSubview:self.productionCView];
        
        if (self.productionConditionView.hidden) {
            self.productionCView.frame = CGRectMake(0,0, self.rView.frame.size.width, self.rView.frame.size.height);
        }else{
            self.productionCView.frame = CGRectMake(0, self.productionConditionView.frame.origin.y+self.productionConditionView.frame.size.height, self.rView.frame.size.width, self.rView.frame.size.height-(self.productionConditionView.frame.origin.y+self.productionConditionView.frame.size.height));
        }
        
        [self.contentV addSubview:self.settingView];
        
        [self.contentV addSubview:self.psequenceView];
        
        [self.contentV addSubview:self.searchView];
     
        [self.contentV addSubview:self.seriesView];
        
        [self.contentV addSubview:self.applicationView];
        
        [self.contentV addSubview:self.fabricsView];
        
        [self.contentV addSubview:self.functionView];
        
        
        
        
    }
    return self;
}


#pragma  - mark 左边菜单栏 事件监听回调
-(void)menuTabView:(BPMenuTabView *)view sender:(id)sender{
    Log(@"菜单");
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
        [_delegate productionView:self sender:sender tag:1];
    }
    
}

#pragma  - mark 设置点击 事件监听回调
-(void)settingButton:(BPSettingButton *)view sender:(id)sender{
    Log(@"设置");
    self.settingView.hidden = NO;
}

#pragma mark - 设置-选择项点击事件回调
-(void)popSettingView:(BPPopSettingV *)view sender:(id)sender{
    
    self.settingView.hidden = YES;
    if (sender == view.logOut) {
        if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
            [_delegate productionView:self sender:view tag:2];
        }
    }else{
        UITableViewCell *cell = (UITableViewCell *)sender;
        Log(@"%@",cell.textLabel.text);
        /**************code : SVIP 或者 VIP 价格的切换*************************/
        [self.productionCView.collectionView reloadData];
    }
}

#pragma -mark 跳转到产品详情页
-(void)productionCView:(BPProductionCView *)view sender:(id)sender chair:(BPChair *)chair{
    Log(@"跳转到产品详情页");
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:chair:)]) {
        [_delegate productionView:self sender:sender tag:3 chair:chair];
    }
}

-(void)psequenceView:(BPPSequenceView *)view sender:(id)sender{
    /**************code : 根据排序方式 刷新 产品列表*************************/
    UITableViewCell *cell = (UITableViewCell *)sender;
    if (cell.tag == 1) {
        [self.productionCView hotSequence];
    }else if (cell.tag == 2){
        Log(@"%@",cell.textLabel.text);
        [self.productionCView highToLowSequence];
    }else if (cell.tag == 3){
        Log(@"%@",cell.textLabel.text);
        [self.productionCView lowToHighSequence];
    }
    
    
}

-(void)pSearchView:(BPSearchView *)view sender:(id)sender{
    Log(@"搜索回调");
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
        [_delegate productionView:sender sender:sender tag:4];
    }
    if (sender == view) {
        
    }else{
        UITableViewCell *cell = (UITableViewCell *)sender;
        Log(@"%@",cell.textLabel.text);
    }
    
}

- (void) seriesView:(BPSeriesView *)view sender:(id) sender{
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
        if ([sender class] == [BPSeriesView class]) {
            [_delegate productionView:sender sender:sender tag:5];
        }else{
            [_delegate productionView:sender sender:sender tag:6];
        }
    }
}

- (void) applicationView:(BPApplicationView *)view sender:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
        if ([sender class] == [BPApplicationView class]) {
            [_delegate productionView:sender sender:sender tag:7];
        }else{
            [_delegate productionView:sender sender:sender tag:8];
        }
    }
}

- (void) fabricsView:(BPFabricsView *)view sender:(id) sender{
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
        if ([sender class] == [BPFabricsView class]) {
            [_delegate productionView:sender sender:sender tag:9];
        }else{
            [_delegate productionView:sender sender:sender tag:10];
        }
    }
}

- (void) functionView:(BPFunctionView *)view sender:(id) sender{
    if (_delegate && [_delegate respondsToSelector:@selector(productionView:sender:tag:)]) {
        if ([sender class] == [BPFunctionView class]) {
            [_delegate productionView:sender sender:sender tag:11];
        }else{
            [_delegate productionView:sender sender:sender tag:12];
        }
    }
}

#pragma mark - 已选条件 回调
-(void)productionCVCellHeaderV:(BPProductionCVCellHeaderV *)view sender:(id)sender{
    
    if (sender == view.deleteAll) {
        Log(@"productionCVCellHeaderV 的 回调 deleteAll");
        [self.productionCView searchAllData];
    }
}

-(void)productionCVCellHeaderV:(BPProductionCVCellHeaderV *)view atc:(NSInteger)action{
    if (action == 1) {
        self.productionCView.frame = CGRectMake(0, view.frame.origin.y+view.frame.size.height, self.rView.frame.size.width, self.rView.frame.size.height-(view.frame.origin.y+view.frame.size.height));
    }else if (action == 2){
         self.productionCView.frame = CGRectMake(0, 0, self.rView.frame.size.width, self.rView.frame.size.height);
    }
}



-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
       
        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, MATCHSIZE(2))];
        hLine.backgroundColor = RGBColorAndAlpha(247, 247, 247, 1);
        [_contentV addSubview:hLine];
    }
    return _contentV;
}



-(UIView *)lView{
    if (!_lView) {
        _lView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, MATCHSIZE(426), self.contentV.frame.size.height)];
        
        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(_lView.frame.size.width-MATCHSIZE(2), 0, MATCHSIZE(2), _lView.frame.size.height)];
        vLine.backgroundColor = RGBColorAndAlpha(247, 247, 247, 1);
        [_lView addSubview:vLine];
        
    }
    return _lView;
}

-(UIView *)rView{
    if (!_rView) {
        _rView = [[UIView alloc] initWithFrame:CGRectMake(self.lView.frame.size.width+self.lView.frame.origin.x, 1, self.contentV.frame.size.width-MATCHSIZE(426), self.frame.size.height)];
    }
    return _rView;
}

-(BPSettingButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [[BPSettingButton alloc] initWithFrame:CGRectMake(0, self.lView.frame.size.height*0.925, self.lView.frame.size.width-1, self.lView.frame.size.height*0.075)];
        _settingBtn.delegate = self;
        
        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.lView.frame.size.width, MATCHSIZE(2))];
        hLine.backgroundColor = RGBColorAndAlpha(247, 247, 247, 1);
        [_settingBtn addSubview:hLine];
    }
    return _settingBtn;
}

-(BPMenuTabView *)menuTabView{
    if (!_menuTabView) {
        _menuTabView = [[BPMenuTabView alloc] initWithFrame:CGRectMake(0, 0, self.lView.frame.size.width-1, self.lView.frame.size.height*0.925)];
        _menuTabView.delegate = self;
    }
    return _menuTabView;
}

-(BPProductionCView *)productionCView{
    if (!_productionCView) {
        _productionCView = [[BPProductionCView alloc] initWithFrame:CGRectMake(0, 0, self.rView.frame.size.width, self.rView.frame.size.height)];
        _productionCView.delegate = self;
    }
    return _productionCView;
}

-(BPPSequenceView *)psequenceView{
    if (!_psequenceView) {
        _psequenceView = [[BPPSequenceView alloc] initWithFrame:self.contentV.frame];
        _psequenceView.delegate = self;
        _psequenceView.hidden = YES;
    }
    return _psequenceView;
}

-(BPSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[BPSearchView alloc] initWithFrame:self.contentV.frame];
        _searchView.delegate = self;
        _searchView.hidden = YES;
    }
    return _searchView;
}

-(BPSeriesView *)seriesView{
    if (!_seriesView) {
        _seriesView = [[BPSeriesView alloc] initWithFrame:self.contentV.frame];
        _seriesView.delegate = self;
        _seriesView.hidden = YES;
    }
    return _seriesView;
}

-(BPApplicationView *)applicationView{
    if (!_applicationView) {
        _applicationView = [[BPApplicationView alloc] initWithFrame:self.contentV.frame];
        _applicationView.delegate = self;
        _applicationView.hidden = YES;
    }
    return _applicationView;
}

-(BPFabricsView *)fabricsView{
    if (!_fabricsView) {
        _fabricsView = [[BPFabricsView alloc] initWithFrame:self.contentV.frame];
        _fabricsView.delegate = self;
        _fabricsView.hidden = YES;
    }
    return _fabricsView;
}

-(BPFunctionView *)functionView{
    if (!_functionView) {
        _functionView = [[BPFunctionView alloc] initWithFrame:self.contentV.frame];
        _functionView.delegate = self;
        _functionView.hidden = YES;
    }
    return _functionView;
}

-(BPProductionCVCellHeaderV *)productionConditionView{
    if (!_productionConditionView) {
        _productionConditionView=[[BPProductionCVCellHeaderV alloc] initWithFrame:CGRectMake(0, 0, self.rView.frame.size.width, MATCHSIZE(100))];
        _productionConditionView.delegate = self;
//        _productionConditionView.hidden = YES;
    }
    return _productionConditionView;
}

-(BPPopSettingV *)settingView{
    if (!_settingView) {
        _settingView = [[BPPopSettingV alloc] initWithFrame:self.contentV.frame point:CGPointMake(self.settingBtn.frame.origin.x+30, self.settingBtn.frame.origin.y)];
        _settingView.delegate = self;
        _settingView.hidden = YES;
    }
    return _settingView;
}

@end
