//
//  ProgressDataModel.h
//  好梦学车
//
//  Created by haomeng on 2017/12/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//此为获取当前学员的数据模型

@interface ProgressDataModel : NSObject

/** 学员id */
@property (nonatomic, strong) NSString *userId;

/** 学员状态（0 待报名 1 待陪 2 在培 3 毕业 4  转校 5 退学） */
@property (nonatomic, strong) NSString *status;

/** 学员所处阶段（报名 入籍  科目一  科目二  科目三  科目四  毕业 ） */
@property (nonatomic, strong) NSString *belongPeriod;

/** 学员所处阶段编号（0 - 6） */
@property (nonatomic, strong) NSString *periodNum;

/** 学员真实姓名 */
@property (nonatomic, strong) NSString *realName;

/** 学员昵称 */
@property (nonatomic, strong) NSString *nickName;

/** 学员头像 */
@property (nonatomic, strong) NSString *headPicture;

/** 学员电话 */
@property (nonatomic, strong) NSString *phone;

/** 班型编码 */
@property (nonatomic, strong) NSString *classTypeCode;

/** 班型名称 */
@property (nonatomic, strong) NSString *classTypeName;

/** 车型编码 */
@property (nonatomic, strong) NSString *carTypeCode;

/** 车型名称 */
@property (nonatomic, strong) NSString *carTypeName;




/*******************外部系统信息******************/

/** 外部系统学员状态 IC卡已发放 */
@property (nonatomic, strong) NSString *cwStatus;

/** 外部系统科目一学习有效时长 */
@property (nonatomic, assign) NSInteger cwSubjectOneValidTime;

/** 外部系统科目二学习有效时长 */
@property (nonatomic, assign) NSInteger cwSubjectTwoValidTime;

/** 外部系统科目三学习有效时长 */
@property (nonatomic, assign) NSInteger cwSubjectThreeValidTime;

/** 外部系统科目一培训时长 */
@property (nonatomic, assign) NSInteger cwSubjectOneTrainTime;

/** 外部系统科目二培训时长 */
@property (nonatomic, assign) NSInteger cwSubjectTwoTrainTime;

/** 外部系统科目三培训时长 */
@property (nonatomic, assign) NSInteger cwSubjectThreeTrainTime;

/** 外部系统审核状态 待受理、办结、退办 */
@property (nonatomic, strong) NSString *govCheckStatus;

/** 外部系统失败原因 */
@property (nonatomic, strong) NSString *govFailReason;




/*******************学习进度信息******************/

/** 学习科目 */
@property (nonatomic, strong) NSString *subject;

/** 学员学习状态（0 未开始 1 学习中 2 可约考 3 约考中 4 通过） */
@property (nonatomic, strong) NSString *studyStatus;

/** 开始学习时间 */
@property (nonatomic, strong) NSDate *studyStartTime;

/** 学习结束时间 */
@property (nonatomic, strong) NSDate *studyEndTime;

/** 当前是否有考试预约信息(0 表示没有 1表示有) */
@property (nonatomic, assign) BOOL examStatus;

/** 最后一次考试分数 */
@property (nonatomic, strong) NSString *lastExamScore;

/** 下次可预约考试期限（第一次考试未通过） */
@property (nonatomic, strong) NSDate *examTimeLimit;


@end
