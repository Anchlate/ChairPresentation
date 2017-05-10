//
//  BPProductionVC.m
//  ChairPresentation
//
//  Created by chf on 16/3/20.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionVC.h"
#import "BPProductionView.h"
#import "BPProductionDetailViewController.h"
#import "BPProductionVNavBarV.h"
#import "BPSignInVC.h"
#import "BPSearchView.h"
#import "BPExampleView.h"


@interface BPProductionVC ()<BPProductionViewDelegate , BPProductionVNavBarVDelegate>

@property (nonatomic , strong) BPProductionView *productionView;

@property (nonatomic , strong) BPProductionVNavBarV *productionVNavBarV;

@property (nonatomic , strong) BPSearchView *searchView;

@property (nonatomic , strong) BPExampleView *exampleView;




@end

@implementation BPProductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewBackgroundColor;
    
    [self.view addSubview:self.productionVNavBarV];
    
    [self.view addSubview:self.productionView];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self prefersStatusBarHidden];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    Log(@"where from = %d",(int)self.whereFrom);
    
    switch (self.whereFrom) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [self.productionVNavBarV conditionButton:self.productionVNavBarV.series];
        }
            break;
        case 3:
        {
            [self.productionVNavBarV conditionButton:self.productionVNavBarV.application];
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            [self.productionVNavBarV searchAndSequenceAction:self.productionVNavBarV.search];
        }
            break;
    }

    _whereFrom = 0;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)productionView:(BPProductionView *)view sender:(id)sender tag:(NSInteger)tag chair:(BPChair *)chair{
    
    if (tag == 3) {
        BPProductionDetailViewController *productionDetailVC =[[BPProductionDetailViewController alloc] init];
        productionDetailVC.chair = chair;
        Log(@"%@",chair.nameen);
        productionDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productionDetailVC animated:YES];
    }
    
    
}


#pragma mark - 产品列表页的回调
-(void)productionView:(BPProductionView *)view sender:(id)sender tag:(NSInteger)tag{
    
    if (tag == 1) {
        BPMenuCell *cell = (BPMenuCell *)sender;
        if (cell.tag == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (cell.tag == 2){
            [self.view addSubview:self.exampleView];
        }else if (cell.tag == 1){
            [self.exampleView removeFromSuperview];
        }
    }else if (tag == 2) {
        if ([sender class] == [BPPopSettingV class]) {
            BPSignInVC *signINVC = [[BPSignInVC alloc] init];
            [self.navigationController pushViewController:signINVC animated:YES];
        }
    }else if (tag == 3) {
        BPProductionDetailViewController *productionDetailVC =[[BPProductionDetailViewController alloc] init];
        productionDetailVC.productID = 1;
        productionDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productionDetailVC animated:YES];
    }else if (tag == 4) {
        Log(@" 搜索 回调到 BPProductionView");
        [self.productionVNavBarV.searchTF resignFirstResponder];
        if (self.productionView.searchView.hidden) {
            self.productionVNavBarV.search.hidden = YES;
            self.productionVNavBarV.searchTF.hidden = NO;
            if (!self.productionView.psequenceView.hidden){
                self.productionView.psequenceView.hidden = YES;
            }
            self.productionView.searchView.startPoint = CGPointMake(self.productionVNavBarV.searchTF.frame.origin.x, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
            self.productionView.searchView.hidden = NO;
        }else{
            self.productionVNavBarV.search.hidden = NO;
            self.productionVNavBarV.searchTF.hidden = YES;
            self.productionView.searchView.hidden = YES;
        }
    }else if (tag == 5) {
        [self closeAllFilterV];
    }else if (tag == 6) {

    }else if (tag == 7) {
        [self closeAllFilterV];
    }else if (tag == 8) {

    }else if (tag == 9) {
        [self closeAllFilterV];
    }else if (tag == 10) {

    }else if (tag == 11) {
        [self closeAllFilterV];
    }else if (tag == 12) {

    }
    
    
}

#pragma mark - 导航栏
-(void)productionVNavBarV:(BPProductionVNavBarV *)view sender:(id)sender {
    
    if ([view class] == [BPProductionVNavBarV class]) {
        if (view.search == sender) {
            Log(@"搜索按钮 回调");
            if (self.productionView.searchView.hidden) { //显示
                
                if (!self.productionView.psequenceView.hidden){
                    self.productionView.psequenceView.hidden = YES;
                }
                if (!self.productionView.seriesView.hidden){
                    self.productionView.seriesView.hidden = YES;
                }
                if (!self.productionView.applicationView.hidden){
                    self.productionView.applicationView.hidden = YES;
                }
                if (!self.productionView.fabricsView.hidden){
                    self.productionView.fabricsView.hidden = YES;
                }
                if (!self.productionView.functionView.hidden){
                    self.productionView.functionView.hidden = YES;
                }
                
                [self.productionVNavBarV.searchTF resignFirstResponder];
                self.productionVNavBarV.search.hidden = YES;
                self.productionVNavBarV.searchTF.hidden = NO;

                self.productionView.searchView.startPoint = CGPointMake(self.productionVNavBarV.searchTF.frame.origin.x, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
                self.productionView.searchView.hidden = NO;
                
            }else{//隐藏
                [self closeAllFilterV];
            }

        }else if (view.sequence == sender) {
            Log(@"排序按钮 回调");
            if (self.productionView.psequenceView.hidden) {
                
                if (!self.productionVNavBarV.searchTF.hidden){
                    [self.productionVNavBarV.searchTF resignFirstResponder];
                    self.productionVNavBarV.search.hidden = NO;
                    self.productionVNavBarV.searchTF.hidden = YES;
                }
                if (!self.productionView.searchView.hidden){
                    self.productionView.searchView.hidden = YES;
                }
                if (!self.productionView.seriesView.hidden){
                    self.productionView.seriesView.hidden = YES;
                }
                if (!self.productionView.applicationView.hidden){
                    self.productionView.applicationView.hidden = YES;
                }
                if (!self.productionView.fabricsView.hidden){
                    self.productionView.fabricsView.hidden = YES;
                }
                if (!self.productionView.functionView.hidden){
                    self.productionView.functionView.hidden = YES;
                }
                
                self.productionView.psequenceView.startPoint = CGPointMake(self.productionVNavBarV.sequence.frame.origin.x, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
                self.productionView.psequenceView.hidden = NO;
                
            }else{
               [self closeAllFilterV];
            }
            
        }else if (view.series == sender) { //系列按钮回调
            
            if (self.productionView.seriesView.hidden) {
                
                self.productionVNavBarV.search.hidden = NO;
                self.productionVNavBarV.searchTF.hidden = YES;
                self.productionView.searchView.hidden = YES;
                
                self.productionView.applicationView.hidden = YES;
                self.productionView.fabricsView.hidden = YES;
                self.productionView.functionView.hidden = YES;
                self.productionView.psequenceView.hidden = YES;
                self.productionView.settingView.hidden = YES;
                
                self.productionView.seriesView.startPoint = CGPointMake(self.productionVNavBarV.series.frame.origin.x, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
                [self.productionView.seriesView refreshSeriesSelStatus];
                self.productionView.seriesView.hidden = NO;
                
            }else{
                [self closeAllFilterV];
            }
            
        }else if (view.application == sender) {//用途按钮回调
            
            if (self.productionView.applicationView.hidden) {
                
                self.productionVNavBarV.search.hidden = NO;
                self.productionVNavBarV.searchTF.hidden = YES;
                self.productionView.searchView.hidden = YES;
                
                self.productionView.seriesView.hidden = YES;
                self.productionView.fabricsView.hidden = YES;
                self.productionView.functionView.hidden = YES;
                self.productionView.psequenceView.hidden = YES;
                self.productionView.settingView.hidden = YES;
                
                
                self.productionView.applicationView.startPoint = CGPointMake(self.productionVNavBarV.application.frame.origin.x, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
                [self.productionView.applicationView refreshApplicationStatus];
                self.productionView.applicationView.hidden = NO;
            }else{
                [self closeAllFilterV];
            }
        }else if (view.fabrics == sender) {// 面料按钮回调
            
            if (self.productionView.fabricsView.hidden) {
                
                self.productionVNavBarV.search.hidden = NO;
                self.productionVNavBarV.searchTF.hidden = YES;
                self.productionView.searchView.hidden = YES;
                
                self.productionView.seriesView.hidden = YES;
                self.productionView.applicationView.hidden = YES;
                self.productionView.functionView.hidden = YES;
                self.productionView.psequenceView.hidden = YES;
                self.productionView.settingView.hidden = YES;
                
                self.productionView.fabricsView.startPoint = CGPointMake(self.productionVNavBarV.fabrics.frame.origin.x+self.productionVNavBarV.fabrics.frame.size.width/2, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
                [self.productionView.fabricsView refreshFabricsStatus];
                self.productionView.fabricsView.hidden = NO;
            }else{
                [self closeAllFilterV];
            }
        }else if (view.function == sender) {// 功能按钮回调
            
            if (self.productionView.functionView.hidden) {
                
                self.productionVNavBarV.search.hidden = NO;
                self.productionVNavBarV.searchTF.hidden = YES;
                self.productionView.searchView.hidden = YES;
                
                self.productionView.seriesView.hidden = YES;
                self.productionView.applicationView.hidden = YES;
                self.productionView.fabricsView.hidden = YES;
                self.productionView.psequenceView.hidden = YES;
                self.productionView.settingView.hidden = YES;
                
                self.productionView.functionView.startPoint = CGPointMake(self.productionVNavBarV.function.frame.origin.x+self.productionVNavBarV.function.frame.size.width/2, self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height);
                [self.productionView.functionView refreshFunctionStatus];
                self.productionView.functionView.hidden = NO;
            }else{
                [self closeAllFilterV];
            }
        }else if (view.searchTF == sender) { //搜索
            Log(@"搜索输入");
            kMaim(^{
                [self.productionView.searchView searchRequest:view.searchTF.text];
            });
            
        }
    }
    
}


-(BPProductionVNavBarV *)productionVNavBarV{
    if (!_productionVNavBarV) {
        _productionVNavBarV = [[BPProductionVNavBarV alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MATCHSIZE(100))];
        _productionVNavBarV.delegate = self;
    }
    return _productionVNavBarV;
}

-(BPProductionView *)productionView{
    if (!_productionView) {
        CGFloat startY =self.productionVNavBarV.frame.origin.y+self.productionVNavBarV.frame.size.height;
        _productionView = [[BPProductionView alloc] initWithFrame:CGRectMake(0, startY, SCREEN_WIDTH, SCREEN_HEIGHT-startY)];
        _productionView.delegate = self;
    }
    return _productionView;
}


-(BPExampleView *)exampleView{
    if (!_exampleView) {
        _exampleView = [[BPExampleView alloc]initWithFrame:CGRectMake(self.productionView.lView.frame.size.width+self.productionView.lView.frame.origin.x, 0, SCREEN_WIDTH-(self.productionView.lView.frame.size.width+self.productionView.lView.frame.origin.x), SCREEN_HEIGHT)];
    }
    return _exampleView;
}

-(void)closeAllFilterV{
    
    self.productionVNavBarV.search.hidden = NO;
    self.productionVNavBarV.searchTF.hidden = YES;
    
    self.productionView.seriesView.hidden = YES;
    self.productionView.applicationView.hidden = YES;
    self.productionView.fabricsView.hidden = YES;
    self.productionView.functionView.hidden = YES;
    
    self.productionView.settingView.hidden = YES;
    
    self.productionView.searchView.hidden = YES;
    
    self.productionVNavBarV.series.status = NO;
    self.productionVNavBarV.application.status = NO;
    self.productionVNavBarV.fabrics.status = NO;
    self.productionVNavBarV.function.status = NO;
    
}


@end
