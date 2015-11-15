//
//  GoodsTableViewCell.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "GoodsTableViewCell.h"

@implementation GoodsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoodModel:(GoodModel *)goodModel {
    _goodModel = goodModel;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:goodModel.pic] placeholderImage:[UIImage imageNamed:@"cpxqq"]];
    _nameLabel.text = goodModel.name;
    _desLabel.text = goodModel.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", goodModel.price];
    _saleLabel.text = [NSString stringWithFormat:@"销量 %d    库存 %d", goodModel.sales, goodModel.stock];
    _timeLabel.text = [NSString stringWithFormat:@"添加时间 %@", [ShareFunction stringWithTimestamp:goodModel.addtime]];

}

@end
