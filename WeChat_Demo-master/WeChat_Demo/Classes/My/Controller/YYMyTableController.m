

#import "YYMyTableController.h"

@interface YYMyTableController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation YYMyTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    [self loadData];
}

- (void)loadData{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"MyList.plist" ofType:nil];
    
    self.dataArray = [NSArray arrayWithContentsOfFile:path];
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

    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
       
    }
    
    NSArray *items = self.dataArray[indexPath.section][@"items"];
    NSDictionary *dict = items[indexPath.row];
    
    cell.textLabel.text = dict[@"name"];
    cell.detailTextLabel.text = dict[@"details"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

#pragma mark - 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return 80;
    }else{
    
        return 44;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
