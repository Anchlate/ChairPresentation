//
//  BPViewController.h
//  Converse
//
//  Created by chf on 16/1/19.
//  Copyright © 2016年 baiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPVCKeyBoardDelegate <NSObject>

@optional
- (void) keyBoardShowHideAction:(NSNotification *)notification;


@end


@interface BPViewController : UIViewController


@property (nonatomic,weak) id<BPVCKeyBoardDelegate> keyBoardDelegate;


@end
