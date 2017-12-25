//
//  DoDriveExerciseModel.h
//  好梦学车
//
//  Created by haomeng on 2017/12/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoDriveExerciseModel : NSObject

@property (nonatomic, strong) NSString *currentType;//当前科目

@property (nonatomic, strong) NSString *time;//打卡时间

@property (nonatomic, strong) NSString *location;//训练场名字

@property (nonatomic, strong) NSString *cocoaName;//教练名字

@property (nonatomic, strong) NSString *stateName;//已评价、未评价

@end
