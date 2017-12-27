//
//  DoDriveExerciseModel.h
//  好梦学车
//
//  Created by haomeng on 2017/12/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoDriveExerciseModel : NSObject


@property (nonatomic, assign) float currentId;//id

@property (nonatomic, strong) NSString *stuId;//学员id

@property (nonatomic, strong) NSString *studentName;//学员name

@property (nonatomic, strong) NSString *subject;//当前科目

@property (nonatomic, strong) NSString *coachUserId;//教练id

@property (nonatomic, strong) NSString *cocoaName;//教练名字

@property (nonatomic, assign) float trainPlaceId;//场地id

@property (nonatomic, strong) NSString *trainPlaceName;//场地名称

@property (nonatomic, strong) NSString *recordRemark;//评价内容

@property (nonatomic, strong) NSString *signTime;//评价时间

@property (nonatomic, assign) float evaluateId;

@property (nonatomic, strong) NSString *evaluateRemark;

@property (nonatomic, assign) float totalityStars;

@property (nonatomic, assign) float qualityStars;

@property (nonatomic, assign) float serviceStars;

@property (nonatomic, assign) float planStars;

@property (nonatomic, assign) BOOL isEvaluate;

@property (nonatomic, strong) NSString *evaluateTime;

@end
