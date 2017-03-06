//
//  ViewController.m
//  BlockDemo
//
//  Created by 于海涛 on 17/3/4.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "ViewController.h"
#import "HeaderTool.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor orangeColor];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"本地通知测试";
    // 设置通知的发送时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    
    
    localNotification.alertAction = @"赶紧的了!";
    
    localNotification.applicationIconBadgeNumber = 1;
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 3.发送通知
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // 方式二: 立即发送通知
//    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
