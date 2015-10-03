//
//  OrderHeadCell.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/3.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "OrderHeadCell.h"

@implementation OrderHeadCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        _lblTitle.textColor = [UIColor redColor];
        _lblCount.textColor = [UIColor redColor];
        _btnBg.backgroundColor = [UIColor whiteColor];
    } else {
        _lblTitle.textColor = [UIColor blackColor];
        _lblCount.textColor = [UIColor blackColor];
        _btnBg.backgroundColor = [UIColor clearColor];
    }
}
@end
