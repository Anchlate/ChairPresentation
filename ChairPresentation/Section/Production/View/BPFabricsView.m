//
//  BPFabricsView.m
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFabricsView.h"
#import "BPFabricAndFunctionTableView.h"
#import "BPFabricAndFunction.h"

@interface BPFabricsView()<UIGestureRecognizerDelegate, BPFabricAndFunctionTableViewDelegate>

@property (nonatomic, strong) UIImageView *contentV;
@property (nonatomic, strong) BPFabricAndFunctionTableView *fabricAndFunctionView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end


@implementation BPFabricsView{
    
    UIImage *_backgroud;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    _backgroud = [UIImage imageNamed:@"fabrics_pvbg_bg_icon"];
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBColorAndAlpha(40, 50, 56, 0.2);
        
        [self addSubview:self.contentV];
        [self.contentV addSubview:self.fabricAndFunctionView];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF(weakSelf);
    
    [self.fabricAndFunctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentV).offset(20);
        make.leading.trailing.bottom.equalTo(weakSelf.contentV);
        
    }];
    
    
}

-(void)setStartPoint:(CGPoint)startPoint{
    
    _startPoint = startPoint;
    
     self.contentV.frame = CGRectMake(startPoint.x-MATCHSIZE(375), MATCHSIZE(20),_backgroud.size.width, _backgroud.size.height);
    
}

-(void)refreshFabricsStatus{
    
    if (((NSMutableArray *)[BPFilters sharedFilter].dictionary[BPFABRICS]).count != 0) {
        // 从缓存中获取并设置已选项
        for (int i=0; i < self.datasource.count; i++) {
            BPFabricAndFunction *fabricAndFunction = self.datasource[i];
            for (int j=0; j<fabricAndFunction.fabricItems.count; j++) {
                BPFabricAndFunctionChild *fabricAndFunctionChild = fabricAndFunction.fabricItems[j];
                
                NSMutableArray *selApplications = [BPFilters sharedFilter].dictionary[BPFABRICS];
                for (int j=0 ; j < selApplications.count ; j++) {
                    BPKeyValue *keylavue = selApplications[j];
                    Log(@"cache:%@",keylavue.value);
                    if ([keylavue.value hasSuffix:fabricAndFunctionChild.fabricItem]) {
                       fabricAndFunctionChild.isSelected = YES;
                        break;
                    }else{
                        fabricAndFunctionChild.isSelected = NO;
                    }
                }
            }
        }
    }else{
        //清除所有已选项
        Log(@"清除所有面料已选项");
        for (int i=0; i < self.datasource.count; i++) {
            BPFabricAndFunction *fabricAndFunction = self.datasource[i];
            for (int j=0; j<fabricAndFunction.fabricItems.count; j++) {
                BPFabricAndFunctionChild *fabricAndFunctionChild = fabricAndFunction.fabricItems[j];
                fabricAndFunctionChild.isSelected = NO;
            }
        }
    }
    
    [self.fabricAndFunctionView.tableView reloadData];
    
}




-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

/**
 *  <#Description#>
 *
 *  @param selections <#selections description#>
 */
- (void)selections:(NSArray *)selections
{
    Log(@"......selection:%@", selections);
    if (_delegate && [_delegate respondsToSelector:@selector(fabricsView:sender:)]) {
        
        [_delegate fabricsView:self sender:self];
    }
    self.hidden = YES;
    
}

- (void)selectedFabricAndFunctionItemKey:(NSString *)key value:(NSString *)value
{
    Log(@"......:%@ = %@", key, value);
    
    [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:value key:key tag:3] key:BPFABRICS];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
    
}

- (void)canceledFabricAndFunctionItemKey:(NSString *)key value:(NSString *)value
{
    Log(@"......:%@ = %@", key, value);
    
    [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:value key:key tag:3] key:BPFABRICS];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
    
}


#pragma mark - gesture handle  tag touch click
- (void)viewTapGesture:(UITapGestureRecognizer *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(fabricsView:sender:)]) {
        [_delegate fabricsView:self sender:self];
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
        //        _contentV.hidden = YES;
    }
    return _contentV;
}

- (BPFabricAndFunctionTableView *)fabricAndFunctionView
{
    
    if (!_fabricAndFunctionView) {
        
        NSString *title = @"面料选择";
        BPFabricAndFunction *pillowFabric = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"头枕面料" nameEN:@"fabric_pillow"];
        BPFabricAndFunction *backcushionFabric = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"背垫面料" nameEN:@"fabric_backcushion"];
        BPFabricAndFunction *cushionFabric = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"座垫面料" nameEN:@"fabric_cushion"];
        
        self.datasource = [NSMutableArray arrayWithArray:@[pillowFabric, backcushionFabric, cushionFabric]];
        
        _fabricAndFunctionView = [[BPFabricAndFunctionTableView alloc]initWithTitle:title datasource:self.datasource];
        _fabricAndFunctionView.delegate = self;
    }
    return _fabricAndFunctionView;
}

- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

@end