//
//  DES3Util.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/15.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject {
    
}

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end