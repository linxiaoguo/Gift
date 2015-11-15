//
//  FieldModel.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "FieldModel.h"

@implementation FieldModel

- (NSString *)fileAddr {
    NSString *file = [_fileAddr stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    return file;
}

@end
