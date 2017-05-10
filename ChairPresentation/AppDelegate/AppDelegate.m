//
//  AppDelegate.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "AppDelegate.h"
#import "BPSignInVC.h"
#import "BPHomeVC.h"
#import "BPNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:NO forKey:isSignIn];
    [userDefault setValue:@"1" forKey:Role];
    [userDefault synchronize];

    Log(@"scale = %.0f",[UIScreen mainScreen].scale);
    Log(@"SCREEN_WIDTH = %.0f",SCREEN_WIDTH);
    Log(@"SCREEN_HEIGHT = %.0f",SCREEN_HEIGHT);
    
    
    [NSThread sleepForTimeInterval:2.5];

    
    [self intoAPP];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/** 第一次使用的action */
-(void)firstUseAction{
    BOOL notFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"notfirst"];
    if (notFirst) {
        //不是第一次登陆的代码
    } else {
        //第一次登陆的代码
        //保存不是第一次登陆的状态，下次启动时就不会再启动这部分代码了
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notfirst"];
        [NSUserDefaults resetStandardUserDefaults];
    }
}

-(void) intoAPP{
   
    if ([[NSUserDefaults standardUserDefaults] boolForKey:isSignIn]) {
        BPHomeVC *homeVC = [[BPHomeVC alloc] init];
        BPNavigationController *homeNavVC = [[BPNavigationController alloc] initWithRootViewController:homeVC];
        [self.window setRootViewController:homeNavVC];
    }else{
        BPSignInVC *signINVC = [[BPSignInVC alloc] init];
        BPNavigationController *signInNavVC = [[BPNavigationController alloc] initWithRootViewController:signINVC];
        [self.window setRootViewController:signInNavVC];
    }
    
}



@end
