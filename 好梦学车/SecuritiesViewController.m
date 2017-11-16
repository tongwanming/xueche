//
//  SecuritiesViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SecuritiesViewController.h"
#import "SecuritiesTableViewCellEnabled.h"
#import "ChoosecClassViewController.h"
#import "AppDelegate.h"
#import "IdentifyingViewController.h"
#import "CustomAlertView.h"
#import "SecuritiesModel.h"

@interface SecuritiesViewController ()<UITableViewDelegate,UITableViewDataSource,SecuritiesTableViewCellEnabledDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation SecuritiesViewController
- (IBAction)btnclick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        
    }
    else{
        
        
    }
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = F4F4F4;
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 49/2;
    _data = [[NSMutableArray alloc] init];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    [CustomAlertView showAlertViewWithVC:self];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *phone = [userDic objectForKey:@"phone"];
    NSDictionary *dic =@{@"limit":@0,
                         @"page":@0,
                         @"paged":@true,
                         @"phone":phone,
                         @"status":@"",
                         @"userId":@"",
                         @"limitInstalments":@false
                         };
    
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://101.37.161.13:10002/couponRecord/listCouponRecords"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
        });
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arrData = [jsonDict objectForKey:@"data"];
            NSLog(@"--:%@",arrData);
            if ([arrData isEqual:[NSNull new]]) {
                return ;
            }
            if (arrData == nil || arrData.count < 1) {
                
            }else{
                for (NSDictionary *dic in arrData) {
                    SecuritiesModel *modle = [[SecuritiesModel alloc] init];
                    modle.couponsCode = [dic objectForKeyWithNoNsnull:@"couponsCode"];
                    modle.couponStatus = [dic objectForKeyWithNoNsnull:@"couponStatus"];
                    modle.Sid = [dic objectForKeyWithNoNsnull:@"id"];
                    modle.startTime = [self choosedNormalDateWithStr:[dic objectForKeyWithNoNsnull:@"startTime"]];
                    modle.endTime = [self choosedNormalDateWithStr:[dic objectForKeyWithNoNsnull:@"endTime"]];
                    modle.couponName = [dic objectForKeyWithNoNsnull:@"couponName"];
                    modle.couponType = [dic objectForKeyWithNoNsnull:@"couponType"];
                    modle.descriptiona = [dic objectForKeyWithNoNsnull:@"description"];
                    modle.couponPrice = [self changeTypeWithStr:[dic objectForKey:@"couponPrice"]];
                    modle.useCondition = [dic objectForKeyWithNoNsnull:@"useCondition"];
                    
                    [_data addObject:modle];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
              
            });
        }
    }];
    [dataTask resume];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    SecuritiesTableViewCellEnabled *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [SecuritiesTableViewCellEnabled cellWithTableToDequeueReusable:tableView identifier:index nibName:@"SecuritiesTableViewCellEnabled"];
        
    }
    cell.delegate = self;
    SecuritiesModel *model = _data[indexPath.row];
    if ([model.couponStatus isEqualToString:@"0"]) {
        cell.canBeUsed = YES;
    }else{
        cell.canBeUsed = NO;
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SecuritiesTableViewCellEnabledDelegate
- (void)SecuritiesTableViewCellEnabledClickWithModel:(SecuritiesModel *)model{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        ChoosecClassViewController *v = [[ChoosecClassViewController alloc] init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSString *classStr = [dic objectForKey:@"myClass"];
        NSArray *data = ((AppDelegate *)[[UIApplication sharedApplication]delegate]).carClassData;
        int choosedIndex = 0;
        for (int i = 0; i < data.count; i++) {
            ChoosedClassModel *model = data[i];
            if ([classStr isEqualToString:model.titleStr]) {
                choosedIndex = i;
            }
        }
        v.currentIndex = choosedIndex;
        [v returnActiveWithBlock:^(ChoosedClassModel *model) {
            NSLog(@"%@",model.C1Str);
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
            [dic setObject:model.titleStr forKey:@"myClass"];
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }];
        //                [v returnSelectCocchWithBlock:^(NSString *name) {
        
        //                }];
        [self.navigationController pushViewController:v animated:YES];
    }else{
        IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }
}

- (NSString *)choosedNormalDateWithStr:(NSString *)str{
    NSString *sr;
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    [mutStr deleteCharactersInRange:NSMakeRange(10, 9)];
    sr = [NSString stringWithString:mutStr];
    
    return sr;
    
}

- (NSString *)changeTypeWithStr:(NSString *)str{
    int n = [str intValue];
    int newN = n/100;
    
    NSString *newStr = [NSString stringWithFormat:@"%d",newN];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:newStr];
    
    
    NSString *resultStr = [NSString stringWithString:mutStr];
    
    return resultStr;
    
}

@end
