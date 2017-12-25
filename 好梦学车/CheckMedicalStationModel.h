//
//  CheckMedicalStationModel.h
//  好梦学车
//
//  Created by haomeng on 2017/12/22.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheckMedicalStationModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *distance;

@property (nonatomic, assign) double latitude;

@property (nonatomic, assign) double longitude;

@end
