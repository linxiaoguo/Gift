//
//  MessageModel.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (void)setMsgtime:(NSString *)msgtime {
    _msgtime = msgtime;
    if (msgtime.length > 10) {
        _msgtime = [msgtime substringToIndex:10];
    }
}

@end
