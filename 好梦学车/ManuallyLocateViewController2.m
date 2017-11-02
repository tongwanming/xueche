//
//  ManuallyLocateViewController2.m
//  好梦学车
//
//  Created by haomeng on 2017/10/23.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ManuallyLocateViewController2.h"
#import <BaiduMapAPI_Map/BMKMapView.h>

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
#import "SearchModel.h"
#import "FirstLocationModel.h"
#import "CustomAlertView.h"
#import "ChoosedPlaceViewController.h"

@interface ManuallyLocateViewController2 ()<UITableViewDelegate,UITableViewDataSource,BMKPoiSearchDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputAddTF;//输入地址框


@property (weak, nonatomic) IBOutlet UITableView *displayTableView;//显示的tableView


@property (nonatomic,strong) NSString *placeStr;



@property (nonatomic,strong) NSString *locationCity;//定位城市

@property (nonatomic,strong) NSMutableArray *addressArray;//搜索的地址数组


@property (nonatomic,strong) SearchModel *model;

@end

@implementation ManuallyLocateViewController2
{
    
    
    BMKPoiSearch *_poisearch;//poi搜索
    
    
    BMKRouteSearch *_geocodesearch;//geo搜索服务
    
    NSMutableArray *_dataArray;
    
    NSString *_oldText;
    
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (btn.tag == 1002){
       _inputAddTF.text = @"";
        [self inputAddTFAction:_inputAddTF];
    }else{
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputAddTF becomeFirstResponder];
    });
}

-(void)viewWillDisappear:(BOOL)animated


{
    [super viewWillDisappear:animated];
    
    _poisearch.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
}


//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _oldText = @"";
    _locationCity = @"重庆";
    [self.inputAddTF addTarget:self action:@selector(inputAddTFAction:) forControlEvents:UIControlEventEditingChanged];
//    self.inputAddTF.borderStyle =UITextBorderStyleNone;
    self.inputAddTF.textAlignment = NSTextAlignmentLeft;
    self.displayTableView.dataSource = self;
    self.displayTableView.delegate = self;
    [self.displayTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.inputAddTF.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark-tableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = @"cell_id";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    
    if (!cell) {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:3 reuseIdentifier:cell_id];
        
        
    }
    
    
    SearchModel *sModel = [[SearchModel alloc] init];
    
    
    sModel = self.addressArray[indexPath.row];
    
    
    cell.textLabel.text = sModel.name;
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.text = sModel.address;
    
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    
    SearchModel *model = [[SearchModel alloc] init];
    
    
    model = self.addressArray[indexPath.row];
    
    
    
    [self getDataActiveWithPt:model.pt andModle:model];
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath


{
    return 50;
}

-(void)inputAddTFAction:(UITextField *)textField
{
    if (![_oldText isEqualToString:textField.text]) {
        _oldText = textField.text;
        [self performSelector:@selector(delay) withObject:self afterDelay:0];
        if ([textField.text isEqualToString:@""] && self.addressArray.count > 0) {
            [self.addressArray removeAllObjects];
            [_displayTableView reloadData];
        }
    }


}

- (void)delay {
    
    [self nameSearch];
}

-(void)nameSearch{
    if (self.inputAddTF.text.length >=2) {
        _poisearch = [[BMKPoiSearch alloc]init];
        _poisearch.delegate = self;
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
        citySearchOption.pageIndex = 0;
        citySearchOption.pageCapacity = 30;
        citySearchOption.city= _locationCity;
        citySearchOption.keyword = self.inputAddTF.text;
        BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
        if(flag)
        {
            NSLog(@"城市内检索发送成功");
        }
        else
        {
            NSLog(@"城市内检索发送失败");
        }
    }
}

-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode

{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        self.addressArray = [NSMutableArray array];
        [self.addressArray removeAllObjects];
        for (BMKPoiInfo *info in poiResult.poiInfoList) {
            _model = [[SearchModel alloc] init];
            _model.name = info.name;
            _model.address = info.address;
            _model.pt = info.pt;
            [self.addressArray addObject:_model];
        }
        [self.displayTableView reloadData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView


{
    
    [self.view endEditing:YES];
    
    [self.navigationItem.titleView endEditing:YES];
}

-(void)dealloc{
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
}

//获取数据
- (void)getDataActiveWithPt:(CLLocationCoordinate2D)pt andModle:(SearchModel*)model{
    NSDictionary *dic = @{@"longitude":[NSString stringWithFormat:@"%f",pt.longitude],
                          @"latitude":[NSString stringWithFormat:@"%f",pt.latitude],
                          @"displayNum":@10};
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
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
                    if (_dataArray.count > 1) {
                        [_dataArray removeAllObjects];
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
                        [_dataArray addObject:model];
                    }
                    
                    __weak typeof(self) wSelf = self;
                    
                    //预选场地
                    ChoosedPlaceViewController *typeVc = [[ChoosedPlaceViewController alloc] init];
                    typeVc.allExerciseLocationData = _dataArray;
                    typeVc.isByPersonVC = YES;
                    typeVc.currentLocation = model.pt;
                    typeVc.isHasSearch = YES;
//                    [typeVc returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
//                        [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
//                    }];
                    self.navigationController.navigationBar.hidden = NO;
                    [self.navigationController pushViewController:typeVc animated:YES];
        
                });
                
            }else{
                
                
            }
        }else{
//            [CustomAlertView hideAlertView];
        }
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
