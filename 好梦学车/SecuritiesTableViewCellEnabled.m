//
//  SecuritiesTableViewCellEnabled.m
//  好梦学车
//
//  Created by haomeng on 2017/11/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SecuritiesTableViewCellEnabled.h"

@implementation SecuritiesTableViewCellEnabled



- (void)awakeFromNib {
    [super awakeFromNib];
    _userBtn.layer.masksToBounds = YES;
    _userBtn.layer.cornerRadius = 12;
    _userBtn.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
    _userBtn.layer.borderWidth = 1;
    self.backgroundColor = F4F4F4;
//    self.contentView.backgroundColor = [CIColor clearColor];
    // Initialization code
    
}
- (IBAction)btnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SecuritiesTableViewCellEnabledClickWithModel:)]) {
        [self.delegate performSelector:@selector(SecuritiesTableViewCellEnabledClickWithModel:) withObject:_model];
    }
}

- (void)setModel:(SecuritiesModel *)model{
    _model = model;
}

- (void)setCanBeUsed:(BOOL)canBeUsed{
    _canBeUsed = canBeUsed;
    if (canBeUsed) {
        _imageViewa.image = [UIImage imageNamed:@"bg_card_normal"];
        _titleLabel.textColor = TEXT_COLOR;
        [_userBtn setTintColor:BLUE_BACKGROUND_COLOR];
        _userBtn.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
        _userBtn.userInteractionEnabled = YES;
        _securityLabel.backgroundColor = BLUE_BACKGROUND_COLOR;
    }else{
        _imageViewa.image = [UIImage imageNamed:@"bg_card_fail"];
        _titleLabel.textColor = AA6b7;
        [_userBtn setTitleColor:AA6b7 forState:UIControlStateNormal];
        _userBtn.layer.borderColor = AA6b7.CGColor;
        _userBtn.userInteractionEnabled = NO;
        _securityLabel.backgroundColor = AA6b7;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
