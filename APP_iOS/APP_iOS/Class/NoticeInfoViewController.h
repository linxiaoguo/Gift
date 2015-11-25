//
//  NoticeInfoViewController.h
//  APP_iOS
//
//  Created by Li on 15/11/25.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageModel.h"

@interface NoticeInfoViewController : BaseViewController {
    
    __weak IBOutlet UIView *_aView;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_contentLabel;
    __weak IBOutlet UILabel *_timeLabel;
}

@property (nonatomic, strong) MessageModel *messageModel;

@end
