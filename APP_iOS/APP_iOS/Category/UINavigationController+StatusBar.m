//
//  UINavigationController+StatusBar.m
//  YiClock
//
//  Created by Li on 15/10/8.
//  Copyright © 2015年 CivetCatsTeam. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

@end
