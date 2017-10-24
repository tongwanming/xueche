//
//  OffLineServerStation.h
//  好梦学车
//
//  Created by haomeng on 2017/6/22.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OffLineServerStation : NSObject

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *city;//城市
@property (nonatomic, strong) NSString *district;//地区
@property (nonatomic, strong) NSString *offLineServerId;//线下服务站id
@property (nonatomic, strong) NSString *imageUrl;//logoImage
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *mapImageUrl;//地图图片
@property (nonatomic, strong) NSString *lightRailDes;//地铁站
@property (nonatomic, strong) NSString *publicBusName;//公交站
@property (nonatomic, strong) NSString *publicBusDes;//公交线路


@end
