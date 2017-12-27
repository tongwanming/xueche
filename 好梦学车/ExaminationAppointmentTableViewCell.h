//
//  ExaminationAppointmentTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/12/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgressDataModel.h"

typedef void(^ExaminationAppointmentBlock)(UIButton *);

@interface ExaminationAppointmentTableViewCell : UITableViewCell

@property (nonatomic, strong) ProgressDataModel *model;
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;


@property (nonatomic, copy)ExaminationAppointmentBlock block;

- (void)ExaminationAppointmentWithBlock:(void(^)(UIButton *btn))block;

@end
