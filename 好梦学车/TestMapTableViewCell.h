//
//  TestMapTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstLocationModel.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>

typedef void(^testMapTableViewCellBlock)(UIButton *btn,FirstLocationModel *model);

@interface TestMapTableViewCell : UITableViewCell
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UIViewController *subVC;

@property (nonatomic, copy) testMapTableViewCellBlock block;

@property (nonatomic, assign) CLLocationCoordinate2D pt;

- (void)blcokActiveWithBlock:(void(^)(UIButton *btn,FirstLocationModel *model))block;
@end
