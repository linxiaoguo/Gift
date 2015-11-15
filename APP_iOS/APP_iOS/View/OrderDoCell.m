//
//  OrderDoCell.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/14.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "OrderDoCell.h"

@implementation OrderDoCell

- (void)awakeFromNib {
    _btnShow.layer.cornerRadius = 5.0;
    _btnShow.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnShow.layer.borderWidth = 1;
    [_btnShow setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _btnConfirm.layer.cornerRadius = 5.0;
    _btnConfirm.layer.borderColor = kRGBCOLOR(232, 88, 40).CGColor;
    _btnConfirm.layer.borderWidth = 1;
    [_btnConfirm setTitleColor:kRGBCOLOR(232, 88, 40) forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    switch (tag) {
        case 1: {
            if (self.showBlock)
                self.showBlock(self.row);
        }
            break;
        case 2: {
            if (self.confirmBlock)
                self.confirmBlock(self.row);
        }
            break;
        default:
            break;
    }
}
@end
