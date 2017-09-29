//
//  AppDelegate.m
//  To-do List
//
//  Created by likai on 2017/6/26.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "AppDelegate.h"
#import "LKNavigationController.h"
#import "LKCheckListTableVC.h"
#import "LKAllListsVC.h"
#import "LKDataModel.h"

@interface AppDelegate ()
{
    LKDataModel *_dataModel;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LKAllListsVC *vc = [[LKAllListsVC alloc]init];
    _dataModel = [[LKDataModel alloc]init];
    vc.dataModel = _dataModel;
    LKNavigationController *nav = [[LKNavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"收到通知了");
}

//保存数据
- (void)saveData
{
//    LKNavigationController *navigationController = (LKNavigationController *)self.window.rootViewController;
//    LKAllListsVC *controller = navigationController.viewControllers[0];
//    [controller.dataModel saveDataToFile];
    [_dataModel saveDataToFile];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self saveData];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveData];
}


@end
