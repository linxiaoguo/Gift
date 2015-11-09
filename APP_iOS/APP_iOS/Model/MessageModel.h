//
//  MessageModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic, assign)NSInteger msgid;
@property (nonatomic, strong)NSString *msgtitle;
@property (nonatomic, assign)NSTimeInterval msgtime;
@end
