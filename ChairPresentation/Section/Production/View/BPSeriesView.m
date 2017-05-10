//
//  BPSeriesView.m
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSeriesView.h"

@interface BPSeriesView()<UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIImageView *contentV;

@property (nonatomic , strong) UILabel *title;

@property (nonatomic , strong) UIButton *done;

@property (nonatomic , strong) NSMutableArray *series;

@end


@implementation BPSeriesView{
    
    UIImage *_backgroud;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    _backgroud = [UIImage imageNamed:@"series_pvbg_bg_icon"];
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBColorAndAlpha(40, 50, 56, 0.2);
        
        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.title];
        
        [self.contentV addSubview:self.done];

        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
        kMaim(^{
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Series" ofType:@"plist"];
            NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
            Log(@"Series.plist = %d",(int)array.count);
            for (int i = 0 ; i < array.count ; i++) {
                
                CGFloat startY = MATCHSIZE(160);
                CGFloat startX = MATCHSIZE(30);
                
                CGFloat margin = MATCHSIZE(24);
                
                NSDictionary *dic = array[i];
                UIImage *iconH = [UIImage imageNamed:dic[@"logo_h"]];
                UIImage *icon = [UIImage imageNamed:dic[@"logo"]];
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(startX+(icon.size.width+margin)*(i%7), startY+(icon.size.height+MATCHSIZE(30))*(i/7), icon.size.width,icon.size.height)];
                button.tag = i;
                [button setImage:icon forState:UIControlStateNormal];
                [button setImage:iconH forState:UIControlStateSelected];
                button.titleLabel.text = dic[@"name"];
                [button addTarget:self action:@selector(seriesChoiceAction:) forControlEvents:UIControlEventTouchDown];
                [self.contentV addSubview:button];
                
                [self.series addObject:button];
            }
        });
        
        
    }
    return self;
}


-(void)refreshSeriesSelStatus{
    
    if (((BPKeyValue *)[BPFilters sharedFilter].dictionary[BPSERIES]).value) {
        Log(@"有已选系列");
        BPKeyValue *keylavue = [BPFilters sharedFilter].dictionary[BPSERIES];
        
        for (int i=0; i<self.series.count; i++) {
            UIButton *button = self.series[i];
            if (button.titleLabel.text == keylavue.value) {
                button.selected = YES;
                [self.series replaceObjectAtIndex:i withObject:button];
                break;
            }
        }
    }else{
        for (int i=0; i<self.series.count; i++) {
            UIButton *button = self.series[i];
            button.selected = NO;
            [self.series replaceObjectAtIndex:i withObject:button];
        }
    }
    
    
}


-(void)setStartPoint:(CGPoint)startPoint{
    _startPoint = startPoint;
    self.contentV.frame = CGRectMake(startPoint.x-MATCHSIZE(130)/2, MATCHSIZE(20) , _backgroud.size.width, _backgroud.size.height);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

#pragma mark - gesture handle  tag touch click
- (void)viewTapGesture:(UITapGestureRecognizer *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(seriesView:sender:)]) {
        [_delegate seriesView:self sender:self];
    }
    self.hidden = YES;
}


-(UIImageView *)contentV{
    if (!_contentV) {
        _contentV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,_backgroud.size.width, _backgroud.size.height)];
        _contentV.layer.cornerRadius = MATCHSIZE(10);
        _contentV.clipsToBounds = YES;
        _contentV.backgroundColor = [UIColor clearColor];
        _contentV.userInteractionEnabled = YES;
        _contentV.image = _backgroud;
    }
    return _contentV;
}

-(UILabel *)title{
    if (!_title) {
        NSString *text = @"系列选择";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        CGSize textCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(50)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textCGSize.width, MATCHSIZE(50))];
        _title.center = CGPointMake(MATCHSIZE(30)+_title.frame.size.width/2, MATCHSIZE(20)+MATCHSIZE(100)/2);
        _title.textColor = RGBColorAndAlpha(51, 51, 51, 1);
        _title.font = font;
        _title.text = text;
        
    }
    return _title;
}

-(UIButton *)done{
    if (!_done) {
        NSString *text = @"确定";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        _done = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,MATCHSIZE(100), MATCHSIZE(52))];
        _done.center = CGPointMake(self.contentV.frame.size.width-(MATCHSIZE(30)+MATCHSIZE(100)/2), MATCHSIZE(20)+MATCHSIZE(100)/2);
        _done.layer.borderWidth = MATCHSIZE(2);
        _done.layer.borderColor = [RGBColorAndAlpha(89, 177, 227, 1) CGColor];
        _done.layer.cornerRadius = MATCHSIZE(10);
        _done.clipsToBounds = YES;
        [_done setTitle:text forState:UIControlStateNormal];
        [_done setTitleColor:MainColor forState:UIControlStateNormal];
        _done.titleLabel.font = font;
        [_done addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _done;
}


-(NSMutableArray *)series{
    if (!_series) {
        _series = [NSMutableArray array];
    }
    return _series;
}

-(void)doneAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(seriesView:sender:)]) {
        [_delegate seriesView:self sender:self];
    }
    self.hidden = YES;
}

-(void)seriesChoiceAction:(UIButton *)sender{
    
    Log(@"选中系列-%@",sender.titleLabel.text);
    
    [self searchWithKey:@"serial" value:sender.titleLabel.text data:^(BOOL data) {
        if (data) {
            
            kMaim(^{
                if (_delegate && [_delegate respondsToSelector:@selector(seriesView:sender:)]) {
                    
                    [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:sender.titleLabel.text key:@"serial" tag:1] key:BPSERIES];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
                    
                    [_delegate seriesView:self sender:sender];
                }
                
                for (int i = 0 ; i < self.series.count ; i++) {
                    UIButton *button = self.series[i];
                    if (button.tag != sender.tag) {
                        button.selected = NO;
                    }
                }
                
                if (sender.selected) {
                    sender.selected = NO;
                }else{
                    sender.selected = YES;
                }
            });
            
        }
    }];
    
    
//    if (_delegate && [_delegate respondsToSelector:@selector(seriesView:sender:)]) {
//        
//        [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:sender.titleLabel.text key:@"serial" tag:1] key:BPSERIES];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
//        
//        [_delegate seriesView:self sender:sender];
//    }
//    
//    for (int i = 0 ; i < self.series.count ; i++) {
//        UIButton *button = self.series[i];
//        if (button.tag != sender.tag) {
//            button.selected = NO;
//        }
//    }
//    
//    if (sender.selected) {
//        sender.selected = NO;
//    }else{
//        sender.selected = YES;
//    }

    
}

-(void)searchWithKey:(NSString *)key value:(NSString *)value  data:(void (^)(BOOL data))data{
   
    kMaim(^{
        NSMutableArray *array =  [BPFilters sharedFilter].getfiltersList;
        NSMutableArray *searchFilters = [NSMutableArray array];
        if (array.count == 0) {
            [searchFilters addObject:[BPKeyValue objectWithValue:value key:@"serial" tag:1]];
        }else{
            for (BPKeyValue *keyvalue in array) {
                if ([keyvalue.key isEqualToString:@"serial"]) {
                    [searchFilters addObject:[BPKeyValue objectWithValue:value key:@"serial" tag:1]];
                }else{
                    [searchFilters addObject:keyvalue];
                }
            }
        }
        
        NSArray *searchs = [BPSearchChairDB searchChairsWithFieldItems:searchFilters];
        Log(@"%@",searchs);
        if (searchs.count == 0) {
            data(NO);
        }else{
            data(YES);
        }
    
    });
    
}



@end
