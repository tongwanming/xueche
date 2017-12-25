//
//  ApplyLocationViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ApplyLocationViewController.h"
#import "ApplyLocationTableViewCell.h"
#import "URLConnectionHelper.h"
#import "OffLineServerStation.h"
#import "CustomAlertView.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <MapKit/MapKit.h>

@interface ApplyLocationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ApplyLocationViewController{
    NSMutableArray *_data;
    OffLineServerStation *_model;
}
- (IBAction)btnclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    NSDictionary *dic = @{
                          @"city":@"重庆",
                          @"district":@"",
                          @"name":@"",
                          @"province":@"重庆"
                          };
    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:[NSString stringWithFormat:@"http://%@:7072/manage-service/serviceStation/findServiceStation",PUBLIC_LOCATION] andDic:dic andSuccessBlock:^(NSArray *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
        
        
        //                NSLog(@"%@",jsonDict);
        for (NSDictionary *dic in data) {
            OffLineServerStation *model = [[OffLineServerStation alloc] init];
            model.address = [dic objectForKey:@"address"];
            model.city = [dic objectForKey:@"city"];
            model.district = [dic objectForKey:@"district"];
            model.offLineServerId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            model.latitude = [dic objectForKey:@"latitude"];
            model.longitude = [dic objectForKey:@"longitude"];
            model.name = [dic objectForKey:@"name"];
            model.phone = [dic objectForKey:@"phone"];
            model.province = [dic objectForKey:@"province"];
            model.imageUrl = [dic objectForKey:@"imageUrl"];
            
            model.mapImageUrl = [dic objectForKey:@"mapImageUrl"];
            model.lightRailDes = [dic objectForKey:@"lightRailDes"];
            model.publicBusName = [dic objectForKey:@"publicBusName"];
            model.publicBusDes = [dic objectForKey:@"publicBusDes"];
            [_data addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andFiledBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indx = @"ind";
    ApplyLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indx];
    if (!cell) {
        cell = [ApplyLocationTableViewCell cellWithTableToDequeueReusable:tableView identifier:indx nibName:@"ApplyLocationTableViewCell"];
    }
    cell.model = _data[indexPath.row];
    [cell blockActiveWithBlock:^(OffLineServerStation *model) {
        _model = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [_model.latitude doubleValue];
            coordinate.longitude = [_model.longitude doubleValue];
            
            //test
            NSArray *arr = [self getInstalledMapAppWithAddr:_model.address withEndLocation:coordinate];
            [self showAlertViewWithData:arr andCoordinate:coordinate];
        });
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
