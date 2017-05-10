//
//  BPProductionCView.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionCView.h"

#define BPProductCid @"BPProductCid"

@interface  BPProductionCView()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>



@end


@implementation BPProductionCView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        
        kMaim((^{
            _dataSource = nil;
            self.dataSource = [NSMutableArray arrayWithArray:[BPSearchChairDB searchAllChairs]];
            [self.collectionView reloadData];
        }));
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conditionSerachNotificationAction:) name:BPConditionSerachNoti object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterSerachNotificationAction:) name:BPEnterSerachNoti object:nil];
        
        
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BPConditionSerachNoti object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BPConditionSerachNoti object:nil];
}

#pragma mark -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BPProductionCVCell * cell = (BPProductionCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BPProductCid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[BPProductionCVCell alloc] initWithFrame:CGRectMake(0, 0, MATCHSIZE(539.0), MATCHSIZE(719))];
    }
    
    cell.tag = indexPath.row;
    cell.production = self.dataSource[indexPath.row];
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MATCHSIZE(539.0), MATCHSIZE(719));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return MATCHSIZE(1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return MATCHSIZE(1);
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(productionCView:sender:chair:)]) {
        [_delegate productionCView:self sender:[collectionView cellForItemAtIndexPath:indexPath] chair:self.dataSource[indexPath.row]];
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BPCollectionViewFlowLayout *)cvFlayout{
    if (!_cvFlayout) {
        _cvFlayout  = [[BPCollectionViewFlowLayout alloc]init];
        _cvFlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _cvFlayout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.cvFlayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerClass:[BPProductionCVCell class] forCellWithReuseIdentifier:BPProductCid];
        _collectionView.backgroundColor = RGBColorAndAlpha(233, 233, 233, 1);
    }
    return _collectionView;
}

//收到搜索通知 的处理
-(void)conditionSerachNotificationAction:(NSNotification *)sneder{
    
    
    kMaim((^{
        
        NSMutableArray *array =  [BPFilters sharedFilter].getfiltersList;
        
        if (array.count == 0) {
            [self searchAllData];
        }else{
          
            NSString *sql = [BPSearchChairDB sqlStringWithFieldItems:array];
            
            Log(@"..sql:%@", sql);
            
            NSArray *data = [BPSearchChairDB searchChairsWithFieldItems:array];
            Log(@"..count:%d", (int)data.count);
            //        Log(@"..data:%@", data);
            
            if (data.count != 0) {
                [self.dataSource removeAllObjects];
                [self.dataSource addObjectsFromArray:data];
                [self.collectionView reloadData];
                self.collectionView.contentOffset = CGPointZero ;
            }
        }
        
    }));
    
}

-(void)enterSerachNotificationAction:(NSNotification *)sender{
    
    kMaim((^{
        BPKeyValue *object = [BPFilters sharedFilter].dictionary[BPSEARCH];
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where nameCH like '%%%@%%'", kChairTable, object.value];
        
        NSArray *results = [BPSearchChairDB searchChairsFromChairDB:kDataBase sql:sql];
        
        Log(@"..sql:%@", sql);
        Log(@"..results:%@", results);
        
        if (results.count != 0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:results];
            [self.collectionView reloadData];
            self.collectionView.contentOffset = CGPointZero ;
        }

    }));
    
}

-(void)searchAllData{
    kMaim((^{
        [self.dataSource removeAllObjects];
        self.dataSource = [NSMutableArray arrayWithArray:[BPSearchChairDB searchAllChairs]];
//        Log(@"%@",self.dataSource);
        [self.collectionView reloadData];
        self.collectionView.contentOffset = CGPointZero ;
    }));
}


-(void)hotSequence{
    self.dataSource = [NSMutableArray arrayWithArray:[NSArray sortChairsWithHot:self.dataSource accending:YES]];
    [self.collectionView reloadData];
    self.collectionView.contentOffset = CGPointZero ;
}

-(void)highToLowSequence{
     self.dataSource = [NSMutableArray arrayWithArray:[NSArray sortChairsWithPrice:self.dataSource Accending:NO]];
    [self.collectionView reloadData];
    self.collectionView.contentOffset = CGPointZero ;
}

-(void)lowToHighSequence{
    self.dataSource = [NSMutableArray arrayWithArray:[NSArray sortChairsWithPrice:self.dataSource Accending:YES]];
    [self.collectionView reloadData];
    self.collectionView.contentOffset = CGPointZero ;
}


-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
}



@end