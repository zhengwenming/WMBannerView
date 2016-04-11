

//
//  BannerOfLocalImageViewController.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "BannerOfLocalImageViewController.h"
#import "WMBannerView.h"

@interface BannerOfLocalImageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *table;
    WMBannerView *wmView;
}


@end

@implementation BannerOfLocalImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *dataSource = [[NSMutableArray alloc]init];

    /*
     本地图片测试
     */
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
                                     [self.navigationController pushViewController:[UIViewController new] animated:YES];
                                 }
                                scrolledCallBack:^(int scrolledIndex) {
                                    NSLog(@"ScrolledCallBlock %d",scrolledIndex);
                                }];
    

    [self initTable];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)initTable{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate =  self;
    table.tableHeaderView = wmView;
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%li行",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
