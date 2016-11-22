

#import "YYDiscoverTableController.h"
#import "YYFriendTableController.h"


@interface YYDiscoverTableController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation YYDiscoverTableController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *items = self.dataArray[indexPath.section][@"items"];
    
    NSDictionary *dict = items[indexPath.row];
    
    if ([dict[@"targetVcName"] length] > 0) {
        
        Class cls = NSClassFromString(dict[@"targetVcName"]);
        
        UIViewController *targetVc = [[cls alloc]init];
        
        targetVc.navigationItem.title = dict[@"title"];
        targetVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:targetVc animated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
    
    [self loadData];
    
}

- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DiscoverList.plist" ofType:nil];

    self.dataArray = [NSArray arrayWithContentsOfFile:path];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *items = self.dataArray[section][@"items"];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"disCell";
    NSArray *items = self.dataArray[indexPath.section][@"items"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = items[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:items[indexPath.row][@"icon"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
