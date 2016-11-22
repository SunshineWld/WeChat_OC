

#import "YYBaseNavController.h"

@interface YYBaseNavController ()

@end

@implementation YYBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Dimensional-_Code_Bg"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                                 }];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabBarTitle:(NSString *)titleStr withNorImage:(NSString *)norStr withSelImage:(NSString *)selStr{

    self.tabBarItem.title = titleStr;
    [self.tabBarItem setTitleTextAttributes:@{
                                              NSForegroundColorAttributeName:[UIColor colorWithRed:0.04 green:0.73 blue:0.03 alpha:1.00]
                                              }
                                   forState:UIControlStateSelected];
    
    UIImage *norImage = [UIImage imageNamed:norStr];
    UIImage *selImage = [UIImage imageNamed:selStr];
    
    norImage = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.tabBarItem.image = norImage;
    self.tabBarItem.selectedImage = selImage;

}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//    viewController.hidesBottomBarWhenPushed = YES;
//    
//    return [super pushViewController:viewController animated:animated];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
