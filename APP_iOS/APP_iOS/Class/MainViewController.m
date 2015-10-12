//
//  MainViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+Color.h"

#import "MyShopViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"天天好礼";
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"gg_bg"] withHighlightedImage:nil withBlock:^(NSInteger tag) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName: [UIColor blackColor],
                                     };
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barTintColor = kRGBCOLOR(0, 121, 198);
    
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - action

- (IBAction)myShopAction:(id)sender {
    MyShopViewController *vc = [[MyShopViewController alloc] initWithNibName:@"MyShopViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
