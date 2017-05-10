
#import "MenuScrollView.h"
#import "BPMenuScrollButton.h"

//#import "UIImage+Category.h" 

//#define AppendButtonWidth 280
@interface MenuScrollView()

@property (nonatomic, assign) CGFloat menuItemWidth;
@property (nonatomic, retain) UIView *directionView;

@end


@implementation MenuScrollView

//创建主视图
-(id)initWithFrame:(CGRect)frame andButtonItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    if (self)
    {
        
        if (!_mButtons) {
            _mButtons = [NSMutableArray new];
        }
        if (!_mScrollerView)
        {
            _mScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [self addSubview:_mScrollerView];
            _mScrollerView.bounces = NO;
            _mScrollerView.showsHorizontalScrollIndicator = NO;
        }
        
        [self.mScrollerView addSubview:self.directionView];
        
        if (!_ItemsInfo)
        {
            _ItemsInfo = [NSMutableArray new];
        }
        [_ItemsInfo removeAllObjects];
        [self createMenuItems:items];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andButtonItems:(NSArray *)items andImages:(NSArray *)images
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    if (self)
    {
        [self.mImages removeAllObjects];
        [self.mImages addObjectsFromArray:images];
        
        if (!_mButtons) {
            _mButtons = [NSMutableArray new];
        }
        if (!_mScrollerView)
        {
            _mScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [self addSubview:_mScrollerView];
            _mScrollerView.bounces = NO;
            _mScrollerView.showsHorizontalScrollIndicator = NO;
        }
        
        [self.mScrollerView addSubview:self.directionView];
        
        if (!_ItemsInfo)
        {
            _ItemsInfo = [NSMutableArray new];
        }
        [_ItemsInfo removeAllObjects];
        [self createMenuItems:items];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    if (self)
    {
        [self.mImages removeAllObjects];
        [self.mImages addObjectsFromArray:images];
        
        if (!_mButtons) {
            _mButtons = [NSMutableArray new];
        }
        if (!_mScrollerView)
        {
            _mScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [self addSubview:_mScrollerView];
            _mScrollerView.bounces = NO;
            _mScrollerView.showsHorizontalScrollIndicator = NO;
        }
        
        [self.mScrollerView addSubview:self.directionView];
        
        if (!_ItemsInfo)
        {
            _ItemsInfo = [NSMutableArray new];
        }
        [_ItemsInfo removeAllObjects];
        [self createMenuImages:images];
    }
    
    return self;
}

//往主视图添加按钮
-(void)createMenuItems:(NSArray *)Items
{
    int i = 0;
    float menuWidth = 0.0f;
//    CGFloat lineWidth = 0.5; // 分割线的宽度
//    CGFloat lineHeight = CGRectGetHeight(self.frame) / 3 * 2; // 分割线的高度
    
    if (Items.count != self.mImages.count) {
        Log(@"...图片文字不匹配");
        return;
    }
    
    for (int j = 0; j < Items.count; j++)
    {
        NSString *title = [Items objectAtIndex:j];
        NSString *imageName = [self.mImages objectAtIndex:j];
        
        Log(@"..title:%@, image:%@", title, imageName);
        
        CGFloat buttonwidth;
        
        buttonwidth = CGRectGetWidth(self.mScrollerView.frame) / 5;
        
        self.menuItemWidth = buttonwidth;
        
        //添加 button
        BPMenuScrollButton * button = [BPMenuScrollButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(menuWidth, 0, buttonwidth, CGRectGetHeight(self.frame))];
        
        /*
//        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor]}] forState:UIControlStateNormal];
//        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor]}] forState:UIControlStateSelected];
        */
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
        
        button.tag = i;
        [button addTarget:self action:@selector(clickmenuButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0)
        {
            button.selected = YES;
            self.directionView.frame = CGRectMake(0, CGRectGetHeight(button.frame) - 3, CGRectGetWidth(button.frame), 3);
        }
        
        // 添加分隔线
        /*
        if (i != 0) {
            
            UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(menuWidth - lineWidth, (CGRectGetHeight(self.frame) - lineHeight) / 2, lineWidth, lineHeight)];
            separateLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
            [self.mScrollerView addSubview:separateLine];
        }
        */
        
        //添加视图
        [self.mScrollerView addSubview:button];
        [self.mButtons addObject:button];
        
        menuWidth += buttonwidth;
        i++;
    }
    
    _mScrollerView.contentSize = CGSizeMake(menuWidth, 0);
    
    totalWidth = menuWidth;
}

// 只有图片
-(void)createMenuImages:(NSArray *)images
{
    int i = 0;
    float menuWidth = 0.0f;
    
    for (int j = 0; j < images.count; j++)
    {
        NSString *imageName = [self.mImages objectAtIndex:j];
        
        Log(@"..image:%@", imageName);
        
        CGFloat buttonwidth;
        
        buttonwidth = CGRectGetWidth(self.mScrollerView.frame) / 5;
        
        self.menuItemWidth = buttonwidth;
        
        //添加 button
        BPMenuScrollButton * button = [BPMenuScrollButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(menuWidth, 0, buttonwidth, CGRectGetHeight(self.frame))];
        
        /*
         //        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor]}] forState:UIControlStateNormal];
         //        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor]}] forState:UIControlStateSelected];
         */
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        button.tag = i;
        [button addTarget:self action:@selector(clickmenuButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0)
        {
            button.selected = YES;
            self.directionView.frame = CGRectMake(0, CGRectGetHeight(button.frame) - 3, CGRectGetWidth(button.frame), 3);
        }
        
        //添加视图
        [self.mScrollerView addSubview:button];
        [self.mButtons addObject:button];
        
        menuWidth += buttonwidth;
        i++;
    }
    
    _mScrollerView.contentSize = CGSizeMake(menuWidth, 0);
    
    totalWidth = menuWidth;
}

//取消 button 选中状态
-(void)buttonsToNomalState
{
    for (BPMenuScrollButton * btn in _mButtons)
    {
        btn.selected = NO;
    }
}

-(void)clickmenuButton:(BPMenuScrollButton *)sender
{
    [self changeButtonStateAtIndex:sender.tag];
    if ([self.delegate respondsToSelector:@selector(didMenuScrollViewClickedAtIndex:)])
    {
        [self.delegate didMenuScrollViewClickedAtIndex:sender.tag];
    }
}

//改变 button 选中状态
-(void)changeButtonStateAtIndex:(NSInteger)index
{
    BPMenuScrollButton * button = [_mButtons objectAtIndex:index];
    [self buttonsToNomalState];
    button.selected = YES;
    [self moveScrollViewWithIndex:index];
}

//移动 button 到可视区域
-(void)moveScrollViewWithIndex:(NSInteger)index
{
    if (totalWidth < CGRectGetWidth(_mScrollerView.frame))
    {
        return;
    }
    BPMenuScrollButton * btn = [_mButtons objectAtIndex:index];
    float btnOrigin = CGRectGetMinX(btn.frame);
    float scrollwidth = CGRectGetWidth(_mScrollerView.frame);
    
    if (btnOrigin - self.menuItemWidth / 2 > _mScrollerView.contentOffset.x)
    {
        //当 scrollview 未到尽头时
        if (btnOrigin - self.menuItemWidth + scrollwidth < totalWidth)
        {
            [UIView animateWithDuration:0.3 animations:^{
                _mScrollerView.contentOffset = CGPointMake(btnOrigin - self.menuItemWidth, 0);
                float y = self.directionView.center.y;
                self.directionView.center = CGPointMake(btn.center.x, y);
            }];
            
        }
        //当 scrollview 到尽头时
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                 _mScrollerView.contentOffset = CGPointMake(totalWidth - scrollwidth, 0);
                float y = self.directionView.center.y;
                self.directionView.center = CGPointMake(btn.center.x, y);

            }];
           
        }
    }
    else
    {
        if (btnOrigin - self.menuItemWidth / 2 > 0) {
            [UIView animateWithDuration:0.3 animations:^{
                _mScrollerView.contentOffset = CGPointMake(btnOrigin - self.menuItemWidth, 0);
                float y = self.directionView.center.y;
                self.directionView.center = CGPointMake(btn.center.x, y);

            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                _mScrollerView.contentOffset = CGPointMake(0, 0);
                float y = self.directionView.center.y;
                self.directionView.center = CGPointMake(btn.center.x, y);

            }];
        }
    }
}

//选择指定 button
-(void)selectAtIndex:(NSInteger)index
{
    BPMenuScrollButton * btn = [_mButtons objectAtIndex:index];
    [self clickmenuButton:btn];
}

- (UIView *)directionView
{
    if (!_directionView) {
        _directionView = [[UIView alloc]init];
        _directionView.backgroundColor = RGBColorAndAlpha(89, 177, 277, 1.0);
    }
    return _directionView;
}

- (NSMutableArray *)mImages
{
    if (!_mImages) {
        _mImages = [NSMutableArray array];
    }
    return _mImages;
}

@end