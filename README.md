# WMBannerView
强大的广告轮播图，可设定轮播时间，可轮播本地和网络图片（可设置默认的placeholder），支持手动和自动无限循环轮播。


#用法
/*
     网络图片测试
     */
    NSArray *URLArray = @[@"http://farm2.staticflickr.com/1709/24157242566_98d0192315_m.jpg",
                          @"http://farm2.staticflickr.com/1715/23815656639_ef86cf1498_m.jpg",
                          @"http://farm2.staticflickr.com/1455/23888379640_edf9fce919_m.jpg"];
    
    WMBannerView *   wmView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*3/4) withURLArrayOrImagesArray:URLArray];
    wmView.pageControlAlignment = WMPageContolAlignmentCenter;
    wmView.placeHoldImage = [UIImage imageNamed:@"placeholderImage"];
    wmView.animationDuration = 1.0;//设置自动播放时间，默认5.0s，设置为0的时候不自动播放
    [wmView startWithTapActionBlock:^(NSInteger index) {
        NSLog(@"点击了第%@张",@(index));
    }];
    //把轮播图放到table的头上或者UICollectionView的头上
    tableView.tableHeaderView = wmView;


注明：依赖库为SDWebImage。
