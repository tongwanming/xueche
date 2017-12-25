//
//  DoDriveExerciseViewControllerCell.h
//  好梦学车
//
//  Created by haomeng on 2017/12/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoDriveExerciseModel.h"


@interface DoDriveExerciseViewControllerCell : UITableViewCell

+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;

@property (nonatomic, strong) DoDriveExerciseModel *model;
@property (weak, nonatomic) IBOutlet UILabel *currentType;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *cocoaNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateLabel;

@end
