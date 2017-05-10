//
//  BPPopSettingV.m
//  ChairPresentation
//
//  Created by chf on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPPopSettingV.h"

@interface BPPopSettingV()<UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate>


@property (nonatomic , strong) UIImageView *contentV;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *dataSource;




@end

@implementation BPPopSettingV{

   CGPoint startPoint;
    
    UIImage *_backgroud;
    
}

-(instancetype)initWithFrame:(CGRect)frame point:(CGPoint)point{
    startPoint = point;
    _backgroud = [UIImage imageNamed:@"setting_pvbg_bg_icon"];
    if (self = [super initWithFrame:frame]) {
        
        self.tag = -1;
        
        self.backgroundColor = RGBColorAndAlpha(40, 50, 56, 0.2);

        [self addSubview:self.contentV];
        
        [self.contentV addSubview:self.tableView];
        
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}



-(UIImageView *)contentV{
    if (!_contentV) {
        _contentV = [[UIImageView alloc] initWithFrame:CGRectMake(startPoint.x-20, startPoint.y-_backgroud.size.height, _backgroud.size.width, _backgroud.size.height)];
        _contentV.layer.cornerRadius = MATCHSIZE(10);
        _contentV.clipsToBounds = YES;
        _contentV.userInteractionEnabled = YES;
//        _contentV.backgroundColor = [UIColor colorWithPatternImage:_backgroud];
        _contentV.image = _backgroud;
    }
    return _contentV;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentV.frame.size.width,self.contentV.frame.size.height-MATCHSIZE(40)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObject:@"设置"];
        [_dataSource addObject:@"VIP"];
        [_dataSource addObject:@"SVIP"];
    }
    return _dataSource;
}

-(UIButton *)logOut{
    if (!_logOut) {
        _logOut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentV.frame.size.width-20 , MATCHSIZE(88))];
        [_logOut setTitle:@"退出" forState:UIControlStateNormal];
        [_logOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logOut.backgroundColor = MainColor;
        _logOut.layer.cornerRadius = 4;
        _logOut.clipsToBounds = YES;
        [_logOut addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _logOut;
}

-(void)logOutAction:(UIButton *) sender{
    Log(@"退出");
    if (_delegate && [_delegate respondsToSelector:@selector(popSettingView:sender:)]) {
//        [self removeFromSuperview];
        self.hidden = YES;
        [_delegate popSettingView:self sender:sender];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }
    return NO;
}


#pragma mark - gesture handle  tag touch click
- (void)viewTapped:(UITapGestureRecognizer *)sender{
//    [self removeFromSuperview];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return MATCHSIZE(160);
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView;
    if (section == 0) {
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentV.frame.size.width, MATCHSIZE(160))];
        self.logOut.center = CGPointMake(footerView.frame.size.width/2,footerView.frame.size.height/2);
        [footerView addSubview:self.logOut];
    }
    
    return footerView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH,MATCHSIZE(100));
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.tag = indexPath.row;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Log(@"tableView did Select Row At IndexPath");

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSString stringWithFormat:@"%d",(int)indexPath.row] forKey:Role];
    [userDefault synchronize];
    
    if (_delegate && [_delegate respondsToSelector:@selector(popSettingView:sender:)]) {
//        [self removeFromSuperview];
        self.hidden = YES;
        [_delegate popSettingView:self sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
