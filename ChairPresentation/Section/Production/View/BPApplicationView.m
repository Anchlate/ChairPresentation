//
//  BPApplicationView.m
//  ChairPresentation
//
//  Created by chf on 16/3/22.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPApplicationView.h"
#import "BPApplicationCell.h"


@interface BPApplicationView()<UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate , BPApplicationCellDelegate>

@property (nonatomic , strong) UIImageView *contentV;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *dataSource;


@property (nonatomic , strong) UILabel *title;

@property (nonatomic , strong) UIButton *done;


@end


@implementation BPApplicationView{
    
    UIImage *_backgroud;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    _backgroud = [UIImage imageNamed:@"application_pvbg_bg_icon"];
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBColorAndAlpha(40, 50, 56, 0.2);
        
        [self.dataSource addObjectsFromArray:@[@"Header",[BPApplicationCellModel objectWithDict:@{@"name": @"主管办公椅" ,@"key":@"application_charge"}],
                                              [BPApplicationCellModel objectWithDict:@{@"name": @"职员办公椅",@"key":@"application_staff"}],
                                              [BPApplicationCellModel objectWithDict:@{@"name": @"会议椅",@"key":@"application_metting"}],
                                              [BPApplicationCellModel objectWithDict:@{@"name": @"洽谈椅",@"key":@"application_chatting"}],
                                              [BPApplicationCellModel objectWithDict:@{@"name": @"班前椅",@"key":@"application_office"}],
                                              [BPApplicationCellModel objectWithDict:@{@"name": @"休闲椅",@"key":@"application_relaxation"}],
                                               [BPApplicationCellModel objectWithDict:@{@"name": @"训练椅",@"key":@"application_train"}]]];
        
        Log(@"BPApplicationView init With Frame ");
        
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
    
    self.contentV.frame = CGRectMake(startPoint.x, MATCHSIZE(20),_backgroud.size.width, _backgroud.size.height);
    
}


-(void)refreshApplicationStatus{
    
    if (((NSMutableArray *)[BPFilters sharedFilter].dictionary[BPAPPLICATION]).count != 0) {
        Log(@"有已选用途");
        for (int i=1; i<self.dataSource.count; i++) {
            BPApplicationCellModel *model = self.dataSource[i];
            BPApplicationCell *cell = (BPApplicationCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            NSMutableArray *selApplications = [BPFilters sharedFilter].dictionary[BPAPPLICATION];
            Log(@"BPApplicationCell - model name:%@",cell.model.name);
            for (int j=0 ; j < selApplications.count ; j++) {
                BPKeyValue *keylavue = selApplications[j];
                Log(@"cache:%@",keylavue.value);
                if ([keylavue.value isEqualToString:model.name]) {
                    cell.status = YES;
                    model.selected = YES;
                    break;
                }else{
                    cell.status = NO;
                    model.selected = NO;
                }
            }
            [self.dataSource replaceObjectAtIndex:i withObject:model];
        }
    }else{
        for (int i=1; i<self.dataSource.count; i++) {
            BPApplicationCellModel *model = self.dataSource[i];
            BPApplicationCell *cell = (BPApplicationCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.status = NO;
            model.selected = NO;
            [self.dataSource replaceObjectAtIndex:i withObject:model];
        }
    }
    
    
}


-(UIImageView *)contentV{
    if (!_contentV) {
        _contentV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,_backgroud.size.width, _backgroud.size.height)];
        _contentV.layer.cornerRadius = MATCHSIZE(8);
        _contentV.clipsToBounds = YES;
        _contentV.backgroundColor = [UIColor clearColor];
        _contentV.userInteractionEnabled = YES;
        _contentV.image = _backgroud;
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
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

#pragma mark - gesture handle  tag touch click
- (void)viewTapGesture:(UITapGestureRecognizer *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(applicationView:sender:)]) {
        [_delegate applicationView:self sender:self];
    }
    self.hidden = YES;
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
    
    if (indexPath.row == 0) {
        BPApplicationCellHeader * cell = [[BPApplicationCellHeader alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeaderCell" frame:CGRectMake(0, 0, self.contentV.frame.size.width, MATCHSIZE(100))];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else{
        static NSString *cellIndentifier = @"Cell";
        BPApplicationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[BPApplicationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, self.contentV.frame.size.width, MATCHSIZE(100))];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataSource[indexPath.row];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        
        BPApplicationCellModel *model = self.dataSource[indexPath.row];
        
        BPApplicationCell *cell = (BPApplicationCell *)[tableView cellForRowAtIndexPath:indexPath];

        [self searchWithKey:model.key value:model.name data:^(BOOL data) {
            if (data) {
                if (cell.status) {
                    cell.status = NO;
                    model.selected = NO;
                }else{
                    cell.status = YES;
                    model.selected = YES;
                }
                [self.dataSource replaceObjectAtIndex:indexPath.row withObject:model];
                
                if (_delegate && [_delegate respondsToSelector:@selector(applicationView:sender:)]) {
                    
                    Log(@"%@ %@",model.key , model.name);
                    
                    [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:model.name key:model.key tag:2] key:BPAPPLICATION];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
                    
                    [_delegate applicationView:self sender:cell];
                }
            }
        }];
        
//        if (cell.status) {
//            cell.status = NO;
//            model.selected = NO;
//        }else{
//            cell.status = YES;
//            model.selected = YES;
//        }
//        [self.dataSource replaceObjectAtIndex:indexPath.row withObject:model];
//        
//        if (_delegate && [_delegate respondsToSelector:@selector(applicationView:sender:)]) {
//            
//            Log(@"%@ %@",model.key , model.name);
//            
//            [[BPFilters sharedFilter] addReplaceFilters:[BPKeyValue objectWithValue:model.name key:model.key tag:2] key:BPAPPLICATION];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:BPFiltersNoti object:self userInfo:nil];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:BPConditionSerachNoti object:self userInfo:nil];
//            
//            [_delegate applicationView:self sender:cell];
//        }
        
    }
    
}

-(void)applicationCellHeader:(BPApplicationCellHeader *)view sender:(id)sender{
    Log(@"BP Application 选择确定回调");
    if (_delegate && [_delegate respondsToSelector:@selector(applicationView:sender:)]) {
        [_delegate applicationView:self sender:self];
    }
    self.hidden = YES;
    
}

-(void)searchWithKey:(NSString *)key value:(NSString *)value  data:(void (^)(BOOL data))data{
    
    NSMutableArray *array =  [BPFilters sharedFilter].getfiltersList;
    [array addObject:[BPKeyValue objectWithValue:value key:key tag:2]];
    
    for (BPKeyValue *keyvalue in array) {
        Log(@"%@:%@",keyvalue.key,keyvalue.value);
    }
    NSArray *searchs = [BPSearchChairDB searchChairsWithFieldItems:array];
    Log(@"%@",searchs);
    if (searchs.count == 0) {
        data(NO);
    }else{
        data(YES);
    }
}




@end
