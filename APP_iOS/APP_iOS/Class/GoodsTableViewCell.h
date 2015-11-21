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
    
    __weak IBOutlet UIImageView *_headImage;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_desLabel;
    __weak IBOutlet UILabel *_priceLabel;
    __weak IBOutlet UILabel *_saleLabel;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UIImageView *_accessImageView;
}

@property (nonatomic, strong) GoodModel *goodModel;

@end
