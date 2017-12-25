//
//  SubscribeTestModel.h
//  好梦学车
//
//  Created by haomeng on 2017/12/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeTestModel : NSObject

@property (nonatomic, strong) NSString *weeks;//星期几

@property (nonatomic, strong) NSString *examDate;//考试日期

@property (nonatomic, strong) NSString *examMonth;//考试月份

@property (nonatomic, strong) NSString *examLastr;//考试号数

@property (nonatomic, strong) NSMutableArray *subData;//某一天的具体情况

@property (nonatomic, assign) BOOL isCanUsed;

@end
