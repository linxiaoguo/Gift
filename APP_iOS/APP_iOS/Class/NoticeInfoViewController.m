//
//  NoticeInfoViewController.m
//  APP_iOS
//
//  Created by Li on 15/11/25.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "NoticeInfoViewController.h"

@interface NoticeInfoViewController ()

@end

@implementation NoticeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"公告详情";
    
    _titleLabel.text = _messageModel.msgtitle;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_messageModel.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _contentLabel.attributedText = attrStr;
    
    _timeLabel.text = [ShareFunction stringWithTimestamp1:_messageModel.msgtime];
    
    _aView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
    
    
    float contentH = [ShareFunction heightOfLabel:_contentLabel] + 20.0;
    contentH > 44 ? (_contentLabel.height = contentH) : (_contentLabel.height = 44);

    _aView.height = _contentLabel.bottom + 44;
    DLog(@"%@", NSStringFromCGRect(_aView.frame));

    for (UIView *view in _aView.subviews) {
        if (view.top > _contentLabel.top) {
            view.top = _contentLabel.bottom;
        }
    }
    _timeLabel.top = 200;
    _aView.hidden = NO;
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

@end
