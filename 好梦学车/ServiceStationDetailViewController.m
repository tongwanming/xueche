//
//  ServiceStationDetailViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/10/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ServiceStationDetailViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <MapKit/MapKit.h>
#import "CustomAlertView.h"
#import "UIImageView+WebCache.h"

@interface ServiceStationDetailViewController ()

@end

@implementation ServiceStationDetailViewController


- (IBAction)btnClick:(id)sender {

    UIButton *btn = sender;
    if (btn.tag == 1001) {
      
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(btn.tag == 1002){
        //自带地图
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [_model.latitude doubleValue];
        coordinate.longitude = [_model.longitude doubleValue];
        
        //test
        NSArray *arr = [self getInstalledMapAppWithAddr:_model.address withEndLocation:coordinate];
        [self showAlertViewWithData:arr andCoordinate:coordinate];
    }else{
        //拨打电话
        [CustomAlertView showAlertViewWithVC:self];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        [CustomAlertView hideAlertView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CLLocationCoordinate2D coordinate2D;
//    coordinate2D.latitude = [_model.latitude doubleValue];
//    coordinate2D.longitude = [_model.longitude doubleValue];
//    [self getInstalledMapAppWithAddr:_model.address withEndLocation:coordinate2D];
    [self refreshData];
}

- (void)refreshData{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.mapImageUrl] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = _model.name;
    _addressLabel.text = _model.address;
    _addressLabel.font = [UIFont systemFontOfSize:15*TYPERATION];
    _bigTitleLabel.text = [NSString stringWithFormat:@"好梦学车—%@",_model.name];
    _bigTitleLabel.font = [UIFont systemFontOfSize:21*TYPERATION];
    _phoneLabel.text = [NSString stringWithFormat:@"电话：%@",_model.phone];
    _phoneLabel.font = [UIFont systemFontOfSize:15*TYPERATION];
    _metroLine.text = [NSString stringWithFormat:@"轻轨：%@",_model.lightRailDes];
    _metroLine.font = [UIFont systemFontOfSize:15*TYPERATION];
    _busStationNameLabel.text = [NSString stringWithFormat:@"公交：%@",_model.publicBusName];
    _busStationNameLabel.font = [UIFont systemFontOfSize:15*TYPERATION];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 13;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15*TYPERATION],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _allBusLine.attributedText = [[NSAttributedString alloc] initWithString:_model.publicBusDes attributes:attributes];
    _allBusLine.textColor = UNMAIN_TEXT_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSArray *)getInstalledMapAppWithAddr:(NSString *)addrString withEndLocation:(CLLocationCoordinate2D)endLocation

{
    
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    
    iosMapDic[@"title"] = @"苹果地图";
    
    [maps addObject:iosMapDic];
    
    NSString *appStr = NSLocalizedString(@"app_name", nil);
    
    //高德地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        
        gaodeMapDic[@"title"] = @"高德地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dname=%@&dev=0&t=2",appStr ,addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        gaodeMapDic[@"url"] = urlString;
        
        [maps addObject:gaodeMapDic];
        
    }
    
    //百度地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        
        baiduMapDic[@"title"] = @"百度地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=我的位置&destination=%@&mode=walking&src=%@",addrString ,appStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        baiduMapDic[@"url"] = urlString;
        
        [maps addObject:baiduMapDic];
        
    }
    
    //腾讯地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        
        qqMapDic[@"title"] = @"腾讯地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=walk&tocoord=%f,%f&to=%@&coord_type=1&policy=0",endLocation.latitude , endLocation.longitude ,addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        qqMapDic[@"url"] = urlString;
        
        [maps addObject:qqMapDic];
        
    }
    
    //谷歌地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        
        googleMapDic[@"title"] = @"谷歌地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%@&directionsmode=walking",addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        googleMapDic[@"url"] = urlString;
        
        [maps addObject:googleMapDic];
        
    }
    
    return maps;
    
}

-(void)showAlertViewWithData:(NSArray *)data andCoordinate:(CLLocationCoordinate2D)coordinate{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"地图" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = data[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:[dic objectForKey:@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"百度地图"]) {
                //    百度地图
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=%@&mode=driving&coord_type=bd09ll", _model.latitude,_model.longitude,_model.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
            }else if ([action.title isEqualToString:@"高德地图"]){
                //高德地图
                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",coordinate.latitude,coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
            }else if ([action.title isEqualToString:@"谷歌地图"]){
                //谷歌地图
                NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"好梦学车",@"",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else{
                //苹果自带地图
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
                
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                               MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            }
            NSLog(@"%@",action.title);
        }];
        
        [v addAction:action];
    }
    UIAlertAction *active1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active1];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}



@end
