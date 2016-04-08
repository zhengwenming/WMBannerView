
//
//  CVOfLocalImageViewController.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CVOfLocalImageViewController.h"
#import "CollectionViewCell.h"
#import "WMBannerView.h"
@interface CVOfLocalImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *cv;
    NSMutableArray *dataSource;
    WMBannerView *wmView;

}

@end

@implementation CVOfLocalImageViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
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
                                     
                                 }
                                scrolledCallBack:^(int scrolledIndex) {
                                    NSLog(@"ScrolledCallBlock %d",scrolledIndex);
                                }];
    [self initCollectionView];
}
-(void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.width*3/4)];

    cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    cv.delegate = self;
    cv.dataSource = self;
    cv.backgroundColor = [UIColor whiteColor];
    [cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"WMBannerView"];
    [cv registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:cv];
    
}
#pragma mark
#pragma mark collectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 21;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.centerLabel.text = [NSString stringWithFormat:@"第%ld个cell",indexPath.row];
    cell.backgroundColor = [UIColor magentaColor];

    return cell;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WMBannerView" forIndexPath:indexPath];
        [headerView addSubview:wmView];
        return headerView;
    
    }
    else{
        return nil;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width-5*6)/3, (self.view.frame.size.width-5*4)/3);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
