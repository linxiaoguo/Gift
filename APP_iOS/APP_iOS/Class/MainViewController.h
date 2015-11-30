//
//  MainViewController.h
//  APP_iOS
//
//  Created by Li on 15/10/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController {
    
    __weak IBOutlet UIImageView *_headImage;
    __weak IBOutlet UILabel *_shopNameLabel;
    __weak IBOutlet UILabel *_incomeLabel;
    __weak IBOutlet UILabel *_orderLabel;
    __weak IBOutlet UILabel *_buyerLabel;
}
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *head;

@property (weak, nonatomic) IBOutlet UIView *_bottomViewV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
