//
//  FirstLocationTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstBasicTableViewCell.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

typedef void(^locationBlock)(NSArray *data);

typedef void(^locationBlockProvince)(NSString *province,NSString *address);

typedef void(^coordinate)(CLLocationCoordinate2D coordinate);

@protocol FirstLocationTableViewCellDelegate <NSObject>

- (void)firstLocationTableViewCellSubCellSelectActive:(NSIndexPath *)indexpath andData:(NSArray *)array;

- (void)searchActive;

@end

@interface FirstLocationTableViewCell : FirstBasicTableViewCell
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak)id<FirstLocationTableViewCellDelegate>delegate;

@property (nonatomic, copy)locationBlock block;

@property (nonatomic, copy) locationBlockProvince provinceBlock;

@property (nonatomic, copy) coordinate coordinate;

- (void)retunLoadDataWithBlock:(locationBlock)block;

- (void)retunLoadDataWithProvinceBlock:(locationBlockProvince)block;

- (void)returnCoordinateBlock:(coordinate)block;

@end
