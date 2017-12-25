//
//  CheckMedicalStationViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "CheckMedicalStationViewController.h"
#import "CheckMedicalStationTableViewCell.h"
#import "CheckMedicalStationModel.h"
#import "CustomAlertView.h"
#import "URLConnectionHelper.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.m"


@interface CheckMedicalStationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarShow;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation CheckMedicalStationViewController
- (IBAction)btnClick:(id)sender {
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
    [self getDataActive];
    // Do any additional setup after loading the view from its nib.
}

- (void)getDataActive{

    double la = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cuurentLatitude"] doubleValue];
     double lo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cuurentLongitude"] doubleValue];
    NSDictionary *dic = @{@"latitude":@(la),
                          @"longitude":@(lo)
                          };
    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:@"http://101.37.161.13:7081/v1/station/listHealthCheckStationInfo" andDic:dic andSuccessBlock:^(NSArray *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
        for (NSDictionary *dic in data) {
            CheckMedicalStationModel *model = [[CheckMedicalStationModel alloc] init];
            model.name = [dic objectForKeyWithNoNsnull:@"name"];
            model.address = [dic objectForKeyWithNoNsnull:@"address"];
            model.distance = [dic objectForKeyWithNoNsnull:@"distance"];
            model.latitude = [[dic objectForKey:@"latitude"] doubleValue];
            model.longitude = [[dic objectForKey:@"longitude"] doubleValue];
            [_data addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andFiledBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            [_data removeAllObjects];
            [_tableView reloadData];
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
    CheckMedicalStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indx];
    if (!cell) {
        cell = [CheckMedicalStationTableViewCell cellWithTableToDequeueReusable:tableView identifier:indx nibName:@"CheckMedicalStationTableViewCell"];
    }
    
    cell.model = _data[indexPath.row];
    [cell cellBtnClickActiveWith:^(CheckMedicalStationModel *model) {
        
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
