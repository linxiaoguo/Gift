//
//  OrderDoCell.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/14.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showLogistics)(NSInteger row);
typedef void(^confirmGoods)(NSInteger row);

@interface OrderDoCell : UITableViewCell

@property (nonatomic, strong)IBOutlet UIButton *btnShow;
@property (nonatomic, strong)IBOutlet UIButton *btnConfirm;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, copy)showLogistics showBlock;
@property (nonatomic, copy)confirmGoods confirmBlock;
@end
