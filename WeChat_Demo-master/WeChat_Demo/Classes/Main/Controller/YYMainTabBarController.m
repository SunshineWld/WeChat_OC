
#import "YYMainTabBarController.h"
#import "YYHomeNavController.h"
#import "YYBaseTableController.h"
#import "YYContactNavController.h"
#import "YYDiscoverNavController.h"
#import "YYMyNavController.h"
#import "YYHomeTableController.h"
#import "YYContactTableController.h"
#import "YYDiscoverTableController.h"
#import "YYMyTableController.h"

@interface YYMainTabBarController ()

@end

@implementation YYMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self addSubViewController];
    
    self.selectedIndex = self.viewControllers.count - 1;
}

- (void)addSubViewController{
    
    YYHomeNavController *home = [[YYHomeNavController alloc]initWithRootViewController:[[YYHomeTableController alloc]init]];
    [home setTabBarTitle:@"微信" withNorImage:@"tabbar_mainframe" withSelImage:@"tabbar_mainframeHL"];
    
    YYContactNavController *contact = [[YYContactNavController alloc]initWithRootViewController:[[YYContactTableController alloc]init]];
    [contact setTabBarTitle:@"联系人" withNorImage:@"tabbar_contacts" withSelImage:@"tabbar_contactsHL"];
    
    YYDiscoverNavController *discover = [[YYDiscoverNavController alloc]initWithRootViewController:[[YYDiscoverTableController alloc]init]];
    [discover setTabBarTitle:@"发现" withNorImage:@"tabbar_discover" withSelImage:@"tabbar_discoverHL"];
    
    YYMyNavController *my = [[YYMyNavController alloc]initWithRootViewController:[[YYMyTableController alloc]init]];
    [my setTabBarTitle:@"我" withNorImage:@"tabbar_me" withSelImage:@"tabbar_meHL"];
    
    self.viewControllers = @[home, contact, discover, my];
    
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
