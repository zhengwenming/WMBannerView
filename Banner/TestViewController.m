//
//  TestViewController.m
//  Banner
//
//  Created by 郑文明 on 16/4/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "TestViewController.h"
#import "WMBannerView.h"

@interface TestViewController (){
    WMBannerView *wmView;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *dataSource = [[NSMutableArray alloc]init];
    //这句非常重要
    self.automaticallyAdjustsScrollViewInsets = NO;
    /*
     网络图片测试
     */
    NSArray *URLArray = @[@"http://farm2.staticflickr.com/1709/24157242566_98d0192315_m.jpg",
                          @"http://farm2.staticflickr.com/1715/23815656639_ef86cf1498_m.jpg"];
    
    for (NSString *url in URLArray) {
        WMBannerModel *model = [[WMBannerModel alloc]init];
        model.URLOrImage = url;
        model.title = [NSString stringWithFormat:@"我是第%ld张",[URLArray indexOfObject:url]];
        [dataSource addObject:model];
    }
    
    
    
    wmView = [WMBannerView wmBannerViewWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.width) autoPlayWithDelay:2 modelsArray:dataSource placeholderImageName:nil imageViewsContentMode:UIViewContentModeScaleAspectFit
                                 clickedCallBack:^(int clickedIndex) {
                                     NSLog(@"ClickdCallBlock %d",clickedIndex);
                                     
                                 }
                                scrolledCallBack:^(int scrolledIndex) {
                                    NSLog(@"ScrolledCallBlock %d",scrolledIndex);
                                }];
    
    [self.view addSubview:wmView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
