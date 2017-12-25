//
//  ApplyLocationTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffLineServerStation.h"

typedef void(^ApplyLocationTableViewCellBlock)(OffLineServerStation *);

@interface ApplyLocationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (nonatomic, copy)ApplyLocationTableViewCellBlock block;

@property (nonatomic, strong) OffLineServerStation *model;

/**
 * @brief 创建tableViewCell的类方法
 *
 * @param table 当前的tableView
 * @param identifier 当前创建的tableViewCell的标记
 */
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;

- (void)blockActiveWithBlock:(void(^)(OffLineServerStation *model))block;

@end
