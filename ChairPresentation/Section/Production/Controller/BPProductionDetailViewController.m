//
//  BPProductionDetailViewController.m
//  ChairPresentation
//
//  Created by PENG BAI on 16/3/19.
//  Copyright © 2016年 bp1010. All rights reserved.
//

#import "BPProductionDetailViewController.h"
#import "DCPicScrollView.h"

#import "BPShareView.h"

#define kDetailNormalFont [UIFont systemFontOfSize:15]
#define kDetailSelectedFont [UIFont systemFontOfSize:16]
#define kDetailNormalColor RGBColorAndAlpha(161, 161, 161, 1.0)
#define kDetailSelectedColor RGBColorAndAlpha(102, 102, 102, 1.0)

typedef NS_ENUM(NSInteger, DetailButtonType) {
    
    DetailButtonType_Back   =  1 << 1,
    DetailButtonType_Share  =  1 << 2,
    DetailButtonType_ToTop  =  1 << 3,
    
    DetailButtonType_Func_Material             = 1 << 4,
    DetailButtonType_Func_Human                = 1 << 5,
    DetailButtonType_Func_FuncIntroduction     = 1 << 6,
    DetailButtonType_Func_ProductFeature       = 1 << 7,
    DetailButtonType_Func_Size                 = 1 << 8,
    DetailButtonType_Func_ProductCertification = 1 << 9
    
}NS_ENUM_AVAILABLE_IOS(8_0);

@interface BPProductionDetailViewController ()<UIScrollViewDelegate>

//@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIButton *leftBackBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *toTopBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *holdDetailView;
@property (nonatomic, strong) UIImageView *detailImgView;
//@property (nonatomic, strong) UIView *funcHeaderLine;
@property (nonatomic, strong) UIView *funcBottomLine;


@property (nonatomic, strong) UIView *functionView;
@property (nonatomic, strong) UIView *holdFunctionBtnView;
@property (nonatomic,strong) UIView *holdFunctionTitleView;
@property (nonatomic, strong) UIScrollView *holdFuncImgViewScrollView;
@property (nonatomic, strong) UIView *secondContainerView;
@property (nonatomic, strong) UIImageView *functionImgView;

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *materialBtn;
@property (nonatomic, strong) UIButton *humanBtn;
@property (nonatomic, strong) UIButton *functionIntroBtn;
@property (nonatomic, strong) UIButton *productFeaturesBtn;
@property (nonatomic, strong) UIButton *sizeBtn;
@property (nonatomic, strong) UIButton *productCertificationBtn;

@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *materialLabel;
@property (nonatomic, strong) UILabel *humanLabel;
@property (nonatomic, strong) UILabel *functionIntroLabel;
@property (nonatomic, strong) UILabel *productFeaturesLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *productCertificationLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *originPriceLabel;
@property (nonatomic, strong) UILabel *discountPriceLabel;

@end

@implementation BPProductionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    Log(@",,nameEN:%@", self.chair.nameen);
    Log(@"..id:%ld", self.chair.id);
    
    self.selectedBtn = self.materialBtn;
    self.selectedLabel = self.materialLabel;
    self.selectedLabel.textColor = kDetailSelectedColor;
    self.selectedLabel.font = kDetailSelectedFont;
    
//    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.holdDetailView];
//    [self.containerView addSubview:self.funcHeaderLine];
    [self.containerView addSubview:self.functionView];
    
    [self.containerView addSubview:self.funcBottomLine];
    [self.containerView addSubview:self.holdFuncImgViewScrollView];
    
    [self.view addSubview:self.leftBackBtn];
    [self.view  addSubview:self.shareBtn];
    [self.holdFuncImgViewScrollView addSubview:self.secondContainerView];
    [self.secondContainerView addSubview:self.functionImgView];
    
    [self.holdDetailView addSubview:self.detailImgView];
    [self.functionView addSubview:self.holdFunctionBtnView];
    [self.functionView addSubview:self.holdFunctionTitleView];
    
    [self.holdFunctionBtnView addSubview:self.materialBtn];
    [self.holdFunctionBtnView addSubview:self.humanBtn];
    [self.holdFunctionBtnView addSubview:self.functionIntroBtn];
    [self.holdFunctionBtnView addSubview:self.productFeaturesBtn];
    [self.holdFunctionBtnView addSubview:self.sizeBtn];
    [self.holdFunctionBtnView addSubview:self.productCertificationBtn];
    
    [self.holdFunctionTitleView addSubview:self.materialLabel];
    [self.holdFunctionTitleView addSubview:self.humanLabel];
    [self.holdFunctionTitleView addSubview:self.functionIntroLabel];
    [self.holdFunctionTitleView addSubview:self.productFeaturesLabel];
    [self.holdFunctionTitleView addSubview:self.sizeLabel];
    [self.holdFunctionTitleView addSubview:self.productCertificationLabel];
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.nameLabel];
    [self.bottomView addSubview:self.originPriceLabel];
    [self.bottomView addSubview:self.discountPriceLabel];
    
    [self.view addSubview:self.toTopBtn];
    
    /*
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBackBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    */
    
    [self layoutViews];
    
    // getData
//    NSArray *filesPathArr = [NSFileManager filesInDicretoryPath:[NSString documentDirectoryPath] hasPrefix:[NSString stringWithFormat:@"%ld_detail_", self.productID]];
//    [self.datasource removeAllObjects];
//    [self.datasource addObjectsFromArray:filesPathArr];
//    [self.collectionView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark -DelegateMethod
#pragma mark -UIScrollViewDelegat
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 384) {
        [scrollView setContentOffset:CGPointMake(0, 384)];
        return;
    }
    static float newY = 0;
    static float oldY = 0;
    
    newY = scrollView.contentOffset.y;
    
    if (newY != oldY) {
        
        if (newY > oldY && scrollView.contentOffset.y > 200) {
            
//            Log(@"向上滑动:%@", NSStringFromCGPoint(scrollView.contentOffset));
            
            [UIView animateWithDuration:0.2 animations:^{
                [scrollView setContentOffset:CGPointMake(0, 384)];
            }];
            
            self.holdFuncImgViewScrollView.scrollEnabled = YES;
            
        }
        /*
//        else {
//            Log(@"向下滑动:%@", NSStringFromCGPoint(scrollView.contentOffset));
//            self.holdFuncImgViewScrollView.scrollEnabled = NO;
//        }
         */
        oldY = newY;
    }
    
    if (scrollView.contentOffset.y < 384) {
//        Log(@"xiaoyu:%@", NSStringFromCGPoint(scrollView.contentOffset));
        self.holdFuncImgViewScrollView.scrollEnabled = NO;
    }
}

#pragma mark -EventMethod
- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case DetailButtonType_Back:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case DetailButtonType_Share:{
            //分享
            BPShareView *shareView = [[BPShareView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            shareView.startPoint = CGPointMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height);
            [self.view addSubview:shareView];
        }
            
            break;
            
        case DetailButtonType_ToTop:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.contentOffset = CGPointZero;
                self.holdFuncImgViewScrollView.contentOffset = CGPointZero;
            }];
            
        }
            break;
    }
//    NSArray *fileArray = [NSFileManager filesInDicretoryPath:[NSString documentDirectoryPath]];
//    Log(@"......all files: %@", fileArray);
}

- (void)functionButtonClick:(UIButton *)button
{
    NSString *dir = [NSString documentDirectoryPathWithFileName:@"function"];
    NSString *searialPath = [dir stringByAppendingPathComponent:self.chair.serial];
        
//    self.selectedBtn.selected = NO;
//    button.selected = YES;
//    self.selectedBtn = button;
    
//    self.selectedLabel.textColor = kDetailNormalColor;
//    self.selectedLabel.font = kDetailNormalFont;

//    UIButton *tmpBtn = self.selectedBtn;
//    UILabel *tmpLabel = self.selectedLabel;
    
    BOOL isSeleted = NO;
    
    switch (button.tag) {
            
        case DetailButtonType_Func_Material:
        {
            NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_material.jpg", self.chair.nameen]];
            
            UIImage *image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];
            if (image) {
                self.functionImgView.image = image;
                self.selectedLabel = self.materialLabel;
                isSeleted = YES;
            }
            
        }
            break;
            
        case DetailButtonType_Func_Human:
        {
            NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_Human Engineering Innovation.jpg", self.chair.nameen]];
            
            UIImage *image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];
            if (image) {
                self.functionImgView.image = image;
                self.selectedLabel = self.materialLabel;
                isSeleted = YES;
            }
        }
            break;
            
        case DetailButtonType_Func_FuncIntroduction:
        {
            NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_Features.jpg", self.chair.nameen]];
            
            UIImage *image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];
            if (image) {
                self.functionImgView.image = image;
                self.selectedLabel = self.materialLabel;
                isSeleted = YES;
            }
        }
            
            break;
            
        case DetailButtonType_Func_ProductFeature:
        {
            NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_Product Characteristic.jpg", self.chair.nameen]];
            
            UIImage *image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];
            if (image) {
                self.functionImgView.image = image;
                self.selectedLabel = self.materialLabel;
                isSeleted = YES;
            }
        }
            
            break;
            
        case DetailButtonType_Func_Size:
        {
//            Log(@"size");
            NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_Technical Specifications.jpg", self.chair.nameen]];
            
            UIImage *image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];
            if (image) {
                self.functionImgView.image = image;
                self.selectedLabel = self.materialLabel;
                isSeleted = YES;
            }
        }
            
            break;
            
        case DetailButtonType_Func_ProductCertification:
        {
            NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_Certification Environmental Responsibility.jpg", self.chair.nameen]];
            
            UIImage *image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];
            if (image) {
                self.functionImgView.image = image;
                self.selectedLabel = self.materialLabel;
                isSeleted = YES;
            }
        }
            
            break;
            
        default:
            break;
    }
    
//    NSArray *fileArray = [NSFileManager filesInDicretoryPath:[NSString documentDirectoryPath]];
    
//    Log(@"......all files: %@", fileArray);

    if (isSeleted) {
        self.selectedBtn.selected = NO;
        button.selected = YES;
        self.selectedBtn = button;
    }
    
    self.selectedLabel.textColor = kDetailSelectedColor;
    self.selectedLabel.font = kDetailSelectedFont;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -PrivateMethod
- (void)layoutViews
{
    WEAKSELF(weakSelf);
    
    [NSBundle mainBundle];
    // leftBackBtn
    [self.leftBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.view).offset(15);
        make.centerY.equalTo(weakSelf.view.mas_top).offset(44);
        
    }];
    
    // shareBtn
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.view).offset(-15);
        make.centerY.equalTo(weakSelf.leftBackBtn);
        
    }];
    
    // toTop
    [self.toTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.view).offset(-15);
        make.bottom.equalTo(weakSelf.bottomView.mas_top).offset(-35);
//        make.size.mas_equalTo(CGSizeMake(44, 44));
        
    }];
    
    // scrollView
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(20);
        make.leading.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
        
    }];
    
    // containerView
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
        
    }];
    
    // holdDetailView
    [self.holdDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.trailing.equalTo(weakSelf.containerView);
        make.height.equalTo(@370);
        
    }];
    
    // detailImgView
    [self.detailImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.holdDetailView);
        
    }];
    
    // funcHeaderLine
//    [self.funcHeaderLine mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(weakSelf.holdDetailView.mas_bottom).offset(12);
//        make.leading.trailing.equalTo(weakSelf.containerView);
//        make.height.equalTo(@2);
//        
//    }];
    
    // functionView
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.holdDetailView.mas_bottom).offset(12);
        make.leading.trailing.equalTo(weakSelf.containerView);
        make.height.equalTo(@111);
        
    }];
    
    // funcBottomLine
    [self.funcBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.functionView.mas_bottom);
        make.leading.trailing.equalTo(weakSelf.containerView);
        make.height.equalTo(@11);
    }];
    
    // holdFunctionBtnView
    [self.holdFunctionBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.functionView);
        make.leading.equalTo(weakSelf.functionView).offset(138);
        make.trailing.equalTo(weakSelf.functionView).offset(-138);
        make.bottom.equalTo(weakSelf.holdFunctionTitleView.mas_top).offset(-2);
        
    }];
    
    [self.holdFunctionTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.equalTo(weakSelf.holdFunctionBtnView);
        make.bottom.equalTo(weakSelf.functionView).offset(-20);
        make.height.equalTo(@16);
        
    }];
    
    [self.materialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.top.bottom.equalTo(weakSelf.holdFunctionTitleView);
        make.trailing.equalTo(weakSelf.humanLabel.mas_leading);
        make.width.equalTo(weakSelf.humanLabel);
        
    }];
    
    [self.humanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionTitleView);
        make.leading.equalTo(weakSelf.materialLabel.mas_trailing);
        make.trailing.equalTo(weakSelf.functionIntroLabel.mas_leading);
        make.width.equalTo(weakSelf.functionIntroLabel);
        
    }];
    
    [self.functionIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionTitleView);
        make.leading.equalTo(weakSelf.humanLabel.mas_trailing);
        make.trailing.equalTo(weakSelf.productFeaturesLabel.mas_leading);
        make.width.equalTo(weakSelf.productFeaturesLabel);
        
    }];
    
    [self.productFeaturesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionTitleView);
        make.leading.equalTo(weakSelf.functionIntroLabel.mas_trailing);
        make.trailing.equalTo(weakSelf.sizeLabel.mas_leading);
        make.width.equalTo(weakSelf.sizeLabel);
        
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionTitleView);
        make.leading.equalTo(weakSelf.productFeaturesLabel.mas_trailing);
        make.trailing.equalTo(weakSelf.productCertificationLabel.mas_leading);
        make.width.equalTo(weakSelf.productCertificationLabel);
        
    }];
    
    [self.productCertificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.trailing.equalTo(weakSelf.holdFunctionTitleView);
        make.leading.equalTo(weakSelf.sizeLabel.mas_trailing);
        make.width.equalTo(weakSelf.materialLabel);
        
    }];
    
    /**********/
    
    [self.materialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.top.bottom.equalTo(weakSelf.holdFunctionBtnView);
        make.trailing.equalTo(weakSelf.humanBtn.mas_leading);
        make.width.equalTo(weakSelf.humanBtn);
        
    }];

    [self.humanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionBtnView);
        make.leading.equalTo(weakSelf.materialBtn.mas_trailing);
        make.trailing.equalTo(weakSelf.functionIntroBtn.mas_leading);
        make.width.equalTo(weakSelf.functionIntroBtn);
        
    }];
    
    [self.functionIntroBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionBtnView);
        make.leading.equalTo(weakSelf.humanBtn.mas_trailing);
        make.trailing.equalTo(weakSelf.productFeaturesBtn.mas_leading);
        make.width.equalTo(weakSelf.productFeaturesBtn);
        
    }];
    
    [self.productFeaturesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionBtnView);
        make.leading.equalTo(weakSelf.functionIntroBtn.mas_trailing);
        make.trailing.equalTo(weakSelf.sizeBtn.mas_leading);
        make.width.equalTo(weakSelf.sizeBtn);
        
    }];
    
    [self.sizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(weakSelf.holdFunctionBtnView);
        make.leading.equalTo(weakSelf.productFeaturesBtn.mas_trailing);
        make.trailing.equalTo(weakSelf.productCertificationBtn.mas_leading);
        make.width.equalTo(weakSelf.productCertificationBtn);
        
    }];
    
    [self.productCertificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.trailing.equalTo(weakSelf.holdFunctionBtnView);
        make.leading.equalTo(weakSelf.sizeBtn.mas_trailing);
        make.width.equalTo(weakSelf.materialBtn);
        
    }];
    
    // holdFuncImgViewScrollView
    [self.holdFuncImgViewScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.funcBottomLine.mas_bottom);
        make.leading.trailing.equalTo(weakSelf.containerView);
        make.height.equalTo(@(SCREEN_HEIGHT - 78 - 64 - 60));
        
    }];
    
    // secondCntainerView
    [self.secondContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.holdFuncImgViewScrollView);
        make.width.equalTo(weakSelf.holdFuncImgViewScrollView);
    }];
    
    // functionImgView
    [self.functionImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.trailing.equalTo(weakSelf.secondContainerView);
        
    }];
    
    //
    [self.secondContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.functionImgView.mas_bottom);
    }];
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.holdFuncImgViewScrollView.mas_bottom);
    }];
    
    // bottomView
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.bottom.trailing.equalTo(weakSelf.view);
        make.height.equalTo(@60);
        
    }];
    
    // nameLabel
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.bottomView).offset(67);
        make.top.bottom.equalTo(weakSelf.bottomView);
        make.trailing.equalTo(weakSelf.originPriceLabel.mas_leading);
        
    }];
    
    // originLabel
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.nameLabel.mas_trailing);
        make.trailing.equalTo(weakSelf.discountPriceLabel.mas_leading).offset(-25);
        make.bottom.equalTo(weakSelf.discountPriceLabel);
        
    }];
    
    // discountPriceLabel
    [self.discountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(weakSelf.bottomView).offset(-22);
        make.centerY.equalTo(weakSelf.bottomView);
        
    }];
}

#pragma mark -Getter
- (UIButton *)leftBackBtn
{
    if (!_leftBackBtn) {
        _leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBackBtn setImage:[UIImage imageNamed:@"detailBack"] forState:UIControlStateNormal];
        _leftBackBtn.tag = DetailButtonType_Back;
        [_leftBackBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBackBtn.frame = CGRectMake(0, 0, 44, 44);
    }
    return _leftBackBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"detailShare"] forState:UIControlStateNormal];
        _shareBtn.tag = DetailButtonType_Share;
        [_shareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.frame = CGRectMake(0, 0, 44, 44);
    }
    return _shareBtn;
}

- (UIButton *)toTopBtn
{
    if (!_toTopBtn) {
        
        _toTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toTopBtn setImage:[UIImage imageNamed:@"detailTop"] forState:UIControlStateNormal];
        _toTopBtn.tag = DetailButtonType_ToTop;
        [_toTopBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _toTopBtn;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.tag = 1;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = RGBColorAndAlpha(192, 192, 192, 0.5);
    }
    return _bottomView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
//        _containerView.backgroundColor = RGBColorAndAlpha(192, 192, 192, 1);
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UIView *)holdDetailView
{
    if (!_holdDetailView) {
        _holdDetailView = [[UIView alloc]init];
        _holdDetailView.backgroundColor = [UIColor whiteColor];
    }
    return _holdDetailView;
}

//- (UIView *)funcHeaderLine
//{
//    if (!_funcHeaderLine) {
//        _funcHeaderLine = [[UIView alloc]init];
//        _funcHeaderLine.backgroundColor = RGBColorAndAlpha(224, 224, 224, 1.0);
//    }
//    return _funcHeaderLine;
//}

- (UIView *)funcBottomLine
{
    if (!_funcBottomLine) {
        _funcBottomLine = [[UIView alloc]init];
        _funcBottomLine.backgroundColor = RGBColorAndAlpha(247, 247, 247, 1.0);
    }
    return _funcBottomLine;
}

- (UIView *)functionView
{
    if (!_functionView) {
        _functionView = [[UIView alloc]init];
        _functionView.userInteractionEnabled = YES;
        _functionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _functionView;
}

- (UIScrollView *)holdFuncImgViewScrollView
{
    if (!_holdFuncImgViewScrollView) {
        _holdFuncImgViewScrollView = [[UIScrollView alloc]init];
        _holdFuncImgViewScrollView.bounces = NO;
        _holdFuncImgViewScrollView.scrollEnabled = NO;
        _holdFuncImgViewScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _holdFuncImgViewScrollView;
}

- (UIView *)secondContainerView
{
    if (!_secondContainerView) {
        _secondContainerView = [[UIView alloc]init];
        _secondContainerView.backgroundColor = [UIColor whiteColor];
    }
    return _secondContainerView;
}

- (UIImageView *)functionImgView
{
    if (!_functionImgView) {
        _functionImgView = [[UIImageView alloc]init];
        
        NSString *dir = [NSString documentDirectoryPathWithFileName:@"function"];
        NSString *searialPath = [dir stringByAppendingPathComponent:self.chair.serial];
        NSString *functionImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_function_material.jpg", self.chair.nameen]];
        
        _functionImgView.image = [UIImage imageCompressForWidth:[UIImage imageWithContentsOfFile:functionImagePath] targetWidth:SCREEN_WIDTH];//[UIImage imageWithContentsOfFile:path];
        
    }
    return _functionImgView;
}

- (UIImageView *)detailImgView
{
    if (!_detailImgView) {
        _detailImgView = [[UIImageView alloc]init];
        _detailImgView.backgroundColor = [UIColor whiteColor];
        
        NSString *dir = [NSString documentDirectoryPathWithFileName:@"details"];
        NSString *searialPath = [dir stringByAppendingPathComponent:self.chair.serial];
        NSString *detailImagePath = [searialPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_detail_0.jpg", self.chair.nameen]];
        Log(@"......detail:%@", detailImagePath);
        
//        detailImagePath = @"/var/mobile/Containers/Data/Application/BF96BF6B-A78F-4A7B-9152-F1C3FE097446/Documents/details/金豪+/EHPL-AB-LBM-F_detail_0.jpg";
        
        _detailImgView.image = [UIImage imageCompressForSize:[UIImage imageWithContentsOfFile:detailImagePath] targetSize:CGSizeMake(SCREEN_WIDTH, 370)];
        
        Log(@"......%d", [[NSFileManager defaultManager]fileExistsAtPath:searialPath]);
        
    }
    return _detailImgView;
}

- (UIView *)holdFunctionBtnView
{
    if (!_holdFunctionBtnView) {
        _holdFunctionBtnView = [[UIView alloc]init];
    }
    return _holdFunctionBtnView;
}

- (UIView *)holdFunctionTitleView
{
    if (!_holdFunctionTitleView) {
        _holdFunctionTitleView = [[UIView alloc]init];
    }
    return _holdFunctionTitleView;
}

- (UIButton *)materialBtn
{
    if (!_materialBtn) {
        _materialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _materialBtn.tag = DetailButtonType_Func_Material;
        _materialBtn.selected = YES;
//        _materialBtn.functionImage = [UIImage imageNamed:@"detailMaterial"];
//        _materialBtn.functionSelectedImage = [UIImage imageNamed:@"detailMaterialSel"];
//        _materialBtn.functionTitle = @"材质说明";
        [_materialBtn setImage:[UIImage imageNamed:@"detailMaterial"] forState:UIControlStateNormal];
        [_materialBtn setImage:[UIImage imageNamed:@"detailMaterialSel"] forState:UIControlStateSelected];
        
        [_materialBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _materialBtn;
}

- (UIButton *)humanBtn
{
    if (!_humanBtn) {
        _humanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _humanBtn.tag = DetailButtonType_Func_Human;
//        _humanBtn.functionImage = [UIImage imageNamed:@"detailHuman"];
//        _humanBtn.functionSelectedImage = [UIImage imageNamed:@"detailHumanSel"];
//        _humanBtn.functionTitle = @"人性工学";
        
        [_humanBtn setImage:[UIImage imageNamed:@"detailHuman"] forState:UIControlStateNormal];
        [_humanBtn setImage:[UIImage imageNamed:@"detailHumanSel"] forState:UIControlStateSelected];
        
        [_humanBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _humanBtn;
}

- (UIButton *)functionIntroBtn
{
    if (!_functionIntroBtn) {
        _functionIntroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _functionIntroBtn.tag = DetailButtonType_Func_FuncIntroduction;
//        _functionIntroBtn.functionImage = [UIImage imageNamed:@"detailFuncIntro"];
//        _functionIntroBtn.functionSelectedImage = [UIImage imageNamed:@"detailFuncIntroSel"];
//        _functionIntroBtn.functionTitle = @"功能介绍";
        
        [_functionIntroBtn setImage:[UIImage imageNamed:@"detailFuncIntro"] forState:UIControlStateNormal];
        [_functionIntroBtn setImage:[UIImage imageNamed:@"detailFuncIntroSel"] forState:UIControlStateSelected];
        
        [_functionIntroBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _functionIntroBtn;
}

- (UIButton *)productFeaturesBtn
{
    if (!_productFeaturesBtn) {
        _productFeaturesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _productFeaturesBtn.tag = DetailButtonType_Func_ProductFeature;
//        _productFeaturesBtn.functionImage = [UIImage imageNamed:@"detailProductFeature"];
//        _productFeaturesBtn.functionSelectedImage = [UIImage imageNamed:@"detailProductFeatureSel"];
        [_productFeaturesBtn setImage:[UIImage imageNamed:@"detailProductFeature"] forState:UIControlStateNormal];
        [_productFeaturesBtn setImage:[UIImage imageNamed:@"detailProductFeatureSel"] forState:UIControlStateSelected];
        
//        _productFeaturesBtn.functionTitle = @"产品特点";
        [_productFeaturesBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productFeaturesBtn;
}

- (UIButton *)sizeBtn
{
    if (!_sizeBtn) {
        _sizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sizeBtn.tag = DetailButtonType_Func_Size;
//        _sizeBtn.functionImage = [UIImage imageNamed:@"detailSize"];
//        _sizeBtn.functionSelectedImage = [UIImage imageNamed:@"detailSizeSel"];
        [_sizeBtn setImage:[UIImage imageNamed:@"detailSize"] forState:UIControlStateNormal];
        [_sizeBtn setImage:[UIImage imageNamed:@"detailSizeSel"] forState:UIControlStateSelected];
        
        
//        _sizeBtn.functionTitle = @"尺寸范围";
        [_sizeBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sizeBtn;
}

- (UIButton *)productCertificationBtn
{
    if (!_productCertificationBtn) {
        _productCertificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _productCertificationBtn.tag = DetailButtonType_Func_ProductCertification;
//        _productCertificationBtn.functionImage = [UIImage imageNamed:@"detailProductCer"];
//        _productCertificationBtn.functionSelectedImage = [UIImage imageNamed:@"detailProductCerSel"];
        [_productCertificationBtn setImage:[UIImage imageNamed:@"detailProductCer"] forState:UIControlStateNormal];
        [_productCertificationBtn setImage:[UIImage imageNamed:@"detailProductCerSel"] forState:UIControlStateSelected];
        
//        _productCertificationBtn.functionTitle = @"产品认证";
        [_productCertificationBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productCertificationBtn;
}

- (UILabel *)materialLabel
{
    if (!_materialLabel) {
        _materialLabel = [[UILabel alloc]init];
        _materialLabel.textAlignment = NSTextAlignmentCenter;
        _materialLabel.textColor = kDetailNormalColor;
        _materialLabel.font = kDetailNormalFont;
        _materialLabel.text = @"材质说明";
    }
    return _materialLabel;
}

- (UILabel *)humanLabel
{
    if (!_humanLabel) {
        _humanLabel = [[UILabel alloc]init];
        _humanLabel.textAlignment = NSTextAlignmentCenter;
        _humanLabel.textColor = kDetailNormalColor;
        _humanLabel.font = kDetailNormalFont;
        _humanLabel.text = @"人性工学";
    }
    return _humanLabel;
}

- (UILabel *)functionIntroLabel
{
    if (!_functionIntroLabel) {
        _functionIntroLabel = [[UILabel alloc]init];
        _functionIntroLabel.textAlignment = NSTextAlignmentCenter;
        _functionIntroLabel.textColor = kDetailNormalColor;
        _functionIntroLabel.font = kDetailNormalFont;
        _functionIntroLabel.text = @"功能介绍";
    }
    return _functionIntroLabel;
}

- (UILabel *)productFeaturesLabel
{
    if (!_productFeaturesLabel) {
        _productFeaturesLabel = [[UILabel alloc]init];
        _productFeaturesLabel.textAlignment = NSTextAlignmentCenter;
        _productFeaturesLabel.textColor = kDetailNormalColor;
        _productFeaturesLabel.font = kDetailNormalFont;
        _productFeaturesLabel.text = @"产品特点";
    }
    return _productFeaturesLabel;
}

- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.textAlignment = NSTextAlignmentCenter;
        _sizeLabel.textColor = kDetailNormalColor;
        _sizeLabel.font = kDetailNormalFont;
        _sizeLabel.text = @"尺寸图";
    }
    return _sizeLabel;
}

- (UILabel *)productCertificationLabel
{
    if (!_productCertificationLabel) {
        _productCertificationLabel = [[UILabel alloc]init];
        _productCertificationLabel.textAlignment = NSTextAlignmentCenter;
        _productCertificationLabel.textColor = kDetailNormalColor;
        _productCertificationLabel.font = kDetailNormalFont;
        _productCertificationLabel.text = @"产品认证";
    }
    return _productCertificationLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = self.chair.namech;
        _nameLabel.font = [UIFont systemFontOfSize:23];
        _nameLabel.textColor = RGBColorAndAlpha(51, 51, 51, 1.0);
    }
    return _nameLabel;
}

- (UILabel *)originPriceLabel
{
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc]init];
        _originPriceLabel.text = [NSString stringWithFormat:@"市场价 ￥%.f", self.chair.price];
        _originPriceLabel.textColor = RGBColorAndAlpha(161, 161, 161, 1.0);
        _originPriceLabel.font = [UIFont systemFontOfSize:15];
        
        [_originPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_originPriceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _originPriceLabel;
}

- (UILabel *)discountPriceLabel
{
    if (!_discountPriceLabel) {
        _discountPriceLabel = [[UILabel alloc]init];
        
        CGFloat price = 0;
        NSString *vip = [[NSUserDefaults standardUserDefaults]valueForKey:Role];
        if ([vip isEqualToString:@"1"]) {
            price = self.chair.discount35_price;
        } else if ([vip isEqualToString:@"2"]) {
            price = self.chair.discount3_price;
        }
        
        _discountPriceLabel.text = [NSString stringWithFormat:@"折后价格￥%.f",price];
        
        _discountPriceLabel.textColor = RGBColorAndAlpha(237, 168, 33, 1.0);
        _discountPriceLabel.font = [UIFont systemFontOfSize:23];
        
        [_discountPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_discountPriceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _discountPriceLabel;
}

@end