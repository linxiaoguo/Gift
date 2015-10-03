//
//  AudioPlayerInstance.h
//  XMU1.0
//
//  Created by lihj on 14-5-6.
//  Copyright (c) 2014年 DongXM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface ShareValue : NSObject  {

}

+ (ShareValue *)instance;

@property (nonatomic, copy) NSString *loginUserId;
@property (nonatomic, assign) AFNetworkReachabilityStatus netWorkStatus;

@end
