//
//  DoDriveExerciseViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "DoDriveExerciseViewController.h"
#import "DoDriveExerciseModel.h"
#import "DoDriveExerciseViewControllerCell.h"
#import "EventCoachView.h"
#import "CustomAlertView.h"
#import "URLConnectionHelper.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.m"
#import "DriveAppraiseViewController.h"

@interface DoDriveExerciseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DoDriveExerciseViewController{
    NSMutableArray *_data;
}

- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
     [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData{
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];
    if (_subject == nil) {
        _subject = @"";
    }
    NSDictionary *dic = @{@"stuId":userId,@"subject":_subject};
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    
    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:@"http://101.37.161.13:7081/v1/student/study/record/list" andDic:dic andSuccessBlock:^(NSArray *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
        for (NSDictionary *dic in data) {
            DoDriveExerciseModel *model = [[DoDriveExerciseModel alloc] init];
            model.currentId = [[dic objectForKey:@"id"] floatValue];
            model.stuId = [dic objectForKeyWithNoNsnull:@"stuId"];
            model.studentName = [dic objectForKeyWithNoNsnull:@"studentName"];
            model.subject = [dic objectForKeyWithNoNsnull:@"subject"];
            model.coachUserId = [dic objectForKeyWithNoNsnull:@"coachUserId"];
            model.cocoaName = [dic objectForKeyWithNoNsnull:@"coachName"];
            model.trainPlaceId = [[dic objectForKey:@"stuId"] floatValue];
            model.trainPlaceName = [dic objectForKeyWithNoNsnull:@"trainPlaceName"];
            model.recordRemark = [dic objectForKeyWithNoNsnull:@"recordRemark"];
            model.signTime = [dic objectForKeyWithNoNsnull:@"signTime"];
            model.evaluateId = [[dic objectForKey:@"evaluateId"] floatValue];
            model.evaluateRemark = [dic objectForKeyWithNoNsnull:@"evaluateRemark"];
            model.totalityStars = [[dic objectForKey:@"totalityStars"] floatValue];
            model.qualityStars = [[dic objectForKey:@"qualityStars"] floatValue];
            model.serviceStars = [[dic objectForKey:@"serviceStars"] floatValue];
            model.planStars = [[dic objectForKey:@"planStars"] floatValue];
            model.isEvaluate = [[dic objectForKey:@"isEvaluate"] boolValue];
            model.evaluateTime = [dic objectForKeyWithNoNsnull:@"evaluateTime"];
            [_data addObject:model];
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
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *inde = @"";
    DoDriveExerciseViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:inde];
    if (!cell) {
        cell = [DoDriveExerciseViewControllerCell cellWithTableToDequeueReusable:tableView identifier:@"DoDriveExerciseViewControllerCell" nibName:@"DoDriveExerciseViewControllerCell"];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _data[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoDriveExerciseModel *model = _data[indexPath.row];
    
    if (model.isEvaluate) {
        [[EventCoachView shareDefault] showEventCoachViewWithVC:self andWithName:model.studentName andDes:model.evaluateRemark andImage:@"" andPoint:model.totalityStars andBlock:^(NSString *str) {
            
        }];
    }else{
        DriveAppraiseViewController *v = [[DriveAppraiseViewController alloc] init];
        v.model = model;
        [self.navigationController pushViewController:v animated:YES];
    }
    
   
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
