//
//  MyCodeViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MyCodeViewController.h"

@interface MyCodeViewController ()

@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"店铺二维码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _shopName.text = [ShareValue instance].shopModel.name;
    
    [[Http instance] shopQrcode:[ShareValue instance].shopModel.shopid.integerValue completion:^(NSError *error, NSString *shopAddr, NSString *qrcodeImg) {
        qrcodeImg = [qrcodeImg stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        [_codeImage sd_setImageWithURL:[NSURL URLWithString:qrcodeImg] placeholderImage:nil];
    }];

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

- (IBAction)saveAction:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_codeImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (IBAction)shareAction:(id)sender {

}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    NSString *msg = nil ;
    if(error != NULL) {
        msg = @"保存图片失败" ;
        [SVProgressHUD showErrorWithStatus:msg];
    }
    else {
        msg = @"保存图片成功" ;
        [SVProgressHUD showSuccessWithStatus:msg];
    }
}

@end
