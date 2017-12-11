//
//  TestMapTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "TestMapTableViewCell.h"

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Radar/BMKRadarOption.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearchOption.h>
#import <BaiduMapAPI_Search/BMKRouteSearchType.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

@interface TestMapTableViewCell()<BMKMapViewDelegate,BMKLocationServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;
@end

@implementation TestMapTableViewCell{
    BMKMapView *_mapView;
    BMKLocationService *_locServer;
}

+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName
{
    if (table) {
        id reused = [table dequeueReusableCellWithIdentifier:identifier];
        if (reused) return reused;
    }
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createMapView];
}

- (void)createMapView{
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width,CURRENT_BOUNDS.height-164-44)];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.delegate = self;
        [_mapView setTrafficEnabled:YES];
    [_mapView setZoomLevel:6.0];
    [self addSubview:_mapView];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    _mapView.buildingsEnabled = YES;
    _mapView.overlookEnabled = YES;
    _mapView.showMapScaleBar = NO;
    //    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    
    //    _mapView.overlooking = -45;
    
    
    
    _locServer = [[BMKLocationService alloc] init];
    _locServer.delegate = self;
    [_locServer startUserLocationService];
    

}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
   
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        
    }
    [_mapView setZoomLevel:17.0];
    
    
    [_locServer stopUserLocationService];//定位完成停止位置更新
    
    //添加当前位置的标注 //展示定位
    _mapView.showsUserLocation = YES;
    
    //更新位置数据
    [_mapView updateLocationData:userLocation];
    CLLocationCoordinate2D coord;
    coord.latitude = userLocation.location.coordinate.latitude;
    coord.longitude = userLocation.location.coordinate.longitude;
    //    _currentLocation = coord;
    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
    _pointAnnotation.coordinate = coord;
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){coord.latitude,coord.longitude};
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView setCenterCoordinate:coord animated:true];
        [_mapView addAnnotation:_pointAnnotation];
        
    });
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
   
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    _userLocationState = userLocation;
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"%u",error
          );
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"当前位置%@",result.address);
    
        
    }
}


- (void)viewWillAppear:(BOOL)animated{
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locServer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locServer.delegate = nil;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
