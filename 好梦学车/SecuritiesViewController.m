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

@interface SecuritiesViewController ()<UITableViewDelegate,UITableViewDataSource,SecuritiesTableViewCellEnabledDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

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
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    if (indexPath.row == 2) {
        cell.canBeUsed = NO;
    }else{
        cell.canBeUsed = YES;
    }
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

@end
