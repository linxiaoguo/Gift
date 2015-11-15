//
//  OrderDetailCell.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/14.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property (nonatomic, strong)IBOutlet UIImageView *imvIcon;
@property (nonatomic, strong)IBOutlet UILabel *lblDesc;
@property (nonatomic, strong)IBOutlet UILabel *lblSize;
@property (nonatomic, strong)IBOutlet UILabel *lblCount;
@property (nonatomic, strong)IBOutlet UILabel *lblFee;
@end
