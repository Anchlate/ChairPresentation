//
//  BPShareView.m
//  ChairPresentation
//
//  Created by chf on 16/3/26.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPShareView.h"

#import "BPSequenceTCell.h"

@implementation BPShareItem

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _title = dict[@"title"];
        _image = dict[@"image"];
    }
    return self;
}

+ (instancetype) objectWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end



@interface BPShareView()<UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate>


@property (nonatomic , strong) UIView *contentV;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *dataSource;


@end

@implementation BPShareView{
    
    UIImage *_backgroud;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    _backgroud = [UIImage imageNamed:@"sequence_pvbg_bg_icon"];
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBColorAndAlpha(40, 50, 56, 0.2);
        
        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.tableView];
        
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}


-(void)setStartPoint:(CGPoint)startPoint{
    
    _startPoint = startPoint;
    
    self.contentV.frame = CGRectMake(startPoint.x-_backgroud.size.width+MATCHSIZE(64),_startPoint.y + MATCHSIZE(20), _backgroud.size.width, _backgroud.size.height);
    
}

-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _backgroud.size.width, _backgroud.size.height)];
        _contentV.layer.cornerRadius = MATCHSIZE(8);
        _contentV.clipsToBounds = YES;
        _contentV.backgroundColor = [UIColor colorWithPatternImage:_backgroud];
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
        [_dataSource addObject:[BPShareItem objectWithDict:@{@"title":@"分享到",@"image":@""}]];
        [_dataSource addObject:[BPShareItem objectWithDict:@{@"title":@"邮箱",@"image":@"email"}]];
        [_dataSource addObject:[BPShareItem objectWithDict:@{@"title":@"微信",@"image":@"wechat"}]];
        [_dataSource addObject:[BPShareItem objectWithDict:@{@"title":@"QQ",@"image":@"qq"}]];
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
- (void)viewTapped:(UITapGestureRecognizer *)sender{
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
    
    static NSString *cellIndentifier = @"Cell";
    BPSequenceTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[BPSequenceTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.frame = CGRectMake(0, 0, self.contentV.frame.size.width,MATCHSIZE(100));
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    BPShareItem *item = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    cell.textLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1);
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed:item.image];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Log(@"tableView did Select Row At IndexPath");
   [self removeFromSuperview];
   
    
}


@end
