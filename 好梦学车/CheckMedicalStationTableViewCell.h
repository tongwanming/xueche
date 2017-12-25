//
//  CheckMedicalStationTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CheckMedicalStationModel.h"

typedef void(^CheckMedicalStationBlock)(CheckMedicalStationModel *);

@interface CheckMedicalStationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

/**
 * @brief 创建tableViewCell的类方法
 *
 * @param table 当前的tableView
 * @param identifier 当前创建的tableViewCell的标记
 */
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;

@property (nonatomic, strong) CheckMedicalStationModel *model;

@property (nonatomic, copy) CheckMedicalStationBlock block;

- (void)cellBtnClickActiveWith:(void(^)(CheckMedicalStationModel *model))block;

@end
