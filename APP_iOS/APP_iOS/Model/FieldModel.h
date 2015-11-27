//
//  FieldModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FieldModel : NSObject

@property (nonatomic, assign)NSInteger fileId;
@property (nonatomic, strong)NSString *fileName;

@property (nonatomic, strong)NSString *fileAddr;//图片地址
@property (nonatomic, strong) NSData *fileData;

@end

