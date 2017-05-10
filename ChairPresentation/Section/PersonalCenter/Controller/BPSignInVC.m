//
//  BPSignInVC.m
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSignInVC.h"
#import "BPSignInView.h"
#import "BPHomeVC.h"

@interface BPSignInVC ()<BPSignInViewDelegate>


@property (nonatomic , strong) BPSignInView *signINView;

@end

@implementation BPSignInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.signINView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    [self prefersStatusBarHidden];
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signInView:(BPSignInView *)view sender:(id)sender{
    
    if (sender == view.signIn) {
        
////        [MBProgressHUD showMessage:@"登录"];
//        
//        kMaim(^{
//            
//            [NSThread sleepForTimeInterval:1.0];
////            [MBProgressHUD hideHUD];
//            
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setBool:YES forKey:isSignIn];
//            [userDefault synchronize];
//            
//            BPHomeVC *homeVC = [[BPHomeVC alloc] init];
//            [self.navigationController pushViewController:homeVC animated:YES];
//
//        });
        
        BPHomeVC *homeVC = [[BPHomeVC alloc] init];
        [self.navigationController pushViewController:homeVC animated:YES];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_queue_create("sc", DISPATCH_QUEUE_CONCURRENT), ^{
//            Log(@"sign in");
//        });

    }
    
}

-(BPSignInView *)signINView{
    if (!_signINView) {
        CGFloat startY = 0;
        _signINView = [[BPSignInView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-startY)];
        _signINView.delegate = self;
    }
    return _signINView;
}

@end
