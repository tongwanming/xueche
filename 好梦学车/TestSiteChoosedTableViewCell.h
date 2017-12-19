//
//  TestSiteChoosedTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestSiteChoosedModel.h"


typedef void(^TestSiteChoosedBlock)(TestSiteChoosedModel *);

@interface TestSiteChoosedTableViewCell : UITableViewCell

/**
 * @brief 创建tableViewCell的类方法
 *
 * @param table 当前的tableView
 * @param identifier 当前创建的tableViewCell的标记
 */
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;
@property (nonatomic, strong) TestSiteChoosedModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, copy) TestSiteChoosedBlock block;

- (void)TestSiteChoosedActive:(void(^)(TestSiteChoosedModel *model))block;

@end
