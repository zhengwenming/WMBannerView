//
//  WMBannerView.h
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMBannerModel.h"

@interface WMBannerView : UIView<UIScrollViewDelegate>


@property (nonatomic, strong)  UIScrollView *scrollView;
@property (nonatomic, strong)  UIPageControl *pageControl;
@property (nonatomic, strong)  NSArray *modelsArray; // 一个包含WMBannerModel的数组
@property (nonatomic, copy)    NSString *placeholderImageName; // 占位图片名字
@property (nonatomic, copy)     void(^clickedCallBack)(int); // 点击的回调
@property (nonatomic, copy)     void(^scrolledCallBack)(int); // 滚动后的回调
@property (nonatomic, assign) UIViewAnimationOptions animationOption; // 动画选项（可选）
@property (nonatomic, assign) UIViewContentMode imageViewContentMode; // 图片的内容模式，默认为UIViewContentModeScaleToFill

/**
 *  创建WMBannerView的+方法
 *
 *  @param frame                    设置的frame
 *  @param autoPlayWithDelay        设置自动滚动的秒数second(默认2s)
 *  @param modelsArray              一个包含WMBannerModel的数组
 *  @param placeholderImageNamed    本地占位图片名
 *  @param imageViewsContentMode    图片的内容模式 UIViewContentMode
 *  @param clickedCallBack          点击后的回调
 *  @param scrolledCallBack         视图滚动后回调
 *
 *  @return 返回WMBannerView的对象
 */
+ (instancetype)wmBannerViewWithFrame:(CGRect)frame
                autoPlayWithDelay:(NSTimeInterval)second
                modelsArray:(NSArray *)modelsArray
                placeholderImageName:(NSString *)placeholderImageName
                imageViewsContentMode:(UIViewContentMode)imageViewsContentMode
                clickedCallBack:(void (^)(int clickedIndex))clickedCallBack
                scrolledCallBack:(void(^)(int scrolledIndex))scrolledCallBack;

/**
 *  创建WMBannerView的-方法
 *  @param frame                    设置的frame
 *  @param AutoPlayWithDelay        设置自动滚动的秒数second(默认2s)
 *  @param modelsArray              一个包含WMBannerModel的数组
 *  @param placeholderImageNamed    本地占位图片名
 *  @param imageViewsContentMode    图片的内容模式 UIViewContentMode
 *  @param clickedCallBack          点击后的回调
 *  @param scrolledCallBack         视图滚动后回调
 *
 *  @return 返回WMBannerView的对象
 */
-(instancetype)initWithFrame:(CGRect)frame
           autoPlayWithDelay:(NSTimeInterval)second
                modelsArray:(NSArray *)modelsArray
                placeholderImageName:(NSString *)placeholderImageName
                imageViewContentModel:(UIViewContentMode)imageViewContentMode
                clickedCallBack:(void(^)(int clickedIndex))clickedCallBack
                scrolledCallBack:(void(^)(int scrolledIndex))scrolledCallBack;
/**
 *  修改WMBannerView的参数后都要更新视图才能够正常使用
 */
- (void)updateView;

/**
 *  设置视图滚动到目标地址后滚动的回调事件
 *
 *  @param scrolledCallBack 设置滚动的回调事件
 */
- (void)setScrolledCallBack:(void (^)(int))scrolledCallBack;

/**
 *  设置点击回调的块
 *
 *  @param clickedCallBack 设置点击的回调事件
 */
- (void)setClickedCallBack:(void (^)(int))clickedCallBack;

/**
 *  设置自动播放
 *
 *  @param second 每隔多少秒滚动一次
 */
- (void)setAutoPlayWithDelay:(NSTimeInterval)second;


/**
 *  设置切换时的动画选项，不设置则默认为scrollView滚动动画
 *
 *  提供的动画类型有：
 *  - UIViewAnimationOptionTransitionNone
 *  - UIViewAnimationOptionTransitionFlipFromLeft
 *  - UIViewAnimationOptionTransitionFlipFromRight
 *  - UIViewAnimationOptionTransitionCurlUp
 *  - UIViewAnimationOptionTransitionCurlDown
 *  - UIViewAnimationOptionTransitionCrossDissolve
 *  - UIViewAnimationOptionTransitionFlipFromTop
 *  - UIViewAnimationOptionTransitionFlipFromBottom
 *  @param animationOption 系统内置的动画选项
 */
- (void)setAnimationOption:(UIViewAnimationOptions)animationOption;

/**
 *  此方法在delegate的viewWillAppear里面调用，用来重置BWMCoverView
 */
- (void)resetCoverView;

@end
