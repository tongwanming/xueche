//
//  SecuritiesTableViewCellChoose.h
//  好梦学车
//
//  Created by haomeng on 2017/11/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstBasicTableViewCell.h"
#import "SecuritiesModel.h"

@interface SecuritiesTableViewCellChoose : FirstBasicTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewa;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceType;
@property (weak, nonatomic) IBOutlet UILabel *userTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *securityLabel;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) SecuritiesModel *model;
@end
