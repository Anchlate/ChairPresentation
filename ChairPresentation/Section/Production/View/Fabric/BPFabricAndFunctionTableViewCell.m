
//
//  BPFabricAndFunctionTableViewCell.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/23.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricAndFunctionTableViewCell.h"
#import "BPFabricAndFunction.h"
#import "BPFabricAndFunctionChildView.h"

@interface BPFabricAndFunctionTableViewCell ()<BPFabricAndFunctionChildViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *accessoryBtn;
@property (nonatomic, strong) BPFabricAndFunctionChildView *childView;
@property (nonatomic, strong) UIView *seperatorView;

@end

@implementation BPFabricAndFunctionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectedBackgroundView = [[UIView alloc]init];
        self.selectedBackgroundView.backgroundColor = RGBColorAndAlpha(0, 0, 0, 0.5);
        
//        self.backgroundColor = [UIColor clearColor];
//        self.textLabel.textColor = [UIColor whiteColor];
//        self.textLabel.font = [UIFont systemFontOfSize:16 * [AppDelegate getAutoSizeScaleX]];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.accessoryBtn];
        [self.contentView addSubview:self.childView];
        [self.contentView addSubview:self.seperatorView];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    BPFabricAndFunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[BPFabricAndFunctionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(19);
        make.trailing.equalTo(weakSelf.contentView).offset(-20);
        make.height.equalTo(@44);
        
    }];
    
    [self.accessoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.trailing.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        
    }];
    
    [self.childView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.leading.and.trailing.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView);
    }];
    
    [self.seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(@1);
        
    }];
    
}

#pragma mark -DelegateMethod
#pragma mark -BPFabricAndFunctionChildViewDelegate
- (void)fabricAndFunctionChildView:(BPFabricAndFunctionChildView *)childView didSelectedFabricItem:(NSString *)fabricItem field:(NSString *)field
{
//    NSDictionary *dict = @{self.fabricAndFunction.nameEN : fabricItem};
//    
//    if ([self.delegate respondsToSelector:@selector(fabricAndFunctionTableViewCell:fabricDict:)]) {
//        [self.delegate fabricAndFunctionTableViewCell:self fabricDict:dict];
// }
    
    if ([self.delegate respondsToSelector:@selector(fabricAndFunctionTableViewCell:didAddAKey:andValue:)]) {
        
        [self.delegate fabricAndFunctionTableViewCell:self didAddAKey:field andValue:fabricItem];
        
    }
}

- (void)fabricAndFunctionChildView:(BPFabricAndFunctionChildView *)childView didCanceledFabricItem:(NSString *)fabricItem field:(NSString *)field
{
    /*
    NSDictionary *dict = @{self.fabricAndFunction.nameEN : fabricItem};
    
    if ([self.delegate respondsToSelector:@selector(fabricAndFunctionTableViewCell:fabricDict:)]) {
        [self.delegate fabricAndFunctionTableViewCell:self cancelFabricDict:dict];
    }
    */
    
    if ([self.delegate respondsToSelector:@selector(fabricAndFunctionTableViewCell:didCancledAKey:andValue:)]) {
        
        [self.delegate fabricAndFunctionTableViewCell:self didCancledAKey:field andValue:fabricItem];
        
    }
    
}


- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(fabricAndFunctionTableViewCell:didClickButton:)]) {
        
        [self.delegate fabricAndFunctionTableViewCell:self didClickButton:button];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -PrivateMethod
- (void)setupRightContent
{
    // 显示下拉subject
    if (_fabricAndFunction.fabricItems && _fabricAndFunction.fabricItems.count && !_fabricAndFunction.isShow) {
        
        [self.accessoryBtn setImage:[UIImage imageNamed:@"expansion_icon"] forState:UIControlStateNormal];
        
        // 隐藏下拉subject
    } else if (_fabricAndFunction.fabricItems && _fabricAndFunction.fabricItems.count && _fabricAndFunction.isShow){
        
        [self.accessoryBtn setImage:[UIImage imageNamed:@"collapse_icon"] forState:UIControlStateNormal];
        
        // 没有gandChildSubject的什么都不做
    } else {
        
        [self.accessoryBtn setImage:nil forState:UIControlStateNormal];
        
    }
    
    [self.childView reloadDatasource:_fabricAndFunction.fabricItems nameEN:_fabricAndFunction.nameEN];
}

#pragma mark -SetterMethod
- (void)setFabricAndFunction:(BPFabricAndFunction *)fabricAndFunction
{
    _fabricAndFunction = fabricAndFunction;
    
    self.titleLabel.text = fabricAndFunction.nameCH;
    
    [self setupRightContent];
}

#pragma mark -GetterMethod
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _titleLabel.font = kFontJZunYuanWithSize(MATCHSIZE(28));
    }
    return _titleLabel;
}

- (UIButton *)accessoryBtn
{
    if (!_accessoryBtn) {
        _accessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accessoryBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_accessoryBtn setContentHuggingPriority:UILayoutPriorityRequired
                                         forAxis:UILayoutConstraintAxisHorizontal];
        [_accessoryBtn setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _accessoryBtn;
}

- (UIView *)seperatorView
{
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc]init];
        _seperatorView.backgroundColor = RGBColorAndAlpha(192, 192, 192, 0.5);
    }
    return _seperatorView;
}

- (BPFabricAndFunctionChildView *)childView
{
    if (!_childView) {
        _childView = [[BPFabricAndFunctionChildView alloc]init];
        _childView.delegate = self;
    }
    return _childView;
}

@end