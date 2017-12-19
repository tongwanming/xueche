//
//  CreateViewByDataAvtive.h
//  好梦学车
//
//  Created by haomeng on 2017/12/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgressDataModel.h"

typedef void(^CreateViewByDataAvtiveBlock)(NSMutableArray *);

@interface CreateViewByDataAvtive : NSObject

@property (nonatomic, copy)CreateViewByDataAvtiveBlock block;

+(CreateViewByDataAvtive *)shareDefaulte;

/**
 * model 传入的数据
 * progress 字符串“0～6” 表示入籍到考试完成
 * subgrogress 字符串“0～n” 表示在progress 的前提下的进程
 */
- (void)getViewDataWithModel:(ProgressDataModel *)model
                 andProgress:(NSString *)progrss
              andSubProgress:(NSString *)subProgress
                    andBlock:(void(^)(NSMutableArray *add))block;

@end
