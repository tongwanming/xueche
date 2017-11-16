//
//  FirstCatStyleModel.h
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstCatStyleModel : NSObject

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *backGroundImageName;

@property (nonatomic, strong) NSString *price2;

@property (nonatomic, strong) NSString *isInstalments;

@property (nonatomic, strong) NSString *categoryCode;//版型代号

@property (nonatomic, strong) NSString *projectTypeCode;//C1,C2代号
@property (nonatomic, strong) NSString *productCode1;//对应C1、C2的编码
@property (nonatomic, strong) NSString *productCode2;//对应C1、C2的编码

@end
