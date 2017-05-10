//
//  BPFunctionView.m
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPFunctionView.h"
#import "BPFabricAndFunctionTableView.h"
#import "BPFabricAndFunction.h"


@interface BPFunctionView()<UIGestureRecognizerDelegate, BPFabricAndFunctionTableViewDelegate>

@property (nonatomic , strong) UIImageView *contentV;
@property (nonatomic, strong) BPFabricAndFunctionTableView *fabricAndFunctionView;
@property (nonatomic, copy) NSMutableArray *datasource;

@end


@implementation BPFunctionView{
    UIImage *_backgroud;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    _backgroud = [UIImage imageNamed:@"function_pvbg_bg_icon"];
    
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

-(void)refreshFunctionStatus{
    
    if (((NSMutableArray *)[BPFilters sharedFilter].dictionary[BPFUNCTION]).count != 0) {
        // 从缓存中获取并设置已选项
        for (int i=0; i < self.datasource.count; i++) {
            BPFabricAndFunction *fabricAndFunction = self.datasource[i];
            for (int j=0; j<fabricAndFunction.fabricItems.count; j++) {
                BPFabricAndFunctionChild *fabricAndFunctionChild = fabricAndFunction.fabricItems[j];
                
                NSMutableArray *selApplications = [BPFilters sharedFilter].dictionary[BPFUNCTION];
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

/*
// 选择一个选项
- (void)selectedFabricAndFunctionItem:(NSDictionary *)item
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ is '%@'", kChairTable, [item.allKeys firstObject], [item.allValues firstObject]];
    
    NSArray *chairs = [BPSearchChairDB searchChairsFromChairDB:kDataBase sql:sql];
    
    if (chairs.count > 0) {
        [self.datasource addObjectsFromArray:chairs];
    }
    
}

// 取消一个选项
- (void)canceledFabricAndFunctionItem:(NSDictionary *)item
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ is '%@'", kChairTable, [item.allKeys firstObject], [item.allValues firstObject]];
    
    NSArray *chairs = [BPSearchChairDB searchChairsFromChairDB:kDataBase sql:sql];
    
    NSMutableArray *deleteChairs = [NSMutableArray array];
    
    for (BPChair *chair in chairs) {
        
        for (BPChair *dataChair in self.datasource) {
            if (chair.id == dataChair.id) {
                [deleteChairs addObject:dataChair];
            }
        }
    }
    
    [self.datasource removeObjectsInArray:deleteChairs];
    
}
*/

- (void)selections:(NSArray *)selections
{
    Log(@"......selection:%@", selections);
    
    if (_delegate && [_delegate respondsToSelector:@selector(functionView:sender:)]) {
        
        [_delegate functionView:self sender:self];
    }
    self.hidden = YES;

    
}

- (void)selectedFabricAndFunctionItemKey:(NSString *)key value:(NSString *)value
{
    Log(@"......:%@ = %@", key, value);
    
    [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:value key:key tag:4] key:BPFUNCTION];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
}

- (void)canceledFabricAndFunctionItemKey:(NSString *)key value:(NSString *)value
{
    Log(@"......:%@ = %@", key, value);
    
    [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:value key:key tag:4] key:BPFUNCTION];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
    
}



#pragma mark - gesture handle tag touch click
- (void)viewTapGesture:(UITapGestureRecognizer *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(functionView:sender:)]) {
        [_delegate functionView:self sender:self];
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
        
        NSString *title = @"功能选择";
        BPFabricAndFunction *backHeightFabric = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"椅背" nameEN:@"chairBack_height"];
        BPFabricAndFunction *backWaistFabric = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"腰枕" nameEN:@"chairBack_waist"];
        
        BPFabricAndFunction *pillosFunctionFabri = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"头枕" nameEN:@"pillowFuction"];
        
//        BPFabricAndFunction *waistAdjustFabric = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"腰部自动调节" nameEN:@"chairBack_waistAdjust"];
        
        /**********/
        BPFabricAndFunction *Fabric1 = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"座垫" nameEN:@"cushion_height"];
        
//        BPFabricAndFunction *Fabric2 = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"座深可调" nameEN:@"cushion_deep"];
//        
//        BPFabricAndFunction *Fabric3 = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"座角度可调" nameEN:@"cushion_angle"];
        
        BPFabricAndFunction *Fabric2 = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"倾仰段数" nameEN:@"section"];
        
        BPFabricAndFunction *Fabric3 = [BPFabricAndFunction fabricAndFunctionWithNameCH:@"扶手" nameEN:@"handrail_function"];
        
        
        self.datasource = [NSMutableArray arrayWithArray:@[pillosFunctionFabri, backHeightFabric, backWaistFabric, Fabric1, Fabric2, Fabric3]];
        
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
