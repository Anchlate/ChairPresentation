//
//  BPHomeView.m
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPHomeView.h"

@interface BPHomeView()

@property (nonatomic , strong) UIImageView *logoIV;

@property (nonatomic , strong) UIView *contentV;

@property (nonatomic , strong) UIView *logoView;

@property (nonatomic , strong) UIView *classView;

@property (nonatomic , strong) UIView *adView;

@property (nonatomic , strong) NSMutableArray *classBtns;

@end

@implementation BPHomeView{
    
    CGFloat marginT;
    CGFloat marginL;
    CGFloat marginB;
    CGFloat marginR;
    
}


-(instancetype) initWithFrame:(CGRect)frame{
    
    marginB = 10;
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.headerIV];
        
        [self.contentV addSubview:self.logoView];
        
        [self.logoView addSubview:self.logoIV];
        
        [self.logoView addSubview:self.allProduct];
        
        [self.contentV addSubview:self.classView];
        
        [self.contentV addSubview:self.adView];
               
    }
    return self;
}


-(void)allProductAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(homeView:sender:)]) {
        [_delegate homeView:self sender:sender];
    }
}

- (void)imgTxtButtonGesture:(UITapGestureRecognizer *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(homeView:sender:)]) {
        [_delegate homeView:self sender:self.classBtns[sender.view.tag]];
    }
}

-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentV.backgroundColor = ViewBackgroundColor;
    }
    return _contentV;
}

-(UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentV.frame.size.width, MATCHSIZE(700))];
        _headerIV.image = [UIImage imageNamed:@"home_header_icon"];
    }
    return _headerIV;
}

-(UIView *)logoView{
    if (!_logoView) {
        _logoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerIV.frame.origin.y+self.headerIV.frame.size.height, self.contentV.frame.size.width, MATCHSIZE(180))];
    }
    return _logoView;
}

-(UIImageView *)logoIV{
    if (!_logoIV) {
        UIImage *logo = [UIImage imageNamed:@"logo_home"];
        _logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, logo.size.width, logo.size.height)];
        _logoIV.center = CGPointMake(logo.size.width/2, self.logoView.frame.size.height/2);
        _logoIV.image = logo;
    }
    return _logoIV;
}

-(UIButton *)allProduct{
    if (!_allProduct) {
        UIImage *icon = [UIImage imageNamed:@"all_production_ic"];
        NSString *txt = @"全部产品";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(32)];
        _allProduct = [[UIButton alloc] initWithFrame:CGRectMake(self.logoView.frame.size.width-icon.size.width, self.logoView.frame.size.height-icon.size.height, icon.size.width, icon.size.height)];
//        _allProduct.center = CGPointMake(self.logoView.frame.size.width-icon.size.width/2, self.logoView.frame.size.height/2);
        _allProduct.contentEdgeInsets = UIEdgeInsetsMake(0, MATCHSIZE(100),0,0);
        [_allProduct setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_allProduct setTitle:txt forState:UIControlStateNormal];
        _allProduct.titleLabel.font = font;
        [_allProduct setBackgroundImage:icon forState:UIControlStateNormal];
        _allProduct.tag = 1;
        [_allProduct addTarget:self action:@selector(allProductAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _allProduct;
}

-(UIView *)classView{
    if (!_classView) {
        _classView = [[UIView alloc] initWithFrame:CGRectMake(0, self.logoView.frame.origin.y+self.logoView.frame.size.height, self.contentV.frame.size.width, MATCHSIZE(250))];
        _classView.backgroundColor = MainColor;
        
        CGFloat margin = _classView.frame.size.width*0.19;
        
        for (int i=0 ; i < self.classArray.count ; i++) {
            BPITBItem *item = self.classArray[i];
            BPImgTxtButton *imgtxtBtn = [[BPImgTxtButton alloc] initWithFrame:CGRectMake(0, 0, MATCHSIZE(136) ,MATCHSIZE(136))];
            imgtxtBtn.center = CGPointMake(margin + (margin+_classView.frame.size.width*0.044/2)*i , _classView.frame.size.height/2);
            imgtxtBtn.item = item;
            imgtxtBtn.tag = i;
            imgtxtBtn.userInteractionEnabled=YES;
            
            [_classView addSubview:imgtxtBtn];
            
            UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTxtButtonGesture:)];
            [imgtxtBtn addGestureRecognizer:tapGesture];
            
            [self.classBtns addObject:imgtxtBtn];
        }
        
    }
    return _classView;
}

-(UIView *)adView{
    if (!_adView) {
        _adView = [[UIView alloc] initWithFrame:CGRectMake(0,self.classView.frame.origin.y+self.classView.frame.size.height, self.classView.frame.size.width, self.contentV.frame.size.height-(self.classView.frame.origin.y+self.classView.frame.size.height))];
        _adView.backgroundColor = [UIColor whiteColor];
        
        CGFloat admarginL = MATCHSIZE(40);
        CGFloat admarginR = MATCHSIZE(40);
        CGFloat admarginB = MATCHSIZE(30);
        CGFloat admarginT = MATCHSIZE(30);
        
        CGFloat admargin = MATCHSIZE(12);
        
        for (int i=0 ; i < self.adArray.count ; i++) {
            UIImageView *adIV = [[UIImageView alloc] initWithFrame:CGRectMake(admarginL+(((_adView.frame.size.width-(admarginL+admarginR+admargin*3))/self.adArray.count + admargin))*i, admarginT, (_adView.frame.size.width-(admarginL+admarginR+admargin*3))/self.adArray.count, _adView.frame.size.height-(admarginT+admarginB))];
            adIV.layer.cornerRadius = MATCHSIZE(16);
            adIV.clipsToBounds = YES;
            adIV.image = [UIImage imageNamed:self.adArray[i]];
            [_adView addSubview:adIV];
        }
        
    }
    return _adView;
}


-(NSArray *)classArray{
    if (!_classArray) {
        _classArray = @[[[BPITBItem alloc] initWithTitle:@"系列" image:[UIImage imageNamed:@"series_sel"] tag:2],
                        [[BPITBItem alloc] initWithTitle:@"用途" image:[UIImage imageNamed:@"bulb_sel"] tag:3],
                        [[BPITBItem alloc] initWithTitle:@"价格" image:[UIImage imageNamed:@"price_sel"] tag:4],
                        [[BPITBItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"search_sel"] tag:5]
                        ];
    }
    return _classArray;
}

-(NSArray *)adArray{
    if (!_adArray) {
        _adArray = @[@"ad_icon1",@"ad_icon2",@"ad_icon3",@"ad_icon4"];
    }
    return _adArray;
}

-(NSMutableArray *)classBtns{
    if (!_classBtns) {
        _classBtns = [NSMutableArray array];
    }
    return _classBtns;
}


@end
