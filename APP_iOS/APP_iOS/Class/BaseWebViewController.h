//
//  BaseWebViewController.h
//  APP_iOS
//
//  Created by Li on 15/8/29.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface BaseWebViewController : BaseViewController <UIWebViewDelegate, NJKWebViewProgressDelegate>


@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSURL *url;

@end

