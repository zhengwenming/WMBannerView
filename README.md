# WMBannerView
强大的广告轮播图，可设定轮播时间，可轮播本地和网络图片（可设置默认的placeholder），支持手动和自动无限循环轮播。


#用法

     
  NSMutableArray *dataSource = [[NSMutableArray alloc]init];
    /*
     网络图片测试
     */
    NSArray *URLArray = @[@"http://farm2.staticflickr.com/1709/24157242566_98d0192315_m.jpg",
                          @"http://farm2.staticflickr.com/1715/23815656639_ef86cf1498_m.jpg",
                          @"http://farm2.staticflickr.com/1455/23888379640_edf9fce919_m.jpg",
                          @"http://farm2.staticflickr.com/1474/23556559423_daa83f9fa0_m.jpg",
                          @"http://farm2.staticflickr.com/1654/24076046592_bfed33b5db_m.jpg"];
    
    for (NSString *url in URLArray) {
        WMBannerModel *model = [[WMBannerModel alloc]init];
        model.URLOrImage = url;
        model.title = [NSString stringWithFormat:@"我是第%ld张",[URLArray indexOfObject:url]];
        [dataSource addObject:model];
    }
    
    
    
    wmView = [WMBannerView wmBannerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*3/4) autoPlayWithDelay:0 modelsArray:dataSource placeholderImageName:nil imageViewsContentMode:UIViewContentModeScaleToFill
    clickedCallBack:^(int clickedIndex) {
        NSLog(@"ClickdCallBlock %d",clickedIndex);
    
    }
    scrolledCallBack:^(int scrolledIndex) {
        NSLog(@"ScrolledCallBlock %d",scrolledIndex);
    }];
    //把轮播图放到table的头上或者UICollectionView的头上
    tableView.tableHeaderView = wmView;



/*
     本地图片
     
     */
     NSMutableArray *dataSource = [[NSMutableArray alloc]init];

   
    NSArray *imagesArray = @[[UIImage imageNamed:@"ad1.jpg"],
                             [UIImage imageNamed:@"ad2.jpg"],
                             [UIImage imageNamed:@"ad3.jpg"],
                             [UIImage imageNamed:@"ad4.jpg"],
                             [UIImage imageNamed:@"ad5.jpg"]];
    for (UIImage *image in imagesArray) {
        WMBannerModel *model = [[WMBannerModel alloc]init];
        model.URLOrImage = image;
        model.title = [NSString stringWithFormat:@"我是第%ld张",[imagesArray indexOfObject:image]];
        [dataSource addObject:model];
    }
    wmView = [WMBannerView wmBannerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*3/4) autoPlayWithDelay:0 modelsArray:dataSource placeholderImageName:nil imageViewsContentMode:UIViewContentModeScaleToFill
                                 clickedCallBack:^(int clickedIndex) {
                                     NSLog(@"ClickdCallBlock %d",clickedIndex);
                                     
                                 }
                                scrolledCallBack:^(int scrolledIndex) {
                                    NSLog(@"ScrolledCallBlock %d",scrolledIndex);
                                }];

     
把轮播图放到table的头上或者UICollectionView的头上
    tableView.tableHeaderView = wmView;
    
    
    
   #放到self.view上
    
    
    
    NSMutableArray *dataSource = [[NSMutableArray alloc]init];
    #这句非常重要,一定要加这个，不然出bug
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
注明：依赖库为SDWebImage。
