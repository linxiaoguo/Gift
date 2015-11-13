//
//  MainViewController.h
//  APP_iOS
//
//  Created by Li on 15/10/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController {
    
    __weak IBOutlet UILabel *_incomeLabel;
    __weak IBOutlet UILabel *_orderLabel;
    __weak IBOutlet UILabel *_buyerLabel;
}


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
