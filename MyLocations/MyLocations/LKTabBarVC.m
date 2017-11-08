//
//  LKTabBarVC.m
//  MyLocations
//
//  Created by likai on 08/11/2017.
//  Copyright © 2017 yinbake. All rights reserved.
//

#import "LKTabBarVC.h"
#import "LKFirstVC.h"
#import "LKSecondVC.h"

@interface LKTabBarVC ()

@end

@implementation LKTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LKFirstVC *firstVC = [[LKFirstVC alloc]init];
    UINavigationController *firstNav = [[UINavigationController alloc]initWithRootViewController:firstVC];
    firstNav.tabBarItem.title = @"First";
    LKSecondVC *secondVC = [[LKSecondVC alloc]init];
    UINavigationController *secondNav = [[UINavigationController alloc]initWithRootViewController:secondVC];
    secondNav.tabBarItem.title = @"Second";
    self.viewControllers = @[firstNav, secondNav];
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
