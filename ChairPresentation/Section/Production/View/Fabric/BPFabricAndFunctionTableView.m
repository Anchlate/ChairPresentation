//
//  BPFabricAndFunctionTableView.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricAndFunctionTableView.h"
#import "BPFabricAndFunctionTableViewCell.h"
#import "BPFabricAndFunction.h"
#import "BPFabricAndFunctionChild.h"

@interface BPFabricAndFunctionTableView () <UITableViewDataSource, UITableViewDelegate, BPFabricAndFunctionTableViewCellDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *comfirmBtn;

@property (nonatomic, copy) NSIndexPath *selelctedIndexPath;
@property (nonatomic, copy) NSMutableArray *selections;

@end

@implementation BPFabricAndFunctionTableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.comfirmBtn];
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)title datasource:(NSArray *)datasource
{
    if (self = [super init]) {
        
        self.titleLabel.text = title;
        [self.datasource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF(weakSelf);
    
    // titleLabel
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf).offset(MATCHSIZE(30));
        make.top.equalTo(weakSelf).offset(MATCHSIZE(40));
        make.trailing.equalTo(weakSelf.comfirmBtn.mas_leading);
        
    }];
    
    [self.comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf).offset(-MATCHSIZE(40));
        make.centerY.equalTo(weakSelf.titleLabel);
        make.size.mas_equalTo(CGSizeMake(MATCHSIZE(100), MATCHSIZE(52)));
        
    }];
    
    
    // tableView
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.comfirmBtn.mas_bottom);
        make.leading.trailing.bottom.equalTo(weakSelf);
    }];
}

#pragma mark -DelegateMethod
#pragma mark -UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPFabricAndFunctionTableViewCell *cell = [BPFabricAndFunctionTableViewCell cellWithTableView:tableView];
    
    BPFabricAndFunction *fabricAndFunction = self.datasource[indexPath.row];
    
    cell.fabricAndFunction = fabricAndFunction;
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BPChildSubject *subject = self.datasource[indexPath.row];
    BPFabricAndFunction *fabricAndFunction = self.datasource[indexPath.row];
    
    if (fabricAndFunction.fabricItems && fabricAndFunction.fabricItems.count && !fabricAndFunction.isShow) {
        
        return 44;
        
    } else if (fabricAndFunction.fabricItems && fabricAndFunction.fabricItems.count && fabricAndFunction.isShow){
        
        return fabricAndFunction.cellHeight;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    self.selelctedIndexPath = indexPath;
    
    //
//    BPChildSubject *subject = self.datasource[indexPath.row];
    BPFabricAndFunction *fabricAndFunction = self.datasource[indexPath.row];
    
    //
    if (fabricAndFunction.fabricItems && fabricAndFunction.fabricItems.count && !fabricAndFunction.isShow) {
        
        fabricAndFunction.isShow = YES;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (fabricAndFunction.fabricItems && fabricAndFunction.fabricItems.count && fabricAndFunction.isShow){
        
        fabricAndFunction.isShow = NO;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
//        if ([self.delegate respondsToSelector:@selector(childSubjectView:didSelecetedSubject:subjectName:)]) {
//            [self.delegate childSubjectView:self didSelecetedSubject:subject.subjectId subjectName:subject.subjectName];
//        }
        
    }
}

#pragma mark -BPFabricAndFunctionTableViewCellDelegate
- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell didAddAKey:(NSString *)key andValue:(NSString *)value;
{
    if ([self.delegate respondsToSelector:@selector(selectedFabricAndFunctionItemKey:value:)]) {
        [self.delegate selectedFabricAndFunctionItemKey:key value:value];
    }
}

- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell didCancledAKey:(NSString *)key andValue:(NSString *)value
{
    if ([self.delegate respondsToSelector:@selector(canceledFabricAndFunctionItemKey:value:)]) {
        [self.delegate canceledFabricAndFunctionItemKey:key value:value];
    }
}

- (void)fabricAndFunctionTableViewCell:(BPFabricAndFunctionTableViewCell *)cell didClickButton:(UIButton *)button
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.selelctedIndexPath = indexPath;
    
    //
    //    BPChildSubject *subject = self.datasource[indexPath.row];
    BPFabricAndFunction *fabricAndFunction = self.datasource[indexPath.row];
    
    //
    if (fabricAndFunction.fabricItems && fabricAndFunction.fabricItems.count && !fabricAndFunction.isShow) {
        
        fabricAndFunction.isShow = YES;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (fabricAndFunction.fabricItems && fabricAndFunction.fabricItems.count && fabricAndFunction.isShow){
        
        fabricAndFunction.isShow = NO;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
        //        if ([self.delegate respondsToSelector:@selector(childSubjectView:didSelecetedSubject:subjectName:)]) {
        //            [self.delegate childSubjectView:self didSelecetedSubject:subject.subjectId subjectName:subject.subjectName];
        //        }
        
    }
    
}



- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(selections:)]) {
        [self.delegate selections:self.selections];
        
        /*
        BPFabricAndFunction *fab = [self.datasource firstObject];
        BPFabricAndFunctionChild *child = [fab.fabricItems firstObject];
        child.isSelected = YES;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         */
        
    }
}

- (void)deselectCellWithKey:(NSString *)key value:(NSString *)value
{
    /*
    for (BPFabricAndFunction *faf in self.datasource) {
        
        if ([key isEqualToString:faf.nameEN]) {
            
            NSInteger row = [self.datasource indexOfObject:faf];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
            BPFabricAndFunctionTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexpath];
            [cell deselectCellWithKey:key value:value];
            
            break;
        }
        
    }
    */
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _titleLabel.font = kFontJZunYuanWithSize(MATCHSIZE(28));
        
    }
    return _titleLabel;
}

- (UIButton *)comfirmBtn
{
    if (!_comfirmBtn) {
        
        _comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_comfirmBtn setTitleColor:nil forState:UIControlStateNormal];
        _comfirmBtn.layer.borderWidth = MATCHSIZE(2);
        _comfirmBtn.layer.borderColor = [RGBColorAndAlpha(89, 177, 227, 1) CGColor];
        _comfirmBtn.layer.cornerRadius = MATCHSIZE(10);
        _comfirmBtn.clipsToBounds = YES;
        [_comfirmBtn setTitleColor:MainColor forState:UIControlStateNormal];
        _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        
        [_comfirmBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_comfirmBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_comfirmBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comfirmBtn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.scrollEnabled = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _tableView;
}

- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (NSMutableArray *)selections
{
    if (!_selections) {
        _selections = [NSMutableArray array];
    }
    return _selections;
}

@end
