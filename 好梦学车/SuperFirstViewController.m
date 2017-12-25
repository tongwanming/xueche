//
//  SuperFirstViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SuperFirstViewController.h"
#import "FirstViewController.h"

#import "SubjectOneCurrentViewController.h"
#import "CustomAlertView.h"
#import "URLConnectionHelper.h"
#import <CoreLocation/CoreLocation.h>

@interface SuperFirstViewController ()<FirstViewControllerDelegate,SubjectOneCurrentViewControllerDelegate,CLLocationManagerDelegate>

@end

@implementation SuperFirstViewController{
    FirstViewController *_firstV;
    SubjectOneCurrentViewController *_progressV;
    
    CLLocationManager *locationManager;//定位服务
    NSString *currentCity;
    NSString *Strlatitude;//经度
    NSString *Strlongitude;//纬度
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
 
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSString *userId = [userDic objectForKey:@"userId"];
        [CustomAlertView showAlertViewWithVC:self];
        [[URLConnectionHelper shareDefaulte] loadGetDataWithUrl:[NSString stringWithFormat:@"http://101.37.161.13:7081/v1/student/basicInfo/%@",userId] andSuccessBlock:^(NSArray *data) {
            NSLog(@"%@",data);
            if ([data isEqual:[NSNull new]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     [CustomAlertView hideAlertView];
                    //未缴费
                    if (_firstV == nil) {
                        _firstV = [[FirstViewController alloc] init];
                        _firstV.delegate = self;
                        _firstV.view.frame = self.view.bounds;
                        [_firstV didMoveToParentViewController:self];
                        [self.view addSubview:_firstV.view];
                        
                    }else{
                        [self.view bringSubviewToFront:_firstV.view];
                    }
                });
                return ;
            }
            NSDictionary *dic = (NSDictionary *)data;
            NSString *status = [dic objectForKey:@"status"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                if ([status isEqualToString:@"0"]) {
                    //未缴费
                    if (_firstV == nil) {
                        _firstV = [[FirstViewController alloc] init];
                        _firstV.delegate = self;
                        _firstV.view.frame = self.view.bounds;
                        [_firstV didMoveToParentViewController:self];
                        [self.view addSubview:_firstV.view];

                    }else{
                        [self.view bringSubviewToFront:_firstV.view];
                    }
                    
                }else{
                    //已经缴费
                    if (_progressV == nil) {
                        _progressV = [[SubjectOneCurrentViewController alloc] init];
                        _progressV.delegate = self;
                        _progressV.view.frame = self.view.bounds;
                        [_progressV didMoveToParentViewController:self];
                        [self.view addSubview:_progressV.view];
                    }else{
                        [self.view bringSubviewToFront:_progressV.view];
                        _progressV.refreshAvtive = @"";
                    }
                    
                    
                }
            });
        } andFiledBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                if (_firstV == nil) {
                    _firstV = [[FirstViewController alloc] init];
                    _firstV.delegate = self;
                    _firstV.view.frame = self.view.bounds;
                    [_firstV didMoveToParentViewController:self];
                    [self.view addSubview:_firstV.view];
                }else{
                    [self.view bringSubviewToFront:_firstV.view];
                    _progressV.refreshAvtive = @"";
                }
               
            });
        }];
        
        
        
    }else{
        if (_firstV == nil) {
            _firstV = [[FirstViewController alloc] init];
            _firstV.delegate = self;
            _firstV.view.frame = self.view.bounds;
            [_firstV didMoveToParentViewController:self];
            [self.view addSubview:_firstV.view];
        }else{
            [self.view bringSubviewToFront:_firstV.view];
//            [_firstV.view bringSubviewToFront:self.view];
//            _progressV.refreshAvtive = @"";
        }
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self locatemap];
    // Do any additional setup after loading the view from its nib.
}

- (void)locatemap{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        
        currentCity = [[NSString alloc] init];
        [locationManager requestWhenInUseAuthorization];
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0;
        [locationManager startUpdatingLocation];
    }
}

#pragma mark coreLacation deleagte

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingURl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingURl];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:ok];
    [v addAction:cancel];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [locationManager stopUpdatingLocation];
    
    CLLocation *currentLocation = [locations lastObject];
    
    NSString *latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"cuurentLatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"cuurentLongitude"];
    
    NSLog(@"la:%f-Long:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
}

#pragma mark - SubjectOneCurrentViewControllerDelegateActive

- (void)SubjectOneCurrentViewControllerDelegateWithActiveVC:(BasicViewController *)v andTag:(NSString *)tag{
    
    if (tag.length > 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertViewActiveWithDes:tag];
        });
        
        return;
    }
    switch ([tag intValue]) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
                
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
                
            });
        }

            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:v animated:YES];
            });
        }
            
            break;
        case 3:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E8%A5%BF%E5%9F%B9%E5%AD%A6%E5%A0%82/id1189867693?mt=8"]];
            });
            
        }
            
            break;
        case 4:{
            
        }
            
            break;
        case 5:{
            
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - FirstViewControllerDelegateActive

- (void)FirstViewControllerDelegateWithActiveVC:(BasicViewController *)v andTag:(NSString *)tag{
    
    switch ([tag intValue]) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:v animated:YES];
            });}
            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(), ^{
               
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
                
                [self presentViewController:nav animated:YES completion:^{
                    
                }];

            });
        }
            
            break;
        case 3:{
            
        }
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertViewActiveWithDes:(NSString *)des{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:des preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

@end
