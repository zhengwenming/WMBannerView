//
//  WMBannerView.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "WMBannerView.h"

@interface WMBannerView ()
//容器
@property(nonatomic,strong)UIScrollView     *scrollView;
/* 滚动圆点 **/
@property(nonatomic,strong)UIPageControl    *pageControl;
/* 定时器 **/
@property(nonatomic,strong)NSTimer          *animationTimer;
/* 当前index **/
@property(nonatomic,assign)NSInteger        currentPageIndex;
/* 所有的图片数组 **/
@property(nonatomic,strong)NSMutableArray   *imageArray;
/* 当前图片数组，永远只存储三张图 **/
@property(nonatomic,strong)NSMutableArray   *currentArray;
/* block方式接收回调 */
@property(nonatomic,copy)TapActionBlock block;
@end

@implementation WMBannerView

-(instancetype)initWithFrame:(CGRect)frame withURLArrayOrImagesArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = dataArray;
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 *frame.size.width, frame.size.height);
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        //设置分页显示的圆点
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.alpha = 0.8;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        //点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tapGesture];
        
        //默认五秒钟循环播放
        self.animationDuration = 5;
        //默认居中
        self.pageContolAliment = WMPageContolAlignmentCenter;
        //默认第一张
        self.currentPageIndex = 0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}


-(void)setPageContolAliment:(WMPageContolAlignment)pageContolAliment{
    _pageControlAlignment = pageContolAliment;
    _pageControl.hidden = NO;
    switch (pageContolAliment) {
        case WMPageContolAlignmentCenter:
        {
            _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.scrollView.frame) - 20, CGRectGetWidth(self.scrollView.frame), 10);
        }
            break;
        case WMPageContolAlignmentRight:
        {
            CGSize size = CGSizeMake(self.dataArray.count * 10 * 1.2, 10);
            CGFloat x = self.scrollView.frame.size.width - size.width - 10;
            CGFloat y = self.scrollView.frame.size.height - 20;
            _pageControl.frame = CGRectMake(x, y, size.width, size.height);
        }
            break;
        case WMPageContolAlignmentNone:
            _pageControl.hidden = YES;
            break;
            
        default:
            break;
    }
}


-(void)setAnimationDuration:(NSTimeInterval)animationDuration{
    _animationDuration = animationDuration;
    
    [self.animationTimer invalidate];
    self.animationTimer = nil;
    
    if (animationDuration <= 0) {
        return;
    }
    
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration
                                                           target:self
                                                         selector:@selector(animationTimerDidFired:)
                                                         userInfo:nil
                                                          repeats:YES];
    
    [self.animationTimer setFireDate:[NSDate distantFuture]];
}

-(void)downLoadImage{
    if (self.dataArray && self.dataArray.count > 0) {
        if ([self.dataArray.firstObject respondsToSelector:@selector(hasPrefix:)]) {
            if ([self.dataArray.firstObject hasPrefix:@"http"]) {//网络图片
                self.imageArray = [NSMutableArray array];
                __weak typeof(self) weak = self;
                [self.dataArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.scrollView.frame];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:self.placeHoldImage];
                    [weak.imageArray addObject:imageView];
                }];
                _pageControl.numberOfPages = self.dataArray.count;
                [self configContentViews];
                
            }
        }
        else{//本地图片
            self.imageArray = [NSMutableArray array];
            __weak typeof(self) weak = self;
            [self.dataArray enumerateObjectsUsingBlock:^(UIImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.scrollView.frame];
                imageView.image = obj;
                [weak.imageArray addObject:imageView];
            }];
            _pageControl.numberOfPages = self.dataArray.count;
            [self configContentViews];
        }
    }
}

#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:_currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:_currentPageIndex + 1];
    
    self.currentArray = (_currentArray?:[NSMutableArray new]);
    
    _currentArray.count == 0 ?:[_currentArray removeAllObjects];
    
    if (_imageArray) {
        if (_imageArray.count >= 3) {
            [_currentArray addObject:_imageArray[previousPageIndex]];
            [_currentArray addObject:_imageArray[_currentPageIndex]];
            [_currentArray addObject:_imageArray[rearPageIndex]];
        }
        else{
            [self getImageFromArray:_imageArray[previousPageIndex]];
            [self getImageFromArray:_imageArray[_currentPageIndex]];
            [self getImageFromArray:_imageArray[rearPageIndex]];
        }
    }
    
    [_currentArray enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.userInteractionEnabled = YES;
        CGRect rightRect = obj.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.frame) * idx, 0);
        obj.frame = rightRect;
        [self.scrollView addSubview:obj];
    }];
    
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0)];
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1){
        return self.dataArray.count - 1;
    }
    else if (currentPageIndex == self.dataArray.count){
        return 0;
    }
    else
        return currentPageIndex;
}

/**
 *  解决小于三个图片显示的bug
 *  @param imageView 原始图
 */
-(void)getImageFromArray:(UIImageView *)imageView{
    //开辟自动释放池
    @autoreleasepool {
        UIImageView *tempImage = [[UIImageView alloc]initWithFrame:imageView.frame];
        tempImage.image = imageView.image;
        [_currentArray addObject:tempImage];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.animationDuration]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        _pageControl.currentPage = _currentPageIndex;
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        _pageControl.currentPage = _currentPageIndex;
        [self configContentViews];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}


#pragma mark - 循环事件
- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

#pragma mark - 响应事件
- (void)tap
{
    if (self.block) {
        self.block(self.currentPageIndex);
    }
}


#pragma mark - 开始滚动
-(void)startWithTapActionBlock:(TapActionBlock)block{
    [self.animationTimer setFireDate:[NSDate date]];
    
    [self downLoadImage];
    
    self.block = block;
}
#pragma mark - 停止滚动
-(void)stop{
    [self.animationTimer invalidate];
}

- (void)dealloc
{
    self.animationTimer = nil;
    self.imageArray = nil;
    self.dataArray = nil;
    self.scrollView = nil;
}

@end
