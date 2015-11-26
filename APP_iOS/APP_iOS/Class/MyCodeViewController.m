//
//  MyCodeViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MyCodeViewController.h"
#import "UMSocial.h"

@interface MyCodeViewController () <UMSocialUIDelegate>

@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"店铺二维码";
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
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
    NSString *shareText = [ShareValue instance].shopModel.name;             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:[ShareValue instance].shopModel.pic.fileAddr];          //分享内嵌图片
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"564a844ee0f55ad251008b90"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline]
                                       delegate:self];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    NSString *msg = nil ;
    if(error != NULL) {
        msg = @"下载失败" ;
        [SVProgressHUD showErrorWithStatus:msg];
    }
    else {
        msg = @"下载成功" ;
        [SVProgressHUD showSuccessWithStatus:msg];
    }
}

@end
