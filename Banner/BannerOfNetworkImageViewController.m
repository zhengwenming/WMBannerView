

//
//  BannerOfNetworkImageViewController.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "BannerOfNetworkImageViewController.h"
#import "WMBannerView.h"

@interface BannerOfNetworkImageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *table;
    WMBannerView *wmView;
}



@end

@implementation BannerOfNetworkImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     网络图片测试
     */
    NSArray *URLArray = @[@"http://farm2.staticflickr.com/1709/24157242566_98d0192315_m.jpg",
                          @"http://farm2.staticflickr.com/1715/23815656639_ef86cf1498_m.jpg",
                          @"http://farm2.staticflickr.com/1455/23888379640_edf9fce919_m.jpg"];
    
    wmView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*3/4) withURLArrayOrImagesArray:URLArray];
    wmView.pageControlAlignment = WMPageContolAlignmentCenter;
    wmView.placeHoldImage = [UIImage imageNamed:@"placeholderImage"];
    wmView.animationDuration = 1.0;
    [wmView startWithTapActionBlock:^(NSInteger index) {
        NSLog(@"点击了第%@张",@(index));
    }];
    

    
    [self initTable];
    
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
