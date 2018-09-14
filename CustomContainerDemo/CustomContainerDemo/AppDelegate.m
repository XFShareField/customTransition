//
//  AppDelegate.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/11.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    NSMutableArray *vcs = [NSMutableArray array];
    NSMutableArray *titles = @[@"架海紫金梁",@"陌上人如玉",@"花无缺",@"欧阳峰",@"上官警我",@"黄药师"].mutableCopy;
    for (int i=0; i<6; i++) {
        TestViewController *tVC = [[TestViewController alloc]init];
        [vcs addObject:tVC];
    }
//    self.window.rootViewController =[[UINavigationController alloc]initWithRootViewController: [[ViewController alloc]initWithVCArr:vcs titles:titles]];
    self.window.rootViewController = [[ViewController alloc]initWithVCArr:vcs titles:titles];
    TestViewController *TVC = [[TestViewController alloc]init];
    TVC.isFirst = YES;
    self.window.rootViewController = TVC;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
