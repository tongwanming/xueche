//
//  SecuritiesTableViewCellEnabled.h
//  好梦学车
//
//  Created by haomeng on 2017/11/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstBasicTableViewCell.h"
#import "SecuritiesModel.h"

@protocol SecuritiesTableViewCellEnabledDelegate<NSObject>
- (void)SecuritiesTableViewCellEnabledClickWithModel:(SecuritiesModel *)model;
@end

@interface SecuritiesTableViewCellEnabled : FirstBasicTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewa;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceType;
@property (weak, nonatomic) IBOutlet UILabel *userTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UILabel *securityLabel;

@property (nonatomic, assign) BOOL canBeUsed;
@property (nonatomic, strong) SecuritiesModel *model;
@property (nonatomic, weak) id<SecuritiesTableViewCellEnabledDelegate>delegate;

@end
