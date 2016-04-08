//
//  WMBannerModel.h
//  Banner
//
//  Created by 郑文明 on 16/4/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMBannerModel : NSObject
/**
 *  WMBannerModel类，包含两个属性：
 *  图片地址或者UIImage对象(URLOrImage)和图片标题(imageTitle)
 */

/**
 *  图片地址或者UIImage对象（本地和网络图片同时支持）
 */
@property (nonatomic, retain) id URLOrImage;

/**
 *  图片标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  常规的创建WMBannerModel的方法
 *
 *  @param imageURLString 图片的路径字符串，可以是网络和本地路径
 *  @param imageTitle     图片的标题
 *  @warning    不推荐使用该方法
 *  @see        + wmBannerModelWithURLOrImage:
 *
 *  @return 返回WMBannerModel的对象指针
 */
- (id)initWithURLOrImage:(NSString *)URLOrImage title:(NSString *)title;

/**
 *  快速创建WMBannerModel的工厂方法
 *
 *  @param imageURLString 图片的路径字符串，可以是网络和本地路径
 *  @param imageTitle     图片的标题
 *
 *  @return 返回WMBannerModel的对象指针
 */
+ (id)wmBannerModelWithURLOrImage:(NSString *)URLOrImage title:(NSString *)title;

/**
 *  快速创建WMBannerModel的工厂方法
 *
 *  @param imageURLString 图片的路径字符串，可以是网络和本地路径
 *
 *  @return 返回WMBannerModel的对象指针
 */
+ (id)wmBannerModelWithURLOrImage:(NSString *)URLOrImage;

@end