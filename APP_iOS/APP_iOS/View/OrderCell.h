//
//  OrderCell.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/3.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

@property (nonatomic, strong)IBOutlet UILabel *lblOrderNo;
@property (nonatomic, strong)IBOutlet UILabel *lblTime;
@property (nonatomic, strong)IBOutlet UIImageView *imvPortarit;
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblContent;
@property (nonatomic, strong)IBOutlet UILabel *lblState;
@property (nonatomic, strong)IBOutlet UILabel *lblCount;
@property (nonatomic, strong)IBOutlet UILabel *lblPay;
@end
