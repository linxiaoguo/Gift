//
//  ValidityDateViewController.h
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface ValidityDateViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *ValidityPeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (strong, nonatomic) IBOutlet UIView *monthView;

@end
