//
//  GoodsClassModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/25.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

//商品分类
@interface GoodsClassModel : NSObject
@property (nonatomic, assign)NSInteger id;//分类id
@property (nonatomic, strong)NSString *name;//分类名称
@property (nonatomic, assign)NSInteger level;//分类名称
@property (nonatomic, assign)NSInteger subNum;//分类名称
@end
