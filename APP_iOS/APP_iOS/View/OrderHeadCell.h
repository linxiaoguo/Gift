//
//  OrderHeadCell.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/3.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeadCell : UITableViewCell

@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblCount;
@property (nonatomic, strong)IBOutlet UIButton *btnBg;
@property (nonatomic, strong)IBOutlet UIImageView *imvLine;

- (void)setSelected:(BOOL)selected;
@end
