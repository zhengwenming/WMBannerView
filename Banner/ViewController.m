//
//  ViewController.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "ViewController.h"
#import "WMBannerView.h"
#import "BannerOfLocalImageViewController.h"
#import "BannerOfNetworkImageViewController.h"
#import "CVOfLocalImageViewController.h"
#import "CVOfNetworkImageViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *table;
    NSMutableArray *dataSource;
    
}

@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        dataSource = [[NSMutableArray alloc]init];
        [dataSource addObject:@"table的头轮播本地图片"];
        [dataSource addObject:@"table的头轮播网络图片"];
        [dataSource addObject:@"CollectionView的头轮播本地图片"];
        [dataSource addObject:@"CollectionView的头轮播网络图片"];
    }
    return self;
}

- (void)viewDidLoad {
    self.title = @"滚动轮播图";
    [super viewDidLoad];
    
    [self initTable];
}
-(void)initTable{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate =  self;
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        BannerOfLocalImageViewController *localImageVC = [[BannerOfLocalImageViewController alloc]init];
        [self.navigationController pushViewController:localImageVC animated:YES];
 
    }else if (indexPath.row==1){
        BannerOfNetworkImageViewController *networkVC = [[BannerOfNetworkImageViewController alloc]init];
        [self.navigationController pushViewController:networkVC animated:YES];

    }else if (indexPath.row==2){
        CVOfLocalImageViewController *cvLocalVC = [[CVOfLocalImageViewController alloc]init];
        [self.navigationController pushViewController:cvLocalVC animated:YES];
        
    }else if (indexPath.row==3){
        CVOfNetworkImageViewController *cvnetworkVC = [[CVOfNetworkImageViewController alloc]init];
        [self.navigationController pushViewController:cvnetworkVC animated:YES];
        
    }
}
@end
