//
//  DCPicScrollView.m
//  DCPicScrollView
//
//  Created by dengchen on 15/12/4.
//  Copyright © 2015年 name. All rights reserved.
//

#define pageSize 16
#define myWidth self.frame.size.width
#define myHeight self.frame.size.height
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"

@interface DCPicScrollView () <UIScrollViewDelegate>

@property (nonatomic,copy) NSArray *imageData;

@end

@implementation DCPicScrollView{
    
    __weak  UIImageView *_leftImageView,*_centerImageView,*_rightImageView;
    
    __weak  UILabel *_leftLabel,*_centerLabel,*_rightLabel;
    
    __weak  UIScrollView *_scrollView;

    __weak  UIPageControl *_PageControl;
    
    NSTimer *_timer;
    
    NSInteger _currentIndex;
    
    NSInteger _MaxImageCount;
    
    BOOL _isNetwork;
    
    BOOL _hasTitle;
}

- (instancetype)initWithFrame:(CGRect)frame WithImageNames:(NSArray<NSString *> *)ImageName {
    if (ImageName.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    
    [self prepareScrollView];
    [self setImageData:ImageName];
    [self setMaxImageCount:_imageData.count];
    
    return self;
}

#pragma mark prepareScrollView
- (void)prepareScrollView {
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:sc];
    
    _scrollView = sc;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.clipsToBounds = NO;
//    _scrollView.bounces = NO;
    
    
    _scrollView.contentSize = CGSizeMake(myWidth * 3,0);
    
    _AutoScrollDelay = 2.0f;
    _currentIndex = 0;
}

#pragma mark setImageData:
- (void)setImageData:(NSArray *)ImageNames {
    
    _isNetwork = [ImageNames.firstObject hasPrefix:@"http://"];
    
    if (_isNetwork) {
        
        _imageData = [ImageNames copy];
        
        [self getImage];
        
    }else {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:ImageNames.count];
        
        for (NSString *name in ImageNames) {
//            [temp addObject:[UIImage imageNamed:name]];
            [temp addObject:[UIImage imageWithContentsOfFile:name]];
        }
        
        _imageData = [temp copy];
    }
}

#pragma mark setMaxImageCount:
- (void)setMaxImageCount:(NSInteger)MaxImageCount {
    _MaxImageCount = MaxImageCount;
    
    [self prepareImageView];
    [self preparePageControl];
    
    [self setUpTimer];
    
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

#pragma mark prepareImageView
- (void)prepareImageView {
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,myWidth, myHeight)];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth, 0,myWidth, myHeight)];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth * 2, 0,myWidth, myHeight)];
    
    center.userInteractionEnabled = YES;
    [center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:left];
    [_scrollView addSubview:center];
    [_scrollView addSubview:right];
    
    _leftImageView = left;
    _centerImageView = center;
    _rightImageView = right;
    
}

#pragma mark preparePageControl
- (void)preparePageControl {
    
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0,myHeight - pageSize,myWidth, 7)];
    
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor =  [UIColor redColor];
    page.numberOfPages = _MaxImageCount;
    page.currentPage = 0;
    [self addSubview:page];
    
    _PageControl = page;
}

#pragma mark setUpTimer
- (void)setUpTimer {
    
    if (_AutoScrollDelay < 0.5) return;
    
    _timer = [NSTimer timerWithTimeInterval:_AutoScrollDelay target:self selector:@selector(scorll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark changeImageLeft:center:right:
- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex {
    
    if (_isNetwork) {
        
        _leftImageView.image = [self setImageWithIndex:LeftIndex];
        _centerImageView.image = [self setImageWithIndex:centerIndex];
        _rightImageView.image = [self setImageWithIndex:rightIndex];
        
    }else {
        
        _leftImageView.image = _imageData[LeftIndex];
        _centerImageView.image = _imageData[centerIndex];
        _rightImageView.image = _imageData[rightIndex];
        
    }
    
    if (_hasTitle) {
        
        _leftLabel.text = _titleData[LeftIndex];
        _centerLabel.text = _titleData[centerIndex];
        _rightLabel.text = _titleData[rightIndex];
        
    }
    [_scrollView setContentOffset:CGPointMake(myWidth, 0)];
}

#pragma mark imageViewDidTap
- (void)imageViewDidTap {
    if (self.imageViewDidTapAtIndex != nil) {
        self.imageViewDidTapAtIndex(_currentIndex);
    }
}

#pragma mark setTitleData:
- (void)setTitleData:(NSArray<NSString *> *)titleData {
    if (titleData.count < 2)  return;
    
    if (titleData.count < _imageData.count) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:titleData];
        for (int i = 0; i < _imageData.count - titleData.count; i++) {
            [temp addObject:@""];
        }
        _titleData = [temp copy];
    }else {
        
        _titleData = [titleData copy];
    }
    
    [self prepareTitleLabel];
    _hasTitle = YES;
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

#pragma mark prepareTitleLabel
- (void)prepareTitleLabel {
    
    [self setStyle:PageControlAtRight];

   UIView *left = [self creatLabelBgView];
   UIView *center = [self creatLabelBgView];
   UIView *right = [self creatLabelBgView];
    
    _leftLabel = (UILabel *)left.subviews.firstObject;
    _centerLabel = (UILabel *)center.subviews.firstObject;
    _rightLabel = (UILabel *)right.subviews.firstObject;

    [_leftImageView addSubview:left];
    [_centerImageView addSubview:center];
    [_rightImageView addSubview:right];
    

}

#pragma mark creatLabelBgView
- (UIView *)creatLabelBgView {
    CGFloat h = 25;
    
    if (myHeight * 0.1 > 25) {
        h = myHeight * 0.1;
    }
    
   UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, myHeight-h, myWidth, h)];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, myWidth-_PageControl.frame.size.width,h)];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:h*0.5];
    
    [v addSubview:label];
    
    return v;
}


- (void)setStyle:(PageControlStyle)style {
    if (style == PageControlAtRight) {
        CGFloat w = _MaxImageCount * pageSize;
        _PageControl.frame = CGRectMake(myWidth - w,myHeight-pageSize,w, 7);
    } else if (style ==PageControlNone) {
        _PageControl.hidden = YES;
    }
}

#pragma mark scrollViewDelegate
#pragma mark scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.x];
}

- (void)changeImageWithOffset:(CGFloat)offsetX {

    if (offsetX >= myWidth * 2) {
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount-1) {
            
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _MaxImageCount) {
            
            _currentIndex = 0;
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        _PageControl.currentPage = _currentIndex;
        
    }
    
    if (offsetX <= 0) {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxImageCount-1;
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        _PageControl.currentPage = _currentIndex;
    }
}



-(void)setPlaceImage:(UIImage *)placeImage {
    _placeImage = placeImage;
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

- (UIImage *)setImageWithIndex:(NSInteger)index {
    
    //从内存缓存中取,如果没有使用占位图片
    UIImage *image = [[[DCWebImageManager shareManager] webImageCache] valueForKey:_imageData[index]];
    if (image) {
        return image;
    }else {
        return _placeImage;
    }
}

#pragma mark scroll
- (void)scorll {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + myWidth, 0) animated:YES];
}

#pragma mark setAutoScrollDelay:
- (void)setAutoScrollDelay:(NSTimeInterval)AutoScrollDelay {
    _AutoScrollDelay = AutoScrollDelay;
    [self removeTimer];
    [self setUpTimer];
}



#pragma mark removeTimer
- (void)removeTimer {
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}



#pragma mark getImage
- (void)getImage {
    
    for (NSString *urlSting in _imageData) {
        [[DCWebImageManager shareManager] downloadImageWithUrlString:urlSting];
    }
    
}

-(void)dealloc {
    [self removeTimer];
}

@end
