//
//  AppDelegate.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "InteractivePopNavigationController.h"
#import "UIImage+Color.h"
#import "KeyboardManager.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "MobClick.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];

    [UMSocialData setAppKey:@"564a844ee0f55ad251008b90"];
    [UMSocialWechatHandler setWXAppId:@"wx88ed82fea38f73c8" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    [MobClick startWithAppkey:@"564a844ee0f55ad251008b90" reportPolicy:BATCH channelId:@"Web"];

    [self customizeInterface];
    
    if ([ShareValue instance].shopModel && [ShareValue instance].loginName) {
        [self showMainViewController];
    }
    else {
        [self showLoginViewController];
    }

    return YES;
}

//NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
//UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
//
////调用快速分享接口
//[UMSocialSnsService presentSnsIconSheetView:self
//                                     appKey:UmengAppkey
//                                  shareText:shareText
//                                 shareImage:shareImage
//                            shareToSnsNames:@[UMShareToSina, UMShareToTencent,UMShareToRenren]
//                                   delegate:self];

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - Private Methods

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBarTintColor:kRGBCOLOR(254, 84, 0)];
    [navigationBarAppearance setTranslucent:NO];
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
        [navigationBarAppearance setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [navigationBarAppearance setShadowImage:[[UIImage alloc] init]];
    }

    //设置naviegationBar的文本属性
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)showLoginViewController {
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *nav = [[InteractivePopNavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)showMainViewController {
    MainViewController *vc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *nav = [[InteractivePopNavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)loginAction {
    [[Http instance] login:[ShareValue instance].loginName pwd:[ShareValue instance].loginPwd completion:^(NSError *error, ShopModel *shop) {
        if (error.code == 0) {
            [ShareValue instance].shopModel = shop;
        }
    }];
}

@end
