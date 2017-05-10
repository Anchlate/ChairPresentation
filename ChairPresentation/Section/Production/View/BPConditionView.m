//
//  BPFiltersView.m
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPConditionView.h"


#define deleteIco [UIImage imageNamed:@"filterDelete"]

@interface BPConditionView()

@property (nonatomic , strong) UIImageView *delete;


@property (nonatomic , strong) UILabel *specialL;


@end


@implementation BPConditionView{

    NSString *_text;
    
}

-(instancetype) initWithKV:(BPKeyValue *)keyValue{
    
    _keyValue = keyValue;
    
    if (self = [super initWithFrame:CGRectMake(0, 0, 0, 0)]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.borderWidth = MATCHSIZE(1);
        self.layer.borderColor = [RGBColorAndAlpha(224, 224, 224, 1) CGColor];
        
        self.layer.cornerRadius = MATCHSIZE(5);
        self.clipsToBounds = YES;
        
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BPField" ofType:@"plist"];
        NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        _text = _keyValue.value;
        
        if (keyValue.tag == 1) {
            
        }else if (keyValue.tag == 2){
            
        }else if (keyValue.tag == 3){
            _text = [NSString stringWithFormat:@"%@%@",mutDic[keyValue.key],keyValue.value];
        }else if (keyValue.tag == 4){
            Log(@"..text:%@", _text);
            Log(@"..key:%@", keyValue.key);
            Log(@"..value:%@",keyValue.value);
            Log(@"...mutDic[keyValue.key]:%@",mutDic[keyValue.key]);
            _text = [NSString stringWithFormat:@"%@%@",mutDic[keyValue.key],keyValue.value];
            Log(@".._text:%@",_text);

        }
        
        [self addSubview:self.title];
        
        [self addSubview:self.delete];
        
        CGSize size = [BPConditionView viewSize:_text];
        _vSize = size;
        self.frame = CGRectMake(0, 0, size.width, MATCHSIZE(52));
        
        if (keyValue.tag == 1) {
            if ([_text hasSuffix:@"+"]) {
                NSArray *array = [_text componentsSeparatedByString:@"+"];
                UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(26)];
                CGSize textCGSize = [array[0] boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(26)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
                self.specialL.center = CGPointMake(self.title.frame.origin.x+textCGSize.width+self.specialL.frame.size.width/2, self.title.frame.origin.y+2);
                [self addSubview:self.specialL];
            }
        }
        
//        self.userInteractionEnabled = YES;
//        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
    
}

+(CGSize)viewSize:(NSString *)text{
    
    CGSize vSize = CGSizeZero;
    CGSize textSize = [[NSString stringWithFormat:@"%@",text] boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(26)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MATCHSIZE(26)]} context:nil].size;
    vSize = CGSizeMake(textSize.width+MATCHSIZE(18)+MATCHSIZE(30)+deleteIco.size.width+MATCHSIZE(18), MATCHSIZE(52));
    return vSize;
}


-(UILabel *)title{
    if (!_title) {
        
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(26)];
        CGSize textCGSize = [_text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(26)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(18), MATCHSIZE(24), textCGSize.width, textCGSize.height)];
        _title.center = CGPointMake(MATCHSIZE(18)+textCGSize.width/2, MATCHSIZE(52)/2);
        _title.font = [UIFont systemFontOfSize:MATCHSIZE(26)];
        _title.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        
        if (_keyValue.tag == 1) {
            NSString *style;
            if ([_text hasSuffix:@"+"]) {
                NSArray *array = [_text componentsSeparatedByString:@"+"];
                style = array[0];
            }else{
                style = _text;
            }
            _title.text = style;
            
        }else{
            _title.text = _text;
        }
        
    }
    return _title;
}

-(UILabel *)specialL{
    if (!_specialL) {
        NSString *text = @"+";
        UIFont *titleFont = [UIFont systemFontOfSize:MATCHSIZE(20)];
        CGSize wordCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(20)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
        _specialL = [[UILabel alloc] initWithFrame:CGRectMake(0,  MATCHSIZE(14),  wordCGSize.width, wordCGSize.height)];
        _specialL.font = titleFont;
        _specialL.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _specialL.text = text;
    }
    return _specialL;
}


-(UIImageView *)delete{
    if (!_delete) {
        _delete = [[UIImageView alloc] initWithFrame:CGRectMake(self.title.frame.origin.x+self.title.frame.size.width+MATCHSIZE(30), 0, deleteIco.size.width, deleteIco.size.height)];
        _delete.center = CGPointMake(self.title.frame.origin.x+self.title.frame.size.width+MATCHSIZE(30)+deleteIco.size.width/2, MATCHSIZE(52)/2);
        _delete.image = deleteIco;
    }
    return _delete;
}




#pragma mark - gesture handle  tag touch click
- (void)viewTapped:(UITapGestureRecognizer *)sender{
    Log(@"移除");
//    if (_delete && [_delete respondsToSelector:@selector(filtersView:sender:)]) {
//        [_delegate  filtersView:self sender:self];
//    }
}


@end
