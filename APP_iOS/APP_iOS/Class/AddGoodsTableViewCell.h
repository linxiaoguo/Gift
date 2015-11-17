//
//  AddGoodsTableViewCell.h
//  APP_iOS
//
//  Created by Li on 15/10/15.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGoodsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *stockTextField;

@property (strong, nonatomic) IBOutlet UIButton *delButton;

@end
