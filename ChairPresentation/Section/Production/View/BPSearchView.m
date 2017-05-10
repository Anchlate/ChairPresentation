//
//  BPSearchView.m
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSearchView.h"


@interface  BPSearchView()<UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIImageView *contentV;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *dataSource;

@end


@implementation BPSearchView{
    
    UIImage *_backgroud;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    _backgroud = [UIImage imageNamed:@"search_pvbg_bg_icon"];
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBColorAndAlpha(40, 50, 56, 0.2);

        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.tableView];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}


-(void)setStartPoint:(CGPoint)startPoint{
    
    _startPoint = startPoint;
    
    self.contentV.frame = CGRectMake(startPoint.x, MATCHSIZE(20), _backgroud.size.width, _backgroud.size.height);
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[self.tableView class]]) {
        return YES;
    }else if ([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

#pragma mark - gesture handle  tag touch click
- (void)viewTapGesture:(UITapGestureRecognizer *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(pSearchView:sender:)]) {
        [_delegate pSearchView:self sender:self];
    }
    self.hidden = YES;
}


-(UIImageView *)contentV{
    if (!_contentV) {
        
        _contentV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, _backgroud.size.width, _backgroud.size.height)];
        _contentV.layer.cornerRadius = MATCHSIZE(8);
        _contentV.clipsToBounds = YES;
        _contentV.backgroundColor = [UIColor colorWithPatternImage:_backgroud];
//        _contentV.image = _backgroud;
        _contentV.userInteractionEnabled = YES;
        _contentV.hidden = YES;
    }
    return _contentV;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, MATCHSIZE(22), self.contentV.frame.size.width,self.contentV.frame.size.height-MATCHSIZE(22)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = MATCHSIZE(8);
        _tableView.clipsToBounds = YES;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MATCHSIZE(100);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH,MATCHSIZE(100));
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.tag = indexPath.row;

    if (indexPath.row < self.dataSource.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Log(@"tableView did Select Row At IndexPath");

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(pSearchView:sender:)]) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:cell.textLabel.text key:@"search" tag:5] key:BPSEARCH];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BPEnterSerachNoti object:self userInfo:nil];

        [_delegate pSearchView:self sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
    
}

-(void)searchRequest:(NSString *)search{
    
    if(![@"" isEqualToString:search]){
        Log(@"搜索");
        kMaim((^{
            _dataSource = nil;
            
            // search sql
            NSString *sql = [NSString stringWithFormat:@"SELECT DISTINCT nameCH FROM %@ WHERE nameCH NOT IN  ('无', '') AND nameCH LIKE '%%%@%%'", kChairTable, search];
            Log(@"......sql:%@", sql);
           
            NSArray *fieldValues = [BPSearchChairDB searchFieldValueNorepeateFromDatabase:kDataBase sql:sql];
            Log(@"搜索结果： %@",fieldValues);
            if (fieldValues && fieldValues.count != 0) {
                Log(@"dataSource 更新");
                [self.dataSource removeAllObjects];
                [self.dataSource addObjectsFromArray:fieldValues];
                if (self.dataSource.count != 0) {
                    self.contentV.hidden = NO;
                    [self.tableView reloadData];
                }
            }else{
                [self.dataSource removeAllObjects];
                [self.tableView reloadData];
                self.contentV.hidden = YES;
                
            }
            
        }));
    }else{
        Log(@"不搜索");
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
        if (self.dataSource.count == 0) {
            self.contentV.hidden = YES;
        }else{
            self.contentV.hidden = NO;
        }
    }
    
}



@end
