//
//  VersionModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/9.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionModel : NSObject


@property (nonatomic, strong)NSString *pagename;
@property (nonatomic, assign)NSInteger version;
@property (nonatomic, strong)NSString *downurl;
@property (nonatomic, assign)NSInteger size;
@property (nonatomic, strong)NSString *litpic;//app图标
@property (nonatomic, strong)NSString *info;//更新信息
@property (nonatomic, strong)NSString *versionname;
@property (nonatomic, assign)NSInteger status;//状态 0代表最新版本，1有更新，2强制更新
@end
