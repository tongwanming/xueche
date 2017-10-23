//
//  ServiceStationDetailViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/10/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "OffLineServerStation.h"

@interface ServiceStationDetailViewController : BasicViewController

@property (nonatomic, strong)OffLineServerStation *model;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *address;

@end
