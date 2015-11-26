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
    __weak IBOutlet UITextField *_goodPrice;
    __weak IBOutlet UITextField *_goodNum;
    __weak IBOutlet UISwitch *_recomendSwitch;
    __weak IBOutlet UIButton *_typeButton;
    __weak IBOutlet UIButton *_topicButton;
    __weak IBOutlet UIButton *_downOrUpButton;
}

@property (nonatomic, assign) BOOL addNewGoods;
@property (nonatomic, strong) GoodModel *goodModel;

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIView *footerView1;

@end
