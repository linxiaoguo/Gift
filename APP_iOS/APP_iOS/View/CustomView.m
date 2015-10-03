//
//  CustomView.m
//  IntelliCommunity
//
//  Created by Diana on 12/24/14.
//  Copyright (c) 2014 evideo. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

+(id)viewWithNibName:(NSString* )nibName {
    if (!nibName) return nil;
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [array firstObject];
}

@end
