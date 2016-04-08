


//
//  WMBannerModel.m
//  Banner
//
//  Created by 郑文明 on 16/4/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "WMBannerModel.h"

@implementation WMBannerModel
- (id)initWithURLOrImage:(NSString *)URLOrImage title:(NSString *)title
{
    if(self = [super init])
    {
        self.URLOrImage = URLOrImage;
        self.title = title;
    }
    return self;
}

+ (id)wmBannerModelWithURLOrImage:(NSString *)URLOrImage title:(NSString *)title
{
    WMBannerModel *model = [[WMBannerModel alloc] initWithURLOrImage:URLOrImage title:title];
    return model;
}

+ (id)wmBannerModelWithURLOrImage:(NSString *)URLOrImage
{
    WMBannerModel *model = [[WMBannerModel alloc] initWithURLOrImage:URLOrImage title:nil];
    return model;
}
@end
