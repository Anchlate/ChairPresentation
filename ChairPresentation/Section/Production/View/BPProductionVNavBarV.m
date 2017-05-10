//
//  BPProductionVNavBarV.m
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionVNavBarV.h"


@interface BPProductionVNavBarV()<UITextFieldDelegate>

@property (nonatomic , strong) UIView *contentV;

@property (nonatomic , strong) UIImageView *logoIV;


@end

@implementation BPProductionVNavBarV


-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.logoIV];
        
        [self.contentV addSubview:self.series];
        
        [self.contentV addSubview:self.application];
        
        [self.contentV addSubview:self.fabrics];
        
        [self.contentV addSubview:self.function];
        
        [self.contentV addSubview:self.search];
        
        [self.contentV addSubview:self.sequence];
        
        [self.contentV addSubview:self.searchTF];
        
    }
    return self;
}

-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentV.backgroundColor = [UIColor whiteColor];
    }
    return _contentV;
}


-(UIImageView *)logoIV{
    if (!_logoIV) {
        UIImage *icon = [UIImage imageNamed:@"logo_innav_icon"];
        _logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
        _logoIV.center = CGPointMake(icon.size.width/2+MATCHSIZE(40), self.frame.size.height/2);
        _logoIV.image = icon;
    }
    return _logoIV;
}


-(BPTextField *)searchTF{
    if (!_searchTF) {
        UIImage *icon = [UIImage imageNamed:@"enter_search"];
        
        _searchTF = [[BPTextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, MATCHSIZE(60)) andInsets:UIEdgeInsetsMake(0, MATCHSIZE(40)+icon.size.width+MATCHSIZE(10), 0, MATCHSIZE(10))];
        _searchTF.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _searchTF.placeholder = @"请输入搜索的内容";
        _searchTF.backgroundColor = RGBColorAndAlpha(245, 245, 245, 1);
        _searchTF.layer.masksToBounds = YES;
        _searchTF.layer.cornerRadius = MATCHSIZE(25);
        _searchTF.font = [UIFont boldSystemFontOfSize:MATCHSIZE(28)];
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTF.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _searchTF.clearButtonMode = UITextFieldViewModeAlways;
        _searchTF.returnKeyType=UIReturnKeyGo;
        _searchTF.delegate = self;
        [_searchTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        
        UIImageView *searchIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
        searchIV.center = CGPointMake(MATCHSIZE(40)+icon.size.width/2, _searchTF.frame.size.height/2);
        searchIV.image = icon;
        [_searchTF addSubview:searchIV];
        
        _searchTF.hidden = YES;
        
    }
    return _searchTF;
}


-(UIButton *)search{
    if (!_search) {
        UIImage *icon = [UIImage imageNamed:@"production_search"];
        _search = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MATCHSIZE(100), MATCHSIZE(100))];
        _search.center = CGPointMake(self.frame.size.width-(self.frame.size.width-self.sequence.frame.origin.x)-_search.frame.size.width/2-MATCHSIZE(40), self.frame.size.height/2);
        [_search setImage:icon forState:UIControlStateNormal];
        [_search addTarget:self action:@selector(searchAndSequenceAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _search;
}

-(UIButton *)sequence{
    if (!_sequence) {
        UIImage *icon = [UIImage imageNamed:@"production_sequence"];
        _sequence = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MATCHSIZE(100), MATCHSIZE(100))];
        _sequence.center = CGPointMake(self.frame.size.width-MATCHSIZE(40)-icon.size.width/2, self.frame.size.height/2);
        [_sequence setImage:icon forState:UIControlStateNormal];
        [_sequence addTarget:self action:@selector(searchAndSequenceAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _sequence;
}

-(BPExpColButton *)series{
    if (!_series) {
        NSString *text = @"系列";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(30)];
         CGSize textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _series = [[BPExpColButton alloc] initWithFrame:CGRectMake(MATCHSIZE(634), 0, textSize.width, MATCHSIZE(100))];
        _series.center = CGPointMake(_series.frame.origin.x, self.contentV.frame.size.height/2);
        _series.titleLabel.font = font;
        [_series setTitle:text forState:UIControlStateNormal];
        [_series setTitleColor:RGBColorAndAlpha(51, 51, 51, 1) forState:UIControlStateNormal];
        [_series setTitleColor:RGBColorAndAlpha(89, 177, 227, 1) forState:UIControlStateSelected];
        [_series addTarget:self action:@selector(conditionButton:) forControlEvents:UIControlEventTouchDown];
    }
    return _series;
}

-(BPExpColButton *)application{
    if (!_application) {
        NSString *text = @"用途";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(30)];
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _application = [[BPExpColButton alloc] initWithFrame:CGRectMake(self.series.frame.origin.x+self.series.frame.size.width, 0, textSize.width, MATCHSIZE(100))];
        _application.center = CGPointMake(_application.frame.origin.x+MATCHSIZE(150), self.contentV.frame.size.height/2);
        _application.titleLabel.font = font;
        [_application setTitle:text forState:UIControlStateNormal];
        [_application setTitleColor:RGBColorAndAlpha(51, 51, 51, 1) forState:UIControlStateNormal];
        [_application setTitleColor:RGBColorAndAlpha(89, 177, 227, 1) forState:UIControlStateSelected];
        [_application addTarget:self action:@selector(conditionButton:) forControlEvents:UIControlEventTouchDown];
    }
    return _application;
}

-(BPExpColButton *)fabrics{
    if (!_fabrics) {
        NSString *text = @"面料";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(30)];
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _fabrics = [[BPExpColButton alloc] initWithFrame:CGRectMake(self.application.frame.origin.x+self.application.frame.size.width, 0, textSize.width, MATCHSIZE(100))];
        _fabrics.center = CGPointMake(_fabrics.frame.origin.x+MATCHSIZE(150), self.contentV.frame.size.height/2);
        _fabrics.titleLabel.font = font;
        [_fabrics setTitle:text forState:UIControlStateNormal];
        [_fabrics setTitleColor:RGBColorAndAlpha(51, 51, 51, 1) forState:UIControlStateNormal];
        [_fabrics setTitleColor:RGBColorAndAlpha(89, 177, 227, 1) forState:UIControlStateSelected];
        [_fabrics addTarget:self action:@selector(conditionButton:) forControlEvents:UIControlEventTouchDown];
    }
    return _fabrics;
}
-(BPExpColButton *)function{
    if (!_function) {
        NSString *text = @"功能";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(30)];
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _function = [[BPExpColButton alloc] initWithFrame:CGRectMake(self.fabrics.frame.origin.x+self.fabrics.frame.size.width, 0, textSize.width, MATCHSIZE(100))];
        _function.center = CGPointMake(_function.frame.origin.x+MATCHSIZE(150), self.contentV.frame.size.height/2);
        _function.titleLabel.font = font;
        [_function setTitle:text forState:UIControlStateNormal];
        [_function setTitleColor:RGBColorAndAlpha(51, 51, 51, 1) forState:UIControlStateNormal];
        [_function setTitleColor:RGBColorAndAlpha(89, 177, 227, 1) forState:UIControlStateSelected];
        [_function addTarget:self action:@selector(conditionButton:) forControlEvents:UIControlEventTouchDown];
    }
    return _function;
}


-(void)conditionButton:(UIButton *)sender{

    if (sender == self.series) {
        self.application.status = NO;;
        self.fabrics.status = NO;
        self.function.status = NO;
    }else if (sender == self.application){
        self.series.status = NO;
        self.fabrics.status = NO;
        self.function.status = NO;
    }else if (sender == self.fabrics){
        self.series.status = NO;
        self.application.status = NO;
        self.function.status = NO;
    }else if (sender == self.function){
        self.series.status = NO;
        self.application.status = NO;
        self.fabrics.status = NO;
    }
    
    BPExpColButton *btn = (BPExpColButton *)sender;
    if (btn.status) {
        btn.status = NO;
    }else{
        btn.status = YES;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(productionVNavBarV:sender:)]) {
        [_delegate productionVNavBarV:self sender:btn];
    }
}


-(void)searchAndSequenceAction:(UIButton *)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(productionVNavBarV:sender:)]) {
        [_delegate productionVNavBarV:self sender:sender];
    }
    if (sender == self.search) {
        //展开键盘
        [self.searchTF becomeFirstResponder];
    }
   
    self.series.status = NO;
    self.application.status = NO;
    self.fabrics.status = NO;
    self.function.status = NO;

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(productionVNavBarV:sender:)]) {
        [_delegate productionVNavBarV:self sender:self.searchTF];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

#pragma mark search textField target action
-(void)textFieldChanged:(UITextField *)textF{
    
    if (![textF.text isEqualToString:textF.placeholder]) {
        Log(@"search request");
        if (_delegate && [_delegate respondsToSelector:@selector(productionVNavBarV:sender:)]) {
            [_delegate productionVNavBarV:self sender:self.searchTF];
        }
        
    }
    
}




@end
