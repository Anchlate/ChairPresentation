//
//  BPProductionCVCell.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionCVCell.h"


@interface BPProductionCVCell()

@property (nonatomic , strong) UILabel *punit;

@property (nonatomic , strong) UILabel *specialL;

@end

@implementation BPProductionCVCell{

    NSMutableDictionary *_colorDict;
    
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SeriesColor" ofType:@"plist"];
   _colorDict = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];

    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.face];
        
        [self addSubview:self.price];
        
        [self addSubview:self.style];
        
        [self.style addSubview:self.specialL];
        
        [self addSubview:self.punit];
        
    }
    return self;
}

-(UIImageView *)face{
    if (!_face) {
        _face = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, MATCHSIZE(470))];
        _face.center = CGPointMake(self.frame.size.width/2,MATCHSIZE(409));
        _face.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _face;
}

-(UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(40), MATCHSIZE(74), 0, MATCHSIZE(48))];
        _price.font = [UIFont systemFontOfSize:MATCHSIZE(48)];
    }
    return _price;
}

-(UILabel *)punit{
    if (!_punit) {
        NSString *text = @"￥";
        UIFont *titleFont = [UIFont systemFontOfSize:MATCHSIZE(28)];
        CGSize wordCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(28)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
        
        _punit = [[UILabel alloc] initWithFrame:CGRectMake(self.price.frame.origin.x+self.price.frame.size.width+MATCHSIZE(9),
                                                           MATCHSIZE(74),
                                                           wordCGSize.width,
                                                           wordCGSize.height)];
        _punit.font = titleFont;
        _punit.text = text;
    }
    return _punit;
}

-(BPUILabel *)style{
    if (!_style) {
        UIFont *titleFont = [UIFont systemFontOfSize:MATCHSIZE(26)];
        _style = [[BPUILabel alloc] initWithFrame:CGRectMake(0, MATCHSIZE(74),0, MATCHSIZE(44)) andInsets:UIEdgeInsetsMake(MATCHSIZE(10), MATCHSIZE(10), MATCHSIZE(10), MATCHSIZE(10))];
        _style.layer.cornerRadius = MATCHSIZE(5);
        _style.clipsToBounds = YES;
        _style.textColor = [UIColor whiteColor];
        _style.font = titleFont;
    }
    return _style;
}

-(UILabel *)specialL{
    if (!_specialL) {
        NSString *text = @"+";
        UIFont *titleFont = [UIFont systemFontOfSize:MATCHSIZE(22)];
        CGSize wordCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(22)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
        _specialL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  wordCGSize.width, wordCGSize.height)];
        _specialL.font = titleFont;
        _specialL.textColor = [UIColor whiteColor];
        _specialL.text = text;
    }
    return _specialL;
}


-(void)setProduction:(BPChair *)production{
    
    CGSize priceCGSize;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:Role] isEqualToString:@"1"] ) {
         priceCGSize= [[NSString stringWithFormat:@"%.0f",production.discount35_price] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.price.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.price.font} context:nil].size;
        self.price.text = [NSString stringWithFormat:@"%.0f",production.discount35_price];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:Role] isEqualToString:@"2"] ) {
        priceCGSize= [[NSString stringWithFormat:@"%.0f",production.discount3_price] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.price.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.price.font} context:nil].size;
        self.price.text = [NSString stringWithFormat:@"%.0f",production.discount3_price];
    }
    
    self.price.frame = CGRectMake(self.price.frame.origin.x, self.price.frame.origin.y, priceCGSize.width, priceCGSize.height);
    
    
    self.punit.frame = CGRectMake(self.price.frame.origin.x+self.price.frame.size.width,
                                  self.punit.frame.origin.y,
                                  self.punit.frame.size.width,
                                  self.punit.frame.size.height);
    
    
    CGSize styleCGSize;
    NSString *style;
     if ([production.serial hasSuffix:@"+"]) {
         NSArray *array = [production.serial componentsSeparatedByString:@"+"];
         style = array[0];
     }else{
         style = production.serial;
     }
    styleCGSize = [style boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.style.font} context:nil].size;
    self.style.text = style;
    if ([production.serial hasSuffix:@"+"]) {
        self.specialL.hidden = NO;
        self.specialL.frame = CGRectMake(MATCHSIZE(10)+styleCGSize.width, self.specialL.frame.origin.y, self.specialL.frame.size.width, self.specialL.frame.size.height);
        self.style.frame = CGRectMake(self.frame.size.width-(styleCGSize.width+MATCHSIZE(20)+self.specialL.frame.size.width)-MATCHSIZE(40), self.style.frame.origin.y, styleCGSize.width+MATCHSIZE(20)+self.specialL.frame.size.width, self.style.frame.size.height);
    }else{
        self.specialL.hidden = YES;
        self.style.frame = CGRectMake(self.frame.size.width-(styleCGSize.width+MATCHSIZE(20))-MATCHSIZE(40), self.style.frame.origin.y, styleCGSize.width+MATCHSIZE(20), self.style.frame.size.height);
    }
    
    if (_colorDict[production.serial]) {
        self.style.backgroundColor = [NSString colorWithHexString:_colorDict[production.serial]];
    }
    
    NSString *productPath = [NSString documentDirectoryPathWithFileName:@"productions"];
    NSString *serialPath = [productPath stringByAppendingPathComponent:production.serial];
    NSString *imagePath = [serialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_production.png", production.nameen]];
    
    Log(@"..........Png:%@", imagePath);
    
    kMaim(^{
        self.face.image = [UIImage imageWithContentsOfFile:imagePath];
    });


}

@end
