//
//  ChoosedSecuritiesViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedSecuritiesViewController.h"
#import "SecuritiesTableViewCellChoose.h"
#import "CustomAlertView.h"

@interface ChoosedSecuritiesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UILabel *titleLable;

@end

@implementation ChoosedSecuritiesViewController{
    NSInteger _currentChoosedIndex;
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        if (_data.count < 1) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if (self.securitiesBlock) {
            self.securitiesBlock(_data[_currentChoosedIndex]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
}

- (void)returnChoosedSecuritiesBlock:(choosedSecuritiesBlock)block{
    _securitiesBlock = block;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _data = [[NSMutableArray alloc] init];
    _currentChoosedIndex = 0;
    self.title = @"选择优惠券";
    
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 39/2;
    
    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [letBtn setImage:[UIImage imageNamed:@"btn_back_gray"] forState:UIControlStateNormal];
    letBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    letBtn.tag = 1001;
    [letBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.frame = CGRectMake(0, 0, 40, 40);
    [letBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:letBtn];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 20)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.font = [UIFont systemFontOfSize:18];
    _titleLable.text = @"暂无可用的优惠券";
    _titleLable.center = CGPointMake(CURRENT_BOUNDS.width/2, CURRENT_BOUNDS.height/2);
    _titleLable.textColor = TEXT_COLOR;
    [self.view addSubview:_titleLable];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = F4F4F4;
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    [CustomAlertView showAlertViewWithVC:self];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *phone = [userDic objectForKey:@"phone"];
    int w = [self changeIntegerTypeWithStr:_price];
    NSDictionary *dic =@{ @"classTypeCode":_categoryCode,
                         @"limit": @0,
                         @"limitInstalments": @false,
                          @"limitPrice":@(w),
                         @"page": @0,
                         @"paged": @false,
                         @"phone": phone,
                         @"status": @"0",
                         @"type": @"0",
                         @"userId": @""
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:10002/couponRecord/listCouponRecords",PUBLIC_LOCATION]];
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    _sureBtn.alpha = 0.5;
                    _sureBtn.userInteractionEnabled = NO;
                });
            }else{
                _titleLable.hidden = YES;
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
    SecuritiesTableViewCellChoose *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [SecuritiesTableViewCellChoose cellWithTableToDequeueReusable:tableView identifier:index nibName:@"SecuritiesTableViewCellChoose"];
        
    }
    if (indexPath.row == _currentChoosedIndex) {
        cell.isSelected = YES;
    }else{
        cell.isSelected = NO;
    }
    cell.model = _data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _currentChoosedIndex = indexPath.row;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (int)changeIntegerTypeWithStr:(NSString *)str{
    
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    [mutStr deleteCharactersInRange:NSMakeRange(1, 1)];
    int n = [mutStr intValue];
    int n2 =n*100;
    
    return n2;
}

@end
