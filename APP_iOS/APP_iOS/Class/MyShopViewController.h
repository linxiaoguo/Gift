//
//  MyShopViewController.h
//  APP_iOS
//
//  Created by Li on 15/10/10.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface MyShopViewController : BaseViewController {
    
    __weak IBOutlet UIImageView *_headImage;
    __weak IBOutlet UILabel *_shopNameLabel;
    
    
}

@property (weak, nonatomic) IBOutlet UIButton *validateButton;

@end
