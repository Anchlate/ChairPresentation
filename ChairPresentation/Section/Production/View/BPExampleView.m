
//
//  BPExampleView.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/21.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPExampleView.h"
#import "MenuScrollView.h"

typedef NS_ENUM(NSInteger, ButtonType) {
    
    ButtonType_preOne   =  1 << 1,
    ButtonType_nextOne  =  1 << 2,
    
}NS_ENUM_AVAILABLE_IOS(8_0);

@interface BPExampleView ()<MenuScrollViewDelegate>

//    MenuScrollView *_menuView; // 菜单栏

@property (nonatomic, strong) MenuScrollView *menuView;
@property (nonatomic, strong) UIButton *preOneBtn;
@property (nonatomic, strong) UIButton *nextOneBtn;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *imageTips;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containnerView;

@end

@implementation BPExampleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.images = @[@"ergohuman.jpg", @"ergohumanPlus.jpg", @"enjoy.jpg", @"brant.jpg", @"vapor_x.jpg", @"nefil.jpg", @"ioo.jpg", @"skate.jpg", @"lii.jpg", @"nuvem.jpg", @"nuvemPlus.jpg", @"genidir.jpg", @"genidirSmart.jpg", @"e-stool.jpg"];
        
        self.imageTips = @[@"ergohumanTip", @"ergohumanPlusTip", @"enjoyTip", @"brantTip", @"vaporxTip", @"nefilTip", @"iooTip", @"skateTip", @"liiTip", @"nuvemTip", @"nuvemPlusTip", @"genidirTip", @"genidirSmartTip", @"estoolTip"];
        self.currentIndex = 0;
        
        // preoneBtn
        [self addSubview:self.preOneBtn];
        self.preOneBtn.frame = CGRectMake(0, 0, 44, 101);
        
        // menuView;
        
        _menuView = [[MenuScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.preOneBtn.frame), 0, frame.size.width - CGRectGetWidth(self.preOneBtn.frame) * 2, 101) andImages:self.imageTips];
        
        _menuView.delegate = self;
        
        [self addSubview:_menuView];
        
        // imageView
        self.imageView.frame = CGRectMake(0, CGRectGetMaxY(_menuView.frame), frame.size.width, frame.size.height - _menuView.frame.size.height);
        [self addSubview:self.imageView];
        
//        self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(_menuView.frame), frame.size.width, frame.size.height - _menuView.frame.size.height);
//        //        [self addSubview:self.imageView];
//        [self addSubview:self.scrollView];
//        [self.scrollView addSubview:self.containnerView];
//        [self.containnerView addSubview:self.imageView];
        
        // nextOneBtn
        [self addSubview:self.nextOneBtn];
        self.nextOneBtn.frame = CGRectMake(CGRectGetMaxX(_menuView.frame), 0, CGRectGetWidth(self.preOneBtn.frame), CGRectGetHeight(self.preOneBtn.frame));

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    WEAKSELF(weakSelf);
    
    // scrollView
    //    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(weakSelf.menuView.mas_bottom);
    //        make.leading.trailing.bottom.equalTo(weakSelf);
    //
    //    }];
    
    //        // containView
    //        [self.containnerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.edges.equalTo(weakSelf.scrollView);
    //            make.width.equalTo(weakSelf.scrollView);
    //        }];
    //
    //        // imageView
    //        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //            make.top.leading.trailing.equalTo(weakSelf.containnerView);
    //            //        make.edges.equalTo(weakSelf.scrollView);
    //
    //        }];
    //
    //        // containnerView
    //        [self.containnerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(weakSelf.imageView.mas_bottom);
    //        }];
    
}

-(void)didMenuScrollViewClickedAtIndex:(NSInteger)index
{
    Log(@"......didClick at index:%d",index);
    
    UIImage *image = nil;
    
    if (index < self.images.count) {
//        image = [UIImage imageCompressForSize:[UIImage imageNamed:self.images[index]] targetSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - _menuView.frame.size.height)];
        
        image = [UIImage imageCompressForWidth:[UIImage imageNamed:self.images[index]] targetWidth:self.bounds.size.width];
        
    }
    
    self.imageView.image = image;
    self.currentIndex = index;
}

#pragma mark -EventMethod
- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case ButtonType_preOne:
        {
            Log(@"......PreOne");
            if (self.currentIndex > 0) {
                self.currentIndex--;
            }
        }
            break;
            
        case ButtonType_nextOne:
        {
            Log(@"......NextOne");
            if (self.currentIndex < (self.imageTips.count - 1)) {
                self.currentIndex++;
            }
        }
            break;
        default:
            break;
    }
    
    Log(@"......count:%d", self.imageTips.count);
    Log(@"......index:%d", self.currentIndex);
    
    [_menuView changeButtonStateAtIndex:self.currentIndex];
    [_menuView selectAtIndex:self.currentIndex];
    
    /*
//    UIImage *image = nil;
//    
//    if (self.currentIndex < self.images.count) {
//        
//        image = [UIImage imageCompressForSize:[UIImage imageNamed:self.images[self.currentIndex]] targetSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - _menuView.frame.size.height)];
//        
//    }
//    
//    self.imageView.image = image ;
    */
}

#pragma mark -GetterMethod
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
//        _imageView.image = [UIImage imageCompressForSize:[UIImage imageNamed:@"ergohuman.jpg"] targetSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - _menuView.frame.size.height)];
//        _imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageCompressForWidth:[UIImage imageNamed:@"ergohuman.jpg"] targetWidth:self.bounds.size.width];
        
        
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

- (UIButton *)preOneBtn
{
    if (!_preOneBtn) {
        _preOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preOneBtn setImage:[UIImage imageNamed:@"preOne"] forState:UIControlStateNormal];
        _preOneBtn.tag = ButtonType_preOne;
        [_preOneBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _preOneBtn.backgroundColor = [UIColor whiteColor];
    }
    return _preOneBtn;
}

- (UIButton *)nextOneBtn
{
    if (!_nextOneBtn) {
        _nextOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextOneBtn.tag = ButtonType_nextOne;
        [_nextOneBtn setImage:[UIImage imageNamed:@"nextOne"] forState:UIControlStateNormal];
        [_nextOneBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextOneBtn.backgroundColor = [UIColor whiteColor];
    }
    return _nextOneBtn;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)containnerView
{
    if (!_containnerView) {
        _containnerView = [[UIView alloc]init];
        _containnerView.backgroundColor = [UIColor redColor];
    }
    return _containnerView;
}

@end