//
//  DefineConfig.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#ifndef APP_iOS_DefineConfig_h
#define APP_iOS_DefineConfig_h

#define kAppName                    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]
#define kAppVersion                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppBuildVersion            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define kDefaultHeadImage           [UIImage imageNamed:@"默认头像.png"]

#define kScreenBounds               [[UIScreen mainScreen] bounds]
#define kScreenWidth                kScreenBounds.size.width
#define kScreenHeight               kScreenBounds.size.height

#define kAppDelegate                ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#ifdef DEBUG
#define DLog(fmt, ...)              NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define kSystemVersion              [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIOS7OrLater                (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

#define kUSER_DEFAULT               [NSUserDefaults standardUserDefaults]

#define kWEAKSELF                   __weak __typeof(self) weakSelf = self

#pragma mark - color functions

#define kRGBCOLOR(r,g,b)            [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kRGBACOLOR(r,g,b,a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kUIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif
