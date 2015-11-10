//
//  MarketViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/10.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MarketViewCtr.h"
#import "TestHttpViewCtr.h"

@interface MarketViewCtr ()

@end

@implementation MarketViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)testHttp:(id)sender {
    TestHttpViewCtr *vc = [[TestHttpViewCtr alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
