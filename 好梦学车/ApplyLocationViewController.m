//
//  ApplyLocationViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ApplyLocationViewController.h"
#import "ApplyLocationTableViewCell.h"

@interface ApplyLocationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ApplyLocationViewController
- (IBAction)btnclick:(id)sender {
    
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
    return 4;
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
