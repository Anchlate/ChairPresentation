
//
//  BPFabricAndFunctionChildTableViewCell.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/24.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricAndFunctionChildTableViewCell.h"
#import "BPFabricAndFunctionChild.h"

@interface BPFabricAndFunctionChildTableViewCell ()

@property (nonatomic, strong) UIView *seperatorView;

@end

@implementation BPFabricAndFunctionChildTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        self.textLabel.font = kFontJZunYuanWithSize(MATCHSIZE(28));
        [self.contentView addSubview:self.seperatorView];
        self.imageView.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleOfTapOnImageView:)];
//        [self.imageView addSubview:tap];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF(weakSelf);
    
    [self.seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.trailing.equalTo(weakSelf.contentView);
        make.height.equalTo(@1);
        
    }];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    BPFabricAndFunctionChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[BPFabricAndFunctionChildTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

/*
- (void)handleOfTapOnImageView:(UIGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(fabricAndFunctionChildTableViewCell:didSelectedChild:)]) {
        
        [self.delegate fabricAndFunctionChildTableViewCell:self didSelectedChild:self.child];
        
    }
}
*/

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -SetterMethod
- (void)setChild:(BPFabricAndFunctionChild *)child
{
    _child = child;

    self.textLabel.text = child.fabricItem;
    if (child.isSelected) {
        self.imageView.image = [UIImage imageNamed:@"selected"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"unselected"];
    }
    
}

- (UIView *)seperatorView
{
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc]init];
        _seperatorView.backgroundColor = RGBColorAndAlpha(192, 192, 192, 0.5);
    }
    return _seperatorView;
}

@end