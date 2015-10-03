//
//  InteractivePopViewController.h
//  IOS
//
//  Created by Li on 14-5-9.
//  Copyright (c) 2014年 Lihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractivePopNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;


@end
