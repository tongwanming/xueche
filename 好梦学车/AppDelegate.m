//
//  AppDelegate.m
//  好梦学车
//
//  Created by haomeng on 2017/4/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Hoverbutton.h"
#import "BasicAlertViewController.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "LaunchIntroductionView.h"
#import "URLConnectionModel.h"
#import "URLConnectionHelper.h"
#import "SubjectPractiseModel.h"
#import "SqliteDateManager.h"
#import "CustomAlertView.h"

#import <AlipaySDK/AlipaySDK.h>
#import "YHNAdditionManager.h"
#import "WXApi.h"
#import "JPUSHService.h"
#import <AdSupport/ASIdentifierManager.h>
#import <UserNotifications/UserNotifications.h>
#import <UMSocialCore/UMSocialCore.h>
#import "SubjectPractiseViewController.h"

#define USHARE_DEMO_APPKEY @"59df13e68f4a9d266300000d"

static NSString *appKey = @"d5e9231fa78e0f963eda40c1";


@interface AppDelegate ()<NSURLConnectionDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate{
    UITapGestureRecognizer *_tapGesture;
    UIView *_subTapView;
    Hoverbutton *_btn;
    MainViewController *main;
    int _badgeNumber;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result) {
        return result;
    }
    return [[YHNAdditionManager sharedManager] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (result) {
        return result;
    }
    return [[YHNAdditionManager sharedManager] handleOpenURL:url];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (result) {
        return result;
    }
    return [[YHNAdditionManager sharedManager] handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //推
    //自定义消息
    NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:appKey
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];
    
    
    
    //微信支付
     [WXApi registerApp:@"wxf5f3953299feaaa1"];
     [[YHNAdditionManager sharedManager] setup:launchOptions];
    //地图部分
    BMKMapManager *manager = [[BMKMapManager alloc] init];
    
    BOOL success = [manager start:@"UO9B4VG4X6TeBEYHcMo7GGfyr052WfxA" generalDelegate:nil];
    
    if (!success) {
        NSLog(@"百度地图启动成功");
    }
    
    
    //设置主题window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
   main = [[MainViewController alloc] init];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    
     [LaunchIntroductionView sharedWithImages:@[@"welcome01.jpg",@"welcome02.jpg",@"welcome031.png"] buttonImage:@"" buttonFrame:CGRectMake(kScreen_width/2 - 150/2, kScreen_height - 100, 150, 45)];
    
//    [self loadDataOne];
//    [self loadDataTwo];
//    [self loadDataThree];
//    [self loadDataForth];
    [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
  //友盟
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];

    return YES;
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxf5f3953299feaaa1" appSecret:@"ab1d2985e65f4bca91c8c782fece6c8e" redirectURL:nil];
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxf5f3953299feaaa1" appSecret:@"ab1d2985e65f4bca91c8c782fece6c8e" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106474196"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106474196"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
//    /* 钉钉的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//    
//    /* 支付宝的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];
//    
//    
//    /* 设置易信的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置点点虫（原来往）的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置领英的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
//    
//    /* 设置Twitter的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
//    
//    /* 设置Facebook的appKey和UrlString */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:nil];
//    
//    /* 设置Pinterest的appKey */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
//    
//    /* dropbox的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
//    
//    /* vk的appkey */
//    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
    
}


#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
//    _badgeNumber++;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:_badgeNumber];
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
//    _badgeNumber++;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:_badgeNumber];
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    _badgeNumber++;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:_badgeNumber];
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
 
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    _badgeNumber++;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:_badgeNumber];
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//接收到自定义消息后的回调，接收自定义消息需要应用在前台
-(void)networkDidReceiveMessage:(NSNotification*)notification{
    NSLog(@"received custom message");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //将deviceToken上报到极光服务器
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - 下载数据
- (void)loadDataOne{
    NSArray *arr = [[SqliteDateManager sharedManager] getAllDataWithType:@"normal"];
    if (arr.count > 1) {
        
    }else{
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"";
        [CustomAlertView showAlertViewWithVC:main];
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            //       NSArray *dataArr = [NSArray arrayWithArray:arr];
            NSLog(@"%@",@"下载成功！");
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:[NSString stringWithFormat:@"%@%ld",@"order",PractiseViewControllerTypeOne]];
            for (NSDictionary *dic in arr) {
                SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
                model.question = [dic objectForKey:@"question"];
                model.answer1 = [dic objectForKey:@"option1"];
                model.answer2 = [dic objectForKey:@"option2"];
                model.answer3 = [dic objectForKey:@"option3"];
                model.answer4 = [dic objectForKey:@"option4"];
                model.answer = [dic objectForKey:@"answer"];
                model.explain = [dic objectForKey:@"explain"];
                model.picUrl = [dic objectForKey:@"pic"];
                model.type = [dic objectForKey:@"type"];
                model.chapter = [dic objectForKey:@"chapter"];
                model.questionID = [dic objectForKey:@"questionId"];
                model.sqliteType = @"normal";
                model.questionType = [dic objectForKey:@"questionType"];
                [[SqliteDateManager sharedManager] addSubjectPractiseModel:model];
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
           
        } andFailedBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                
            });
            
        }];
    }
}



- (void)loadDataTwo{
    if (((NSArray *)[[SqliteDateManager sharedManager] getAllDataWithType:@"normalf"]).count > 1) {
        
    }else{
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"Y";
        [CustomAlertView showAlertViewWithVC:main];
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:[NSString stringWithFormat:@"%@%ld",@"noOrder",PractiseViewControllerTypeOne]];
            NSLog(@"下载完成two");
            for (NSDictionary *dic in arr) {
                SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
                model.question = [dic objectForKey:@"question"];
                model.answer1 = [dic objectForKey:@"option1"];
                model.answer2 = [dic objectForKey:@"option2"];
                model.answer3 = [dic objectForKey:@"option3"];
                model.answer4 = [dic objectForKey:@"option4"];
                model.answer = [dic objectForKey:@"answer"];
                model.explain = [dic objectForKey:@"explain"];
                model.picUrl = [dic objectForKey:@"pic"];
                model.type = [dic objectForKey:@"type"];
                model.chapter = [dic objectForKey:@"chapter"];
                model.questionID = [dic objectForKey:@"questionId"];
                model.sqliteType = @"normalf";
                [[SqliteDateManager sharedManager] addSubjectPractiseModel:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        } andFailedBlock:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        }];
    }

}

- (void)loadDataThree{
    if (((NSArray *)[[SqliteDateManager sharedManager] getAllDataWithType:@"normalf"]).count > 1) {
        
    }else{
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"4";
        model.chapter = @"";
        model.isRand = @"";
        [CustomAlertView showAlertViewWithVC:main];
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:[NSString stringWithFormat:@"%@%ld",@"order",PractiseViewControllerTypeForth]];
            NSLog(@"下载完成three");
            for (NSDictionary *dic in arr) {
                SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
                model.question = [dic objectForKey:@"question"];
                model.answer1 = [dic objectForKey:@"option1"];
                model.answer2 = [dic objectForKey:@"option2"];
                model.answer3 = [dic objectForKey:@"option3"];
                model.answer4 = [dic objectForKey:@"option4"];
                model.answer = [dic objectForKey:@"answer"];
                model.explain = [dic objectForKey:@"explain"];
                model.picUrl = [dic objectForKey:@"pic"];
                model.type = [dic objectForKey:@"type"];
                model.chapter = [dic objectForKey:@"chapter"];
                model.questionID = [dic objectForKey:@"questionId"];
                model.sqliteType = @"normalf";
                [[SqliteDateManager sharedManager] addSubjectPractiseModel:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        } andFailedBlock:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        }];
    }
    
}

- (void)loadDataForth{
    if (((NSArray *)[[SqliteDateManager sharedManager] getAllDataWithType:@"normalf"]).count > 1) {
        
    }else{
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"4";
        model.chapter = @"";
        model.isRand = @"Y";
        [CustomAlertView showAlertViewWithVC:main];
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:[NSString stringWithFormat:@"%@%ld",@"noOrder",PractiseViewControllerTypeForth]];
            NSLog(@"下载完成forth");
            for (NSDictionary *dic in arr) {
                SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
                model.question = [dic objectForKey:@"question"];
                model.answer1 = [dic objectForKey:@"option1"];
                model.answer2 = [dic objectForKey:@"option2"];
                model.answer3 = [dic objectForKey:@"option3"];
                model.answer4 = [dic objectForKey:@"option4"];
                model.answer = [dic objectForKey:@"answer"];
                model.explain = [dic objectForKey:@"explain"];
                model.picUrl = [dic objectForKey:@"pic"];
                model.type = [dic objectForKey:@"type"];
                model.chapter = [dic objectForKey:@"chapter"];
                model.questionID = [dic objectForKey:@"questionId"];
                model.sqliteType = @"normalf";
                [[SqliteDateManager sharedManager] addSubjectPractiseModel:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        } andFailedBlock:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        }];
    }
    
}

- (void)setCarClassData:(NSArray *)carClassData{
    _carClassData = carClassData;
}

- (void)showHoverButtonHidden:(BOOL)hidden{
    if (hidden) {
         _btn.hidden = YES;
    }else{
        _btn.hidden = NO;
    }
}

- (void)setShowHoverbutton:(BOOL)showHoverbutton{
    self.showHoverbutton = showHoverbutton;
    if (showHoverbutton) {
        _btn.hidden = NO;
    }else{
        _btn.hidden = YES;
    }
}

- (void)setLocationDataWithData:(NSArray *)data{
    _locationData = data;
}

-(void)showTag:(UIButton *)sender
{
    if ([self.window.rootViewController.presentedViewController isKindOfClass:[BasicAlertViewController class]]) {
        return;
    }
    NSLog(@"button.tag >> %@---%f",@(sender.tag),sender.center.x);
    [self.window removeGestureRecognizer:_tapGesture];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureActive:)];
    [self.window addGestureRecognizer:_tapGesture];
    BasicAlertViewController *alertVC = [BasicAlertViewController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"电话咨询" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"电话咨询");
        [self.window removeGestureRecognizer:_tapGesture];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dissMissAlertVC" object:nil];
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"在线咨询");
        [self.window removeGestureRecognizer:_tapGesture];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dissMissAlertVC" object:nil];
    }]];
    
    [self.window.rootViewController presentViewController:alertVC animated:YES completion:^{
        
    }];
}

- (void)tapGestureActive:(UITapGestureRecognizer *)gesture{
    [self.window removeGestureRecognizer:_tapGesture];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dissMissAlertVC" object:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
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
