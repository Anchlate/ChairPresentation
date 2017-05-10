//
//  BPSignInView.m
//  ChairPresentation
//
//  Created by chf on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPSignInView.h"


@interface BPSignInView()<UITextFieldDelegate>

@property (nonatomic , strong) UIView *contentV;

@property (nonatomic , strong) UIImageView *backgImagV;

//@property (nonatomic , strong) UIImageView *logoIV;

@property (nonatomic , strong) UIView *enterV;

@property (nonatomic , strong) UIImageView *accountImgV;

@property (nonatomic , strong) UIImageView *passwordImgV;

@property (nonatomic , strong) UIView *hLine;

@end

@implementation BPSignInView{
    
    CGFloat marginT;
    CGFloat marginL;
    CGFloat marginB;
    CGFloat marginR;
    
    CGFloat cursorY;
    
}


-(instancetype) initWithFrame:(CGRect)frame{
    
    marginB = 10;
    
    if (self = [super initWithFrame:frame]) {
       
        [self addSubview:self.backgImagV];
        
        [self addSubview:self.contentV];
        
//        [self.contentV addSubview:self.logoIV];
        
        [self.contentV addSubview:self.enterV];
        
        [self.enterV addSubview:self.accountImgV];
        
        [self.enterV addSubview:self.account];
        
        [self.enterV addSubview:self.hLine];
        
        [self.enterV addSubview:self.passwordImgV];
        
        [self.enterV addSubview:self.password];
        
        [self.contentV addSubview:self.signIn];
        
        [self.contentV addSubview:self.forgetPwd];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillHideNotification object:nil];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentV.backgroundColor = [UIColor clearColor];
    }
    return _contentV;
}

-(UIImageView *)backgImagV{
    if (!_backgImagV) {
        _backgImagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backgImagV.image = [UIImage imageNamed:@"signin_def_backg"];
    }
    return _backgImagV;
}

//-(UIImageView *)logoIV{
//    if (!_logoIV) {
//        UIImage *icon = [UIImage imageNamed:@"signin_logo_icon"];
//        _logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
//        _logoIV.center = CGPointMake(self.contentV.frame.size.width-200-icon.size.width/2, 300+icon.size.height/2);
//        _logoIV.image = icon;
//    }
//    return _logoIV;
//}

-(UIView *)enterV{
    if (!_enterV) {
        _enterV = [[UIView alloc] initWithFrame:CGRectMake(self.contentV.frame.size.width-MATCHSIZE(60)-MATCHSIZE(690), MATCHSIZE(604), MATCHSIZE(690), MATCHSIZE(200))];
        _enterV.layer.borderWidth = MATCHSIZE(4);
        _enterV.layer.borderColor = [RGBColorAndAlpha(224, 224, 224, 1) CGColor] ;
        _enterV.layer.cornerRadius = MATCHSIZE(10);
        _enterV.clipsToBounds = YES;
    }
    return _enterV;
}

-(UIImageView *)accountImgV{
    if (!_accountImgV) {
        UIImage *icon = [UIImage imageNamed:@"account_enter_icon"];
        _accountImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
        _accountImgV.image = icon;
    }
    return _accountImgV;
}

-(UIView *)hLine{
    if (!_hLine) {
        _hLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.accountImgV.frame.origin.y+self.accountImgV.frame.size.height, _enterV.frame.size.width, 0.5)];
        _hLine.backgroundColor = RGBColorAndAlpha(224, 224, 224, 1);
    }
    return _hLine;
}


-(UIImageView *)passwordImgV{
    if (!_passwordImgV) {
        UIImage *icon = [UIImage imageNamed:@"password_enter_icon"];
        _passwordImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.hLine.frame.origin.y+self.hLine.frame.size.height, icon.size.width, icon.size.height)];
        _passwordImgV.image = icon;
    }
    return _passwordImgV;
}


-(BPTextField *)account{
    if (!_account) {
        _account = [[BPTextField alloc] initWithFrame:CGRectMake(self.accountImgV.frame.origin.x+self.accountImgV.frame.size.width,
                                                                 0,
                                                                 self.contentV.frame.size.width/3,
                                                                 self.enterV.frame.size.height/2) andInsets: UIEdgeInsetsMake(0, 10, 0, 10)];
        _account.placeholder = @"用户名";
        [_account setValue:RGBColorAndAlpha(191, 191, 191, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [_account setValue:[UIFont boldSystemFontOfSize:MATCHSIZE(30)] forKeyPath:@"_placeholderLabel.font"];
        _account.returnKeyType = UIReturnKeyNext;
        _account.delegate =self;
        _account.backgroundColor = [UIColor whiteColor];
    }
    return _account;
}


-(BPTextField *)password{
    if (!_password) {
        _password = [[BPTextField alloc] initWithFrame:CGRectMake(self.passwordImgV.frame.origin.x+self.passwordImgV.frame.size.width,
                                                                  self.passwordImgV.frame.origin.y,
                                                                  self.contentV.frame.size.width/3,
                                                                  self.enterV.frame.size.height/2) andInsets: UIEdgeInsetsMake(0, 10, 0, 10)];
        _password.placeholder = @"密码";
        [_password setValue:RGBColorAndAlpha(191, 191, 191, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [_password setValue:[UIFont boldSystemFontOfSize:MATCHSIZE(30)] forKeyPath:@"_placeholderLabel.font"];
        _password.returnKeyType = UIReturnKeyGo;
        _password.delegate =self;
        _password.backgroundColor = [UIColor whiteColor];
    }
    return _password;
}

-(UIButton *)forgetPwd{
    if (!_forgetPwd) {
        NSString *text = @"忘记密码?";
        UIFont *titleFont = [UIFont systemFontOfSize:MATCHSIZE(30)];
        CGSize wordCGSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MATCHSIZE(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
        _forgetPwd = [[UIButton alloc] initWithFrame:CGRectMake(self.contentV.frame.size.width-MATCHSIZE(60)-wordCGSize.width,
                                                                self.enterV.frame.origin.y+self.enterV.frame.size.height+MATCHSIZE(20),
                                                                wordCGSize.width, MATCHSIZE(30))];
        
        _forgetPwd.titleLabel.font = titleFont;
        [_forgetPwd setTitle:text forState:UIControlStateNormal];
        [_forgetPwd setTitleColor:RGBColorAndAlpha(0, 162, 233, 1) forState:UIControlStateNormal];
        [_forgetPwd addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _forgetPwd;
}



-(UIButton *)signIn{
    if (!_signIn) {
        UIImage *icon = [UIImage imageNamed:@"signin"];
        _signIn = [[UIButton alloc] initWithFrame:CGRectMake(self.contentV.frame.size.width-MATCHSIZE(60)-icon.size.width, self.forgetPwd.frame.origin.y+self.forgetPwd.frame.size.height+MATCHSIZE(20), icon.size.width,icon.size.height)];
        _signIn.layer.cornerRadius = MATCHSIZE(10);
        _signIn.clipsToBounds = YES;
        [_signIn setBackgroundImage:icon forState:UIControlStateNormal];
        [_signIn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _signIn;
}


#pragma mark - gesture handle  tag touch click
- (void)viewTapped:(UITapGestureRecognizer *)sender{
    [self endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == self.password) {
        if (_delegate && [_delegate respondsToSelector:@selector(signInView:sender:)]) {
            [_delegate signInView:self sender:self.signIn];
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    Log(@"textField Did Begin Editing");
    cursorY = self.enterV.frame.origin.y+textField.frame.origin.y+textField.frame.size.height;
    
}


#pragma mark button Target selector
-(void)buttonAction:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(signInView:sender:)]) {
        [_delegate signInView:self sender:sender];
    }
}



- (void) keyboardNotificationAction:(NSNotification *)notification{
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        
        NSDictionary *userInfo = [notification userInfo];
        NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGFloat keyBoardY = value.CGRectValue.origin.y-64;
        
        NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        WEAKSELF(weakSelf);
        // 添加移动动画，使视图跟随键盘移动
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            if (cursorY > keyBoardY) {
                weakSelf.contentV.frame = CGRectMake(self.contentV.frame.origin.x, self.contentV.frame.origin.x-(cursorY-keyBoardY), self.contentV.frame.size.width, self.contentV.frame.size.height);
            }
            
        }];
        
        
    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]){
        NSDictionary *userInfo = [notification userInfo];
        NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        WEAKSELF(weakSelf);
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            weakSelf.contentV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }];
        
    }
    
    
}


@end
