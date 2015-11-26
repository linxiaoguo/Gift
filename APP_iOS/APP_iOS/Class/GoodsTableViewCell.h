//
//  GoodsTableViewCell.h
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"

@interface GoodsTableViewCell : UITableViewCell {
    
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_desLabel;
    __weak IBOutlet UILabel *_priceLabel;
    __weak IBOutlet UILabel *_saleLabel;
    __weak IBOutlet UILabel *_timeLabel;
}

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (nonatomic, strong) GoodModel *goodModel;
@property (nonatomic, strong) IBOutlet UIImageView *accessImageView;

@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;


@end
