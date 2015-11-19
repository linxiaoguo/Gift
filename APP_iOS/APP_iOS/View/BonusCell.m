//
//  BonusCell.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/4.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BonusCell.h"

@interface BonusCell ()

@property (nonatomic, strong)IBOutlet UIButton *btnBonus;
@end

@implementation BonusCell

- (void)awakeFromNib {
    _btnBonus.layer.cornerRadius = 3.0;
    _btnBonus.layer.borderWidth = 1.0;
    _btnBonus.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)bonusAction:(id)sender {
    if (self.block)
        self.block(self.row);
}
@end
