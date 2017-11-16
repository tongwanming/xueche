//
//  SecuritiesTableViewCellChoose.m
//  好梦学车
//
//  Created by haomeng on 2017/11/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SecuritiesTableViewCellChoose.h"

@implementation SecuritiesTableViewCellChoose

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = F4F4F4;
    // Initialization code
}

- (void)setModel:(SecuritiesModel *)model{
    _model = model;
    _securityLabel.text = model.couponName;
    _titleLabel.text = model.descriptiona;
    _priceLabel.text = model.couponPrice;
    _priceType.text = model.useCondition;
    _userTimeLabel.text = [NSString stringWithFormat:@"%@-%@",model.startTime,model.endTime];
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        _logoImage.image = [UIImage imageNamed:@"selextbox_choosepage_click"];
    }else{
        _logoImage.image = [UIImage imageNamed:@"selextbox_choosepage_normal"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
