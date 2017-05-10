//
//  BPSignInView.h
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTextField.h"


@class BPSignInView;

@protocol BPSignInViewDelegate <NSObject>
@optional

- (void) signInView:(BPSignInView *)view sender:(id) sender;

@end



@interface BPSignInView : UIView


@property (nonatomic ,  strong) UIButton *signIn;


@property (nonatomic , strong) BPTextField *account;

@property (nonatomic , strong) BPTextField *password;

@property (nonatomic ,  strong) UIButton *forgetPwd;


@property (nonatomic,weak) id<BPSignInViewDelegate> delegate;


@end