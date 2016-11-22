//
//  YYEditPicTableController.m
//  WeChat_Demo
//
//  Created by YYSky on 16/7/24.
//  Copyright © 2016年 YYSky. All rights reserved.
//

#import "YYEditPicTableController.h"
#import "YYEditHeaderView.h"

@interface YYEditPicTableController ()<UIAlertViewDelegate>

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation YYEditPicTableController

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelBtn)];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 24)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(didClickSendBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sendBtn];
    
    [self loadData];
    
    //表头
    YYEditHeaderView *headerView = [[YYEditHeaderView alloc]initWithModels:self.imageArray];
//    headerView.frame = CGRectMake(0, 0, kScreenWidth, 220);
    
    self.tableView.tableHeaderView = headerView;
}



- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"EditPic.plist" ofType:nil];
    
    self.dataArray = [NSArray arrayWithContentsOfFile:path];
}


- (void)didClickCancelBtn{
    
    [self.view endEditing:YES];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"退出此次编辑?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == alertView.firstOtherButtonIndex) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            nil;
            
        }];
        
    }
}

- (void)didClickSendBtn{

    NSLog(@"didClickSendBtn");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *items = self.dataArray[section][@"items"];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"editCell";
    NSArray *items = self.dataArray[indexPath.section][@"items"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = items[indexPath.row][@"title"];
//    cell.imageView.image = [UIImage imageNamed:items[indexPath.row][@"icon"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}



@end
