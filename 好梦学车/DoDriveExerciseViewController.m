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

@interface DoDriveExerciseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DoDriveExerciseViewController

- (IBAction)btnClick:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[EventCoachView shareDefault] showEventCoachViewWithVC:self andWithName:@"张淘淘" andDes:@"这是一个很长很长的评论,这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论这是一个很长很长的评论" andImage:@"" andPoint:3 andBlock:^(NSString *str) {
        
    }];
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
