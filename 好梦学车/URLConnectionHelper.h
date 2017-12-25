//
//  URLConnectionHelper.h
//  好梦学车
//
//  Created by haomeng on 2017/6/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConnectionModel.h"

@interface URLConnectionHelper : NSObject


+(URLConnectionHelper *)shareDefaulte;


- (void)getPostDataWithUrl:(NSString *)urlstr andConnectModel:(URLConnectionModel *)model andSuccessBlock:(void(^)(NSData *data))successedBlock andFailedBlock:(void(^)(NSError *error))failedBlock;

//添加Token的post请求
- (void)loadTokenPostDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void(^)(NSArray *data))successBlock andFiledBlock:(void(^)(NSError *error))failedBlock;
//不添加Token的post请求
- (void)loadPostDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void(^)(NSArray *data))successBlock andFiledBlock:(void(^)(NSError *error))failedBlock;

//不添加Token的post请求
- (void)loadPostTwoDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void(^)(NSArray *data))successBlock andFiledBlock:(void(^)(NSError *error))failedBlock;

//不添加Token的post请求
- (void)loadPostDataWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andSuccessBlock:(void(^)(NSArray *data))successBlock andDicFiledBlock:(void(^)(NSDictionary *dic))failedBlock;

//get请求
- (void)loadGetDataWithUrl:(NSString *)urlStr andSuccessBlock:(void(^)(NSArray *data))successBlock andFiledBlock:(void(^)(NSError *error))failedBlock;

@end
