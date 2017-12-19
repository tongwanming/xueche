//
//  ManuallyLocateViewController2.h
//  好梦学车
//
//  Created by haomeng on 2017/10/23.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>

typedef void(^ManuallLocateBlock)(NSArray *,CLLocationCoordinate2D);

@interface ManuallyLocateViewController2 : BasicViewController

@property (nonatomic, strong) NSString *current;//为@“1”是新版本，nil 或则@“”为老版本

@property (nonatomic, copy)ManuallLocateBlock block;

- (void)manuallBlokcWithBlock:(void(^)(NSArray *data,CLLocationCoordinate2D p))block;

@end
