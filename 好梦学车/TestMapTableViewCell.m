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


#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件


#import "EventCoachView.h"

@interface TestMapTableViewCell()<BMKMapViewDelegate,BMKLocationServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;
@end

@implementation TestMapTableViewCell{
    BMKMapView *_mapView;
    BMKLocationService *_locServer;
    NSInteger _tag;
    UIButton *_searchBtn;
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
    _tag = 0;
     [self createMapView];
}

- (void)createMapView{
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width,CURRENT_BOUNDS.height-164-44)];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.delegate = self;
        [_mapView setTrafficEnabled:YES];
    [_mapView setZoomLevel:25];
    [self addSubview:_mapView];
    _mapView.minZoomLevel = 0.2;
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    _mapView.buildingsEnabled = YES;
    _mapView.overlookEnabled = YES;
    _mapView.showMapScaleBar = YES;
    //    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    
    //    _mapView.overlooking = -45;
    
    
    
    _locServer = [[BMKLocationService alloc] init];
    _locServer.delegate = self;
    [_locServer startUserLocationService];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(16*TYPERATION, CURRENT_BOUNDS.height-164-44-42-27, CURRENT_BOUNDS.width-16*2*TYPERATION, 42*TYPERATION);
    _searchBtn.backgroundColor = [UIColor whiteColor];
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.layer.cornerRadius = 6;
    [_searchBtn setTitle:@"请输入您想练车的区域" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_searchBtn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.tag = 1001;
    [self addSubview:_searchBtn];
    
    UIButton *locationBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtm.frame = CGRectMake(CURRENT_BOUNDS.width - 44-16*TYPERATION, CURRENT_BOUNDS.height-164-44-42-27-44, 44, 44);
    locationBtm.backgroundColor = [UIColor clearColor];
    [locationBtm setImage:[UIImage imageNamed:@"btn_urrentlocation"] forState:UIControlStateNormal];
    locationBtm.titleLabel.font = [UIFont systemFontOfSize:18];
    [locationBtm addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    locationBtm.tag = 1002;
    [self addSubview:locationBtm];
    
}

- (void)setData:(NSMutableArray *)data{
    _tag = 0;
    _data = data;
   
     [_locServer stopUserLocationService];
    [_locServer startUserLocationService];
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    for (FirstLocationModel *model in _data) {
//        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//
//        CLLocationCoordinate2D coor;
//        coor.latitude = [model.latitude doubleValue];
//        coor.longitude = [model.longitude doubleValue];
//        annotation.coordinate = coor;
//        annotation.title = model.name;
//        [arr addObject:annotation];
//    }
//
//    [_mapView addAnnotations:arr];
}

- (void)setPt:(CLLocationCoordinate2D)pt{
    _pt = pt;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    _tag = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
    });
    BMKCoordinateRegion region;
    
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
   
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        
    }
    [_mapView setZoomLevel:14.0];
    
    
    [_locServer stopUserLocationService];//定位完成停止位置更新
    
    //添加当前位置的标注 //展示定位
    _mapView.showsUserLocation = YES;
    
    //更新位置数据
    
    [_mapView updateLocationData:userLocation];
    CLLocationCoordinate2D coord;
    if (_pt.latitude) {
        coord = _pt;
        [self getDataActiveWithPt:coord];
    }else{
        coord.latitude = userLocation.location.coordinate.latitude;
        coord.longitude = userLocation.location.coordinate.longitude;
        [self getDataActiveWithPt:coord];
    }
    
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

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    
    //如果是注释点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        //根据注释点,创建并初始化注释点视图
        BMKPinAnnotationView  *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        newAnnotation.tag = _tag;
        _tag++;
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorGreen;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvtive:)];
        tap.view.tag = _tag;
        
        [newAnnotation addGestureRecognizer:tap];
        
        
        //设置动画
        newAnnotation.animatesDrop = YES;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.text = @"起点";
        label.textColor = TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
        NSLog(@"%@---titlr:%@",annotation,annotation.title);
        //设置图片
        
        if (newAnnotation.tag > 0) {
            newAnnotation.image = [UIImage imageNamed:@"btn_sign"];
        }else{
            newAnnotation.image = [UIImage imageNamed:@"img_currentlocation"];
        }
        
        newAnnotation.contentMode = UIViewContentModeScaleAspectFit;
        
        newAnnotation.canShowCallout = YES;
        
        newAnnotation.frame = CGRectMake(0, 0, 50, 50);
        
        if (annotation.title && [annotation.title isEqualToString:@"起点"]) {
            newAnnotation.selected = YES;
        }else{
            newAnnotation.selected = NO;
        }
        
        return newAnnotation;
        
    }
    
    return nil;
}

- (void)tapAvtive:(UITapGestureRecognizer *)tap{
     NSLog(@"tag:%ld",(long)tap.view.tag);
    if (tap.view.tag == 0) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[EventCoachView shareDefault] showEventCoachViewWithVC:_subVC andModel:_data[tap.view.tag-1] andBlock:^(UIButton *btn) {
            if (_block) {
                _block(btn,_data[tap.view.tag-1]);
            }
        }];
    });
    
}

- (void)btnClickActive:(UIButton *)btn{
    if (btn.tag == 1001) {
        if (_block) {
            _block(btn,nil);
        }
    }else if (btn.tag == 1002){
        [_locServer stopUserLocationService];
        [_data removeAllObjects];
        _pt.latitude = 0;
        [_locServer startUserLocationService];
    }
    else{
        
    }
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"tag:%ld",(long)view.tag);
}

- (void)blcokActiveWithBlock:(void (^)(UIButton *, FirstLocationModel *))block{
    _block = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//获取数据
- (void)getDataActiveWithPt:(CLLocationCoordinate2D)pt {
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    NSDictionary *dic = @{@"longitude":[NSString stringWithFormat:@"%f",pt.longitude],
                          @"latitude":[NSString stringWithFormat:@"%f",pt.latitude],
                          @"displayNum":@10};

    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSURL *url = [NSURL URLWithString:urlstr];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:7072/manage-service/trainplace/listByCoords",PUBLIC_LOCATION]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    //    [CustomAlertView showAlertViewWithVC:self];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [jsonDict objectForKey:@"success"];
            //            [CustomAlertView hideAlertView];
            if ([str boolValue]) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *_success = [jsonDict objectForKey:@"data"];
                    if (_data) {
                        [_data removeAllObjects];
                    }
                    for (NSDictionary *dic in _success) {
                        FirstLocationModel *model = [[FirstLocationModel alloc] init];
                        model.currentId = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"id"]];
                        model.descrip = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"descrip"]];
                        
                        model.trainDrivingLicense = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"trainDrivingLicense"]];
                        model.contactPersonPhone = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"contactPersonPhone"]];
                        model.trainSubjects = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"trainSubjects"]];
                        model.contactPersonName = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"contactPersonName"]];
                        model.province = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"province"]];
                        model.longitude = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"longitude"]];
                        model.latitude =[NSString stringWithFormat:@"%@",[dic objectForSubKey:@"latitude"]];
                        model.pictures = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"pictures"]];
                        model.belongSchool =[NSString stringWithFormat:@"%@",[dic objectForSubKey:@"belongSchool"]];
                        model.address = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"descrip"]];
                        model.city = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"city"]];
                        model.addTime = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"addTime"]];
                        model.district = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"district"]];
                        model.distance = [NSString stringWithFormat:@"距你%.2lfkm",[[dic objectForKey:@"distance"] floatValue]];
                        model.name = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"name"]];
                        model.updateTime = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"updateTime"]];
                        [_data addObject:model];
                    }
                    
                    
                    
                    [self refreshLocationView];
                });
                
            }else{
                
                
            }
        }else{
            //            [CustomAlertView hideAlertView];
        }
    }];
    [dataTask resume];
}

- (void)refreshLocationView{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (FirstLocationModel *model in _data) {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        
        CLLocationCoordinate2D coor;
        coor.latitude = [model.latitude doubleValue];
        coor.longitude = [model.longitude doubleValue];
        annotation.coordinate = coor;
        annotation.title = model.name;
        [arr addObject:annotation];
    }
    
    [_mapView addAnnotations:arr];
}

@end
