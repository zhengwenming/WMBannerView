//
//  WMBannerView.h
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WMPageContolAlignment) {
    WMPageContolAlignmentCenter,  /**< 滚动点居中 */
    /*  */
    WMPageContolAlignmentRight,   /**< 滚动点居右 */
    /*  */
    WMPageContolAlignmentNone     /**< 滚动点隐藏 */
};

typedef void(^TapActionBlock)(NSInteger index);


@interface WMBannerView : UIView<UIScrollViewDelegate>


/* 播放周期,默认五秒钟 如设置0则不播放 */
@property(nonatomic,assign)NSTimeInterval animationDuration;
/* 滚动点对齐方式，默认居中 */
@property(nonatomic,assign)WMPageContolAlignment pageControlAlignment;

/* 默认图片，下载未完成时显示 网络图片的时候设置*/
/* 注意：赋值必须写在Start方法之前，否则仍然为nil */
@property(nonatomic,strong)UIImage *placeHoldImage;

/* 数据源 **/
@property(nonatomic,copy)NSArray *dataArray;


/**
 *  初始化广告播放滚动View
 *
 *  @param rect       尺寸位置
 *  @param dataArray 图片数据源
 */
-(instancetype)initWithFrame:(CGRect)frame withURLArrayOrImagesArray:(NSArray *)dataArray;
/**
 *  开始播放，默认五秒钟,点击响应block回调
 *
 *  @param block 回调，返回当前图片index，不需要回调则设置为nil
 */
- (void)startWithTapActionBlock:(TapActionBlock)block;

/**
 *  停止播放
 */
- (void)stop;
@end
