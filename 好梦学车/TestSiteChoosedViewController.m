//
//  TestSiteChoosedViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "TestSiteChoosedViewController.h"
#import "TestSiteChoosedTableViewCell.h"
#import "URLConnectionHelper.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.m"
#import "CustomAlertView.h"


@interface TestSiteChoosedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TestSiteChoosedViewController{
    NSMutableArray *_data;
}
- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)TestSiteChoosedViewControllerActive:(void (^)(TestSiteChoosedModel *))block{
    _block = block;
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
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic = @{@"username":_userName,@"subjectCode":self.kskm};
    NSString *url = @"http://101.37.161.13:7072/fecthdata-front-service/student/v201701/exam/address";
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:url andDic:dic andSuccessBlock:^(NSArray *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
        
        NSDictionary *dic = (NSDictionary *)data;
        NSArray *subData = [dic objectForKey:@"examsiteVos"];
        
        NSString *startTime = [dic objectForKey:@"minKsrqStr"];
        NSString *endTime = [dic objectForKey:@"maxKsrqStr"];
        for (NSDictionary *dic in subData) {
            if ([[dic objectForKey:@"kskm"] isEqualToString:_kskm]) {
                TestSiteChoosedModel *model = [[TestSiteChoosedModel alloc] init];
                model.name = [dic objectForKeyWithNoNsnull:@"kcmc"];
                model.kcdddh = [dic objectForKeyWithNoNsnull:@"kcdddh"];
                model.startTime = startTime;
                model.endTime = endTime;
                if ([[dic objectForKey:@"netSysPlacesiteVo"] isEqual:[NSNull null]]) {
                    model.address = @"";
                    model.phone = @"";
                }else{
                    model.address = [((NSDictionary *)[dic objectForKey:@"netSysPlacesiteVo"]) objectForKeyWithNoNsnull:@"lxdz"];
                    model.phone = [((NSDictionary *)[dic objectForKey:@"netSysPlacesiteVo"]) objectForKeyWithNoNsnull:@"lxdh"];
                }
                [_data addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andDicFiledResonBlock:^(NSObject *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            if ([dic isKindOfClass:[NSString class]]) {
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:(NSString *)dic preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            }else{
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            }
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
    TestSiteChoosedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indx];
    if (!cell) {
        cell = [TestSiteChoosedTableViewCell cellWithTableToDequeueReusable:tableView identifier:indx nibName:@"TestSiteChoosedTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _data[indexPath.row];
    [cell TestSiteChoosedActive:^(TestSiteChoosedModel *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView showAlertViewWithVC:self];
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            [CustomAlertView hideAlertView];
        });
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_block) {
        _block(((TestSiteChoosedModel *)_data[indexPath.row]));
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
