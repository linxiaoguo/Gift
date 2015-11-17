//
//  GoodsListViewController.h
//  APP_iOS
//
//  Created by Li on 15/11/17.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^GoodsListBlock)(NSObject *model);


@interface GoodsListViewController : BaseViewController

@property (nonatomic, assign) NSInteger type;

@property (copy) GoodsListBlock block;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
