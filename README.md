# Localpush
iOS开发,实现本地推送

##### 个人链接

* [个人博客](https://nslog-yuhaitao.github.io ) : 个人博客主页
* [iOS频道(iOSPD)](http://www.jianshu.com/collection/d76ac79331c6): 这是我个人整理的一个技术专题, 这里的文章都是比较有技术含量(不断更新)!
* 微信公众号 : 

![微信公众号.jpg](http://upload-images.jianshu.io/upload_images/2248913-22bc242c26133c62.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 功能部分:</br>
![本地推送分析图](http://upload-images.jianshu.io/upload_images/2248913-0ad720fb24535dc5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####一.iOS8本地推送注册
~~~
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
~~~

~~~
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //本地推送
    [self requestAuthor];
    return YES;
}
~~~

##### 三.假设在ViewController中添加touchesBegan方法,具体UILocalNotification的基本属性请往下看!
~~~
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"本地通知测试";
    // 设置通知的发送时间,单位秒
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //解锁滑动时的事件
    localNotification.alertAction = @"别磨蹭了!";
    //收到通知时App icon的角标
    localNotification.applicationIconBadgeNumber = 1;
    //推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 3.发送通知(🐽 : 根据项目需要使用)
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // 方式二: 立即发送通知
    // [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}
~~~
#### 注意:UILocalNotification的基本属性
~~~
fireDate：启动时间
timeZone：启动时间参考的时区
repeatInterval：重复推送时间（NSCalendarUnit类型），0代表不重复
repeatCalendar：重复推送时间（NSCalendar类型）
alertBody：通知内容
alertAction：解锁滑动时的事件
alertLaunchImage：启动图片，设置此字段点击通知时会显示该图片
alertTitle：通知标题，适用iOS8.2之后
applicationIconBadgeNumber：收到通知时App icon的角标
soundName：推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
userInfo：发送通知时附加的内容
category：此属性和注册通知类型时有关联，（有兴趣的同学自己了解，不详细叙述）适用iOS8.0之后

region：带有定位的推送相关属性，具体使用见下面【带有定位的本地推送】适用iOS8.0之后
regionTriggersOnce：带有定位的推送相关属性，具体使用见下面【带有定位的本地推送】适用iOS8.0之后
~~~

##### 四.注意一点. 当再次进入app中,通知栏的通知需要不显示,并且app的角标也要没有,所以需要在appDelegate设置一个属性.
~~~
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //设置应用程序图片右上角的数字(如果想要取消右上角的数字, 直接把这个参数值为0)
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
~~~


##### 五.运行效果图   
 - 注意: 运行程序后,点击ViewController空白区域之后,必须推到后台才能看到通知的运行效果.
- 首次运行会弹出让用户选择授权!!!

![首次运行会弹出让用户选择授权](http://upload-images.jianshu.io/upload_images/2248913-c040eae5301e8261.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![在桌面顶部弹出效果](http://upload-images.jianshu.io/upload_images/2248913-7933823f1db9b6aa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 六.简书详情
[http://www.jianshu.com/p/4a23bd5e1b00](http://www.jianshu.com/p/4a23bd5e1b00)
  

##### 分析appDelegate(作为总结,可以不看!)

~~~
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #pragma mark --  NSLog(@"\n ===> 程序开始 !");

    return YES;
}
~~~

~~~
- (void)applicationWillResignActive:(UIApplication *)application {
    #pragma mark -->NSLog(@"\n ===> 程序挂起 !");  比如:当有电话进来或者锁屏，这时你的应用程会挂起，在这时，UIApplicationDelegate委托会收到通知，调用 applicationWillResignActive 方法，你可以重写这个方法，做挂起前的工作，比如关闭网络，保存数据。
}
~~~

~~~
- (void)applicationDidEnterBackground:(UIApplication *)application {
    #pragma mark --> NSLog(@"\n ===> 程序进入后台 !");
}
~~~

~~~
- (void)applicationWillEnterForeground:(UIApplication *)application {
    #pragma mark --> NSLog(@"\n ===> 程序进入前台 !");
}
~~~

~~~
- (void)applicationDidBecomeActive:(UIApplication *)application {
    #pragma mark -->  NSLog(@"\n ===> 程序重新激活 !"); 应用程序在启动时，在调用了 applicationDidFinishLaunching 方法之后也会调用 applicationDidBecomeActive 方法，所以你要确保你的代码能够分清复原与启动，避免出现逻辑上的bug。(大白话就是说:只要启动app就会走此方法)。
}
~~~

~~~
- (void)applicationWillTerminate:(UIApplication *)application {
    #pragma mark --> 当用户按下按钮，或者关机，程序都会被终止。当一个程序将要正常终止时会调用 applicationWillTerminate 方法。但是如果长主按钮强制退出，则不会调用该方法。这个方法该执行剩下的清理工作，比如所有的连接都能正常关闭，并在程序退出前执行任何其他的必要的工作.
}
~~~



### 声明

* 所有文章出自 [Kenny Hito 的博客](https://nslog-yuhaitao.github.io ) !
* 未经本人允许不得转载, 转载请标明来源与作者, 谢谢合作! 