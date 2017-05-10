//
//  BPProductionCVCellHeaderV.m
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionCVCellHeaderV.h"

#define maxWidth MATCHSIZE(1354)


@interface BPProductionCVCellHeaderV()

@property (nonatomic , strong) UIView *segLine;




@end

@implementation BPProductionCVCellHeaderV{
    
    CGFloat marginT;
    CGFloat marginL;
    CGFloat marginB;
    CGFloat marginR;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    marginT = MATCHSIZE(24);
    marginL = MATCHSIZE(40);
    marginB = MATCHSIZE(40);
    marginR = MATCHSIZE(24);
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBColorAndAlpha(247, 247, 247, 1);
        
        [self addSubview:self.deleteAll];
        
        [self addSubview:self.segLine];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filtersNotificationAction:) name:BPFiltersNoti object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BPFiltersNoti object:nil];
}


- (void)filtersViewTapped:(UITapGestureRecognizer *)sender{
    Log(@"filtersViewTapped");
    
    BPKeyValue *keyvalue = ((BPConditionView *)sender.view).keyValue;
    
    Log(@"tag=%d",(int)keyvalue.tag);
    
    Log(@"key:%@ , value:%@",keyvalue.key , keyvalue.value);
    
    switch (keyvalue.tag) {
        case 1:
        {
            [[BPFilters sharedFilter] addReplaceFilters:keyvalue key:BPSERIES];
        }
            break;
        case 2:
        {
            [[BPFilters sharedFilter] addReplaceFilters:keyvalue key:BPAPPLICATION];
        }
            break;
        case 3:
        {
            [[BPFilters sharedFilter] addReplaceFilters:keyvalue key:BPFABRICS];
        }
            break;
            
        case 4:
        {
            [[BPFilters sharedFilter] addReplaceFilters:keyvalue key:BPFUNCTION];
        }
            break;
        case 5:
        {
            [[BPFilters sharedFilter] addReplaceFilters:keyvalue key:BPSEARCH];
        }
            break;
        case 6:
        {
            [[BPFilters sharedFilter] deleteFilters:keyvalue];
        }
            break;
    }
    [self refreshFiltersView];
    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];

}


-(UIView *)segLine{
    if (!_segLine) {
        _segLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width-self.deleteAll.frame.origin.x)-marginL, marginT, 1, MATCHSIZE(44))];
        _segLine.center = CGPointMake(self.frame.size.width-(self.frame.size.width-self.deleteAll.frame.origin.x)-marginL, MATCHSIZE(100)/2);
        _segLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _segLine;
}


-(UIButton *)deleteAll{
    if (!_deleteAll) {
        NSString *text = @"全部清除";
        UIFont *font = [UIFont systemFontOfSize:MATCHSIZE(28)];
        CGSize textCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(44)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _deleteAll = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textCGSize.width, MATCHSIZE(44))];
        _deleteAll.center = CGPointMake(self.frame.size.width-MATCHSIZE(40)-(textCGSize.width)/2, MATCHSIZE(100)/2);
        _deleteAll.layer.cornerRadius = MATCHSIZE(8);
        _deleteAll.clipsToBounds = YES;
        _deleteAll.titleLabel.font = font;
        [_deleteAll setTitle:text forState:UIControlStateNormal];
        [_deleteAll setTitleColor:RGBColorAndAlpha(89, 177, 227, 1) forState:UIControlStateNormal];
        _deleteAll.layer.borderWidth = 1;
        _deleteAll.layer.borderColor = [RGBColorAndAlpha(89, 177, 227, 1) CGColor] ;
        [_deleteAll addTarget:self action:@selector(deleteAllAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _deleteAll;
}

-(void)deleteAllAction:(UIButton *)sender{
    
    [[BPFilters sharedFilter] clear];
    
    [self refreshFiltersView];
    
    if (_delegate && [_delegate respondsToSelector:@selector(productionCVCellHeaderV:sender:)]) {
        [_delegate productionCVCellHeaderV:self sender:sender];
    }
    
}

-(NSMutableArray *)filtersViews{
    if (!_filtersViews) {
        _filtersViews =[NSMutableArray array];
    }
    return _filtersViews;
}


-(void)filtersNotificationAction:(NSNotification *)sender{
    [self refreshFiltersView];
}

-(void)refreshFiltersView{
    for (BPConditionView *filtersView in self.filtersViews) {
        [filtersView removeFromSuperview];
    }
    _filtersViews = nil;
    
    NSArray *array = [BPFilters sharedFilter].getfiltersList;
    if (array.count > 0) {
        self.hidden = NO;
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.frame.size.width,
                                MATCHSIZE(100));
        if (_delegate && [_delegate respondsToSelector:@selector(productionCVCellHeaderV:atc:)]) {
            [_delegate productionCVCellHeaderV:self atc:1];
        }
    }else{
        self.hidden = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(productionCVCellHeaderV:atc:)]) {
            [_delegate productionCVCellHeaderV:self atc:2];
        }
    }
    
    for (int i = 0 ; i < array.count ; i ++ ) {
        BPKeyValue *keyValueObject = array[i];
        
        Log(@"已选条件：%@-%@",keyValueObject.key,keyValueObject.value);
        
        if (self.filtersViews.count == 0) {
            BPConditionView *currFiltersView = [[BPConditionView alloc] initWithKV:keyValueObject];
            currFiltersView.frame = CGRectMake(marginL, marginT, currFiltersView.frame.size.width,currFiltersView.frame.size.height);
            currFiltersView.tag = i;
            UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filtersViewTapped:)];
            [currFiltersView addGestureRecognizer:tapGesture];
            
            [self addSubview:currFiltersView];
            [self.filtersViews addObject:currFiltersView];
        }else{
            BPConditionView *arrLastFiltersView;
            BPConditionView *currFiltersView;
            
            arrLastFiltersView = [self.filtersViews lastObject];
            currFiltersView = [[BPConditionView alloc] initWithKV:keyValueObject];
            
            UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filtersViewTapped:)];
            [currFiltersView addGestureRecognizer:tapGesture];
            
            if (arrLastFiltersView.frame.origin.x + arrLastFiltersView.frame.size.width + MATCHSIZE(40) + currFiltersView.frame.origin.x + currFiltersView.frame.size.width > maxWidth) {
                
                currFiltersView.frame = CGRectMake(MATCHSIZE(40), arrLastFiltersView.frame.origin.y+arrLastFiltersView.frame.size.height+MATCHSIZE(24), currFiltersView.frame.size.width,currFiltersView.frame.size.height);
                currFiltersView.tag = i;

                [self.filtersViews addObject:currFiltersView];
                self.frame = CGRectMake(self.frame.origin.x,
                                        self.frame.origin.y,
                                        self.frame.size.width,
                                        currFiltersView.frame.origin.y+currFiltersView.frame.size.height+MATCHSIZE(24));
                if (_delegate && [_delegate respondsToSelector:@selector(productionCVCellHeaderV:atc:)]) {
                    [_delegate productionCVCellHeaderV:self atc:1];
                }
                
            }else{
                currFiltersView.frame = CGRectMake(arrLastFiltersView.frame.origin.x+arrLastFiltersView.frame.size.width+MATCHSIZE(40), arrLastFiltersView.frame.origin.y, currFiltersView.frame.size.width,currFiltersView.frame.size.height);
                currFiltersView.tag = i;
            }
            [self addSubview:currFiltersView];
            [self.filtersViews addObject:currFiltersView];
            
        }
    }

}


@end