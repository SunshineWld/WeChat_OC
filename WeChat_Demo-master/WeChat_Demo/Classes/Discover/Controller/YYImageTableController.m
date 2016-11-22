//
//  YYImageTableController.m
//  WeChat_Demo
//
//  Created by YYSky on 16/7/29.
//  Copyright © 2016年 YYSky. All rights reserved.
//

#import "YYImageTableController.h"
#import "YYPictureCollectionController.h"
#import "YYDiscoverNavController.h"

@interface YYImageTableController ()

@end

@implementation YYImageTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCancel)];
    
    [self jumpToPicVc];
}

- (void)clickCancel{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)jumpToPicVc{

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 50, 10);
        flowLayout.minimumLineSpacing = 6;
        flowLayout.minimumInteritemSpacing = 6;

        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 2 * 10 -2 *6) / 3 - 2;
        flowLayout.itemSize = CGSizeMake(itemW, itemW);
        YYPictureCollectionController *picVc = [[YYPictureCollectionController alloc]initWithCollectionViewLayout:flowLayout];
        picVc.navigationItem.title = @"相册";

        YYDiscoverNavController *navPic = [[YYDiscoverNavController alloc]initWithRootViewController:picVc];

        [self presentViewController:navPic animated:NO completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld相册",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.0;
}

@end
