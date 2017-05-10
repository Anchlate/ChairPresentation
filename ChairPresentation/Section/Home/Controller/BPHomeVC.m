//
//  BPHomeVC.m
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPHomeVC.h"
#import "BPSignInVC.h"
#import "BPHomeView.h"

#import "BPProductionVC.h"

@interface BPHomeVC ()<BPHomeViewDelegate>

@property (nonatomic , strong) BPHomeView *homeView;
@property (nonatomic, strong) UIButton *detailBtn;

@end

@implementation BPHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewBackgroundColor;
    
    [self.view addSubview:self.homeView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    [self prefersStatusBarHidden];
    
}

-(void)viewDidAppear:(BOOL)animated{
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:isSignIn]) {
//        BPSignInVC *signINVC = [[BPSignInVC alloc] init];
//        signINVC.modalTransitionStyle =UIModalTransitionStyleCoverVertical;
//        [self presentModalViewController:signINVC animated:YES];
//    }
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

-(void)homeView:(BPHomeView *)view sender:(id)sender{
    BPProductionVC *productionVC =[[BPProductionVC alloc] init];
    productionVC.hidesBottomBarWhenPushed = YES;
    if (sender == view.allProduct) {
        Log(@"all product btn");
        UIButton *btn = (UIButton *)sender;
        productionVC.whereFrom = btn.tag;
        Log(@"%d",(int)btn.tag);
    }else {
        Log(@"product class btn");
        
        BPImgTxtButton *btn =(BPImgTxtButton *)sender;
        switch (btn.tag) {
            case 0:
            {
                productionVC.whereFrom = 2;
            }
                break;
            case 1:
            {
                productionVC.whereFrom = 3;
            }
                break;
            case 2:
            {
                productionVC.whereFrom = 4;
            }
                break;
            case 3:
            {
                productionVC.whereFrom = 5;
            }
                break;
            
        }
       
    }
    [self.navigationController pushViewController:productionVC animated:YES];
    
    
   
    
}


-(BPHomeView *)homeView{
    if (!_homeView) {
        CGFloat startY = 0;
        _homeView = [[BPHomeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT-startY)];
        _homeView.delegate = self;
    }
    return _homeView;
}



@end
