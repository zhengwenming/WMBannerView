//
//  WMBannerView.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "WMBannerView.h"
@interface WMBannerView (){
    NSTimer *_timer;
    NSTimeInterval _second;
}
@end

@implementation WMBannerView


+ (instancetype)wmBannerViewWithFrame:(CGRect)frame
                    autoPlayWithDelay:(NSTimeInterval)second
                          modelsArray:(NSArray *)modelsArray
                 placeholderImageName:(NSString *)placeholderImageName
                imageViewsContentMode:(UIViewContentMode)imageViewsContentMode
                      clickedCallBack:(void (^)(int clickedIndex))clickedCallBack
                     scrolledCallBack:(void(^)(int scrolledIndex))scrolledCallBack
{
    WMBannerView *coverView = [[WMBannerView alloc] initWithFrame:frame];
    coverView.models = modelsArray;
    coverView.placeholderImageName = placeholderImageName;
    coverView.imageViewContentMode = imageViewsContentMode;
    coverView.clickedCallBack = clickedCallBack;
    coverView.scrolledCallBack = scrolledCallBack;
    
   
    if (second==0) { //不自动滚动，手动滚动

    }else{//second秒自动滚动，
        [coverView setAutoPlayWithDelay:second];
    }
    [coverView updateView];
    return coverView;
}



-(instancetype)initWithFrame:(CGRect)frame
           autoPlayWithDelay:(NSTimeInterval)second
                 modelsArray:(NSArray *)modelsArray
        placeholderImageName:(NSString *)placeholderImageName
       imageViewContentModel:(UIViewContentMode)imageViewContentMode
             clickedCallBack:(void(^)(int clickedIndex))clickedCallBack
            scrolledCallBack:(void(^)(int scrolledIndex))scrolledCallBack{
    if (self = [super initWithFrame:frame])
    {
        self.frame = frame;
        self.models = modelsArray;
        self.placeholderImageName = placeholderImageName;
        self.imageViewContentMode = imageViewContentMode;
        self.clickedCallBack = clickedCallBack;
        self.scrolledCallBack = scrolledCallBack;
        
        [self createUI];
        //设置默认2s滚动一次
        if (second==0) { //不自动滚动，手动滚动

            
        }else{//second秒自动滚动，
            [self setAutoPlayWithDelay:second];
        }
        [self updateView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}

// 创建UI
- (void)createUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor blackColor];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100/2, self.frame.size.height-45, 100,15)];
    _pageControl.userInteractionEnabled = YES;
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    
    _pageControl.layer.cornerRadius=8;
    [self addSubview:_pageControl];
}

// 更新视图
- (void)updateView
{
    if(_modelsArray.count <= 1)
    {
        [self.pageControl setHidden:YES];
        _scrollView.scrollEnabled = NO;
    }
    else
    {
        [self.pageControl setHidden:NO];
        _scrollView.scrollEnabled = YES;
    }
    
    _scrollView.contentSize = CGSizeMake((_modelsArray.count+2)*_scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    // 清除所有滚动视图
    for (UIView *view in _scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
    WMBannerModel *model = nil;
    for (int i = 0; i<_modelsArray.count+2; i++)
    {
        if (i == 0)
        {
            model = [_modelsArray lastObject];
        }
        else if(i == _modelsArray.count+1)
        {
            model = [_modelsArray firstObject];
        }
        else
        {
            model = [_modelsArray objectAtIndex:i-1];
        }
        
        // create imageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        
        
        
        
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = _imageViewContentMode;
        imageView.tag = i-1;
        
        // 默认执行SDWebImage的缓存方法
        
        if ([model.URLOrImage isKindOfClass:[NSString class]]) {
            if ([model.URLOrImage rangeOfString:@"http"].location !=NSNotFound) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.URLOrImage] placeholderImage:[UIImage imageNamed:_placeholderImageName]];
            }

        }else if([model.URLOrImage isKindOfClass:[UIImage class]]){
            imageView.image = (UIImage *)model.URLOrImage;
        }
        
        [_scrollView addSubview:imageView];
        
        if (model.title)
        {
            // create title label
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 20)];
            titleLabel.text = model.title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
            [imageView addSubview:titleLabel];
        }
        
        if (i>0 &&i<_modelsArray.count+1)
        {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
            [imageView addGestureRecognizer:tap];
        }
    }
    
    // 设置titleLabel和pageControl的相关内容数据
    if (_modelsArray.count>0)
    {
        _pageControl.numberOfPages = _modelsArray.count;
        [_pageControl addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventValueChanged];
    }
   
}

// 图片轻敲手势事件
- (void)imageViewClicked:(UITapGestureRecognizer *)recognizer
{
    int index = (int)recognizer.view.tag;
    if (_clickedCallBack) _clickedCallBack(index);
}

// pageControl修改事件
- (void)pageControlClicked:(UIPageControl *)pageControl
{
    [self scrollViewScrollToPageIndex:pageControl.currentPage+1];
}

// 设置自动播放
- (void)setAutoPlayWithDelay:(NSTimeInterval)second
{
    if ([_timer isValid])
    {
        [_timer invalidate];
    }
    
    _second = second;
    _timer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(scrollViewAutoScrolling) userInfo:nil repeats:YES];
}

// 自动滚动
- (void)scrollViewAutoScrolling
{
    CGPoint point;
    point = _scrollView.contentOffset;
    point.x += _scrollView.frame.size.width;
    
    [self animationScrollWithPoint:point];
}

// 滚动到指定的页面
- (void)scrollViewScrollToPageIndex:(NSInteger)page
{
    CGPoint point = CGPointMake(_scrollView.frame.size.width*page, 0);
    
    [self animationScrollWithPoint:point];
}

// 滚动到指点的point
- (void)animationScrollWithPoint:(CGPoint)point
{
    // 判断是否是需要动画
    if (_animationOption != UIViewAnimationOptionTransitionNone)
    {
        _scrollView.contentOffset = point;
        [self scrollViewDidEndDecelerating:_scrollView];
        [UIView transitionWithView:_scrollView duration:0.7 options:_animationOption animations:nil completion:nil];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = point;
        }completion:^(BOOL finished) {
            if (finished) {
                [self scrollViewDidEndDecelerating:_scrollView];
            }
        }];
    }
}


-(void)setScrolledCallBack:(void (^)(int))scrolledCallBack{
    _scrolledCallBack = [scrolledCallBack copy];
    if(_scrolledCallBack) _scrolledCallBack(0);
}


#pragma mark-
#pragma mark- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止自动播放
    if ([_timer isValid])
    {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 设置伪循环滚动
    if (scrollView.contentOffset.x <= 0)
    {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-2*scrollView.frame.size.width, 0);
        
    }
    else if(scrollView.contentOffset.x >= scrollView.contentSize.width-scrollView.frame.size.width)
    {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
    
    int currentPage = scrollView.contentOffset.x/self.frame.size.width-1;
    _pageControl.currentPage = currentPage;
    
    // 恢复自动播放
    if ([_timer isValid])
    {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_second]];
    }
    
    if (_scrolledCallBack) _scrolledCallBack(currentPage);
}

- (void)resetCoverView
{
    static BOOL flag = NO;
    if (flag)
    {
        CGPoint point = CGPointMake(_scrollView.frame.size.width, 0);
        _scrollView.contentOffset = point;
        [self scrollViewDidEndDecelerating:_scrollView];
    }
    
    flag = YES;
}

#pragma mark-
- (void)setModels:(NSArray *)models
{
    _modelsArray = models;
    [self updateView];
}

@end