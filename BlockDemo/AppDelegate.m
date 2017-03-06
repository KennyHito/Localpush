//
//  AppDelegate.m
//  BlockDemo
//
//  Created by 于海涛 on 17/3/4.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #pragma mark --  NSLog(@"\n ===> 程序开始 !");
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    [self.window makeKeyAndVisible];
    
    //本地推送
    [self requestAuthor];
    
    return YES;
}


//创建本地通知
- (void)requestAuthor
{
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    #pragma mark -->NSLog(@"\n ===> 程序挂起 !");  比如:当有电话进来或者锁屏，这时你的应用程会挂起，在这时，UIApplicationDelegate委托会收到通知，调用 applicationWillResignActive 方法，你可以重写这个方法，做挂起前的工作，比如关闭网络，保存数据。
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    #pragma mark --> NSLog(@"\n ===> 程序进入后台 !");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    #pragma mark --> NSLog(@"\n ===> 程序进入前台 !");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    #pragma mark -->  NSLog(@"\n ===> 程序重新激活 !"); 应用程序在启动时，在调用了 applicationDidFinishLaunching 方法之后也会调用 applicationDidBecomeActive 方法，所以你要确保你的代码能够分清复原与启动，避免出现逻辑上的bug。(大白话就是说:只要启动app就会走此方法)。
}


- (void)applicationWillTerminate:(UIApplication *)application {
    #pragma mark --> 当用户按下按钮，或者关机，程序都会被终止。当一个程序将要正常终止时会调用 applicationWillTerminate 方法。但是如果长主按钮强制退出，则不会调用该方法。这个方法该执行剩下的清理工作，比如所有的连接都能正常关闭，并在程序退出前执行任何其他的必要的工作.
}


@end
