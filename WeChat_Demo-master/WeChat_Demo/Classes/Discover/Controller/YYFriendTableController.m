

#import "YYFriendTableController.h"
#import "YYFriendHeaderView.h"
#import "YYPictureCollectionController.h"
#import "YYDiscoverNavController.h"
#import "YYImageTableController.h"
#import "YYBaseNavController.h"

@interface YYFriendTableController ()<UIActionSheetDelegate>

@property (weak, nonatomic) YYFriendHeaderView *headerView;

@property (weak, nonatomic) UIImageView *activityView;

@property (weak, nonatomic) UIView *containerView;

@property (assign, nonatomic, getter=isDragging) BOOL dragging;//手动拖动的标志
@property (assign, nonatomic) NSInteger num;//记录调用次数

@property (assign, nonatomic) CGFloat currentY;

@end

@implementation YYFriendTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(clickCameraItem)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    YYFriendHeaderView *headerView = [YYFriendHeaderView friendHeaderView];
    
    self.tableView.tableHeaderView = headerView;
    
    //下拉的圈圈
    UIImage *actImage = [UIImage imageNamed:@"activity"];
    
    UIImageView *activityView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    activityView.image = actImage;
    
    activityView.layer.cornerRadius = 15;
    activityView.layer.masksToBounds = YES;
    
    self.activityView = activityView;
    
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(15, 120, 30, 30)];
    containerView.backgroundColor = [UIColor orangeColor];
//    containerView.backgroundColor = [UIColor clearColor];
    
    [containerView addSubview:activityView];
    self.containerView = containerView;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0);
    [self.view addSubview:containerView];
}

#pragma mark - 滚动时调用

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.dragging = YES;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.num == 0) {
        self.num ++;
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat angle = -offsetY * M_PI / 30;
    
    if (self.dragging == YES) {
        
        if (offsetY <= 110) {
            self.containerView.y = 10 + offsetY;
            
        }
    
    }else {
    
        if (self.currentY < 120) {
            self.containerView.y = 10 + offsetY;
        }
        
    }
    self.activityView.transform = CGAffineTransformMakeRotation(angle);
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    self.dragging = NO;
    
    CGFloat currentY = self.containerView.y;
    self.currentY = currentY;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [UIView animateWithDuration:0.25 animations:^{

        self.containerView.frame = CGRectMake(15, 120, 30, 30);
        self.activityView.transform = CGAffineTransformMakeRotation(2 * M_PI);
    }];
    
}

- (void)clickCameraItem{

    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选取照片", nil];
    
    [sheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        
        YYImageTableController *imageVc = [[YYImageTableController alloc]initWithStyle:UITableViewStylePlain];
        YYBaseNavController *imageNav = [[YYBaseNavController alloc]initWithRootViewController:imageVc];
        imageVc.navigationItem.title = @"照片";
        [self presentViewController:imageNav animated:NO completion:nil];
        

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%02zd",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    footer.backgroundColor = [UIColor whiteColor];
    
    return footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
