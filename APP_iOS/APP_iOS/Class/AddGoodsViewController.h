//
//  AddGoodsViewController.h
//  APP_iOS
//
//  Created by Li on 15/10/14.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface AddGoodsViewController : BaseViewController {
    
    __weak IBOutlet UITextField *_goodName;
    __weak IBOutlet UITextView *_goodsIntroTextView;
    __weak IBOutlet UISwitch *_recomendSwitch;
}

@property (nonatomic, assign) BOOL addNewGoods;
@property (nonatomic, strong) GoodModel *goodModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@end
