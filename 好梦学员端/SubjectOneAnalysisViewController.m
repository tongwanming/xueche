//
//  SubjectOneAnalysisViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneAnalysisViewController.h"
#import "SubjectOneAnalysisTableViewCell.h"
#import "SubjectOneAnalysisNormalTableViewCell.h"
#import "SubjectPractiseModel.h"

@interface SubjectOneAnalysisViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *mutDic;

@property (nonatomic, strong) NSMutableDictionary *allDic;

@property (nonatomic, strong) NSMutableDictionary *firstDic;

@property (nonatomic, strong) NSMutableDictionary *secondDic;

@end

@implementation SubjectOneAnalysisViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setGardStr:(NSString *)gardStr{
    _gardStr = gardStr;
}

- (void)setErrorData:(NSMutableArray *)errorData{
    _errorData = errorData;
    NSMutableArray *arr;
    if (!_mutDic) {
        _mutDic = [[NSMutableDictionary alloc] init];
    }
    for (SubjectPractiseModel *model  in _errorData) {
        if (model.questionType != nil) {
            arr = [_mutDic objectForKey:model.questionType];
            if (!arr) {
                arr = [[NSMutableArray alloc] init];
                [arr addObject:model];
                [_mutDic setObject:arr forKey:model.questionType];
            }else{
                [arr addObject:model];
            }
        }else{
            arr = [_mutDic objectForKey:@"未分类"];
            if (!arr) {
                arr = [[NSMutableArray alloc] init];
                [arr addObject:model];
                [_mutDic setObject:arr forKey:@"未分类"];
            }else{
                [arr addObject:model];
            }
        }
        
    }
}

- (void)setAllData:(NSMutableArray *)allData{
    _allData = allData;
    NSMutableArray *arr;
    if (!_allDic) {
        _allDic = [[NSMutableDictionary alloc] init];
    }
    for (SubjectPractiseModel *model  in _allData) {
        if (model.questionType != nil) {
            NSLog(@"questionType:%@",model.questionType);
            arr = [_allDic objectForKey:model.questionType];
            if (!arr) {
                arr = [[NSMutableArray alloc] init];
                [arr addObject:model];
                [_allDic setObject:arr forKey:model.questionType];
            }else{
                [arr addObject:model];
            }
        }else{
            arr = [_allDic objectForKey:@"未分类"];
            if (!arr) {
                arr = [[NSMutableArray alloc] init];
                [arr addObject:model];
                [_mutDic setObject:arr forKey:@"未分类"];
            }else{
                [arr addObject:model];
            }
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstDic = [[NSMutableDictionary alloc] init];
    _secondDic = [[NSMutableDictionary alloc] init];
    //设置时间栏字体的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    letBtn.frame = CGRectMake(0, 20, 44, 44);
    [letBtn setImage:[UIImage imageNamed:@"btn_back_white"] forState:UIControlStateNormal];
    letBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [letBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:letBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2-50, 20, 100, 44)];
    titleLabel.text = @"成绩分析";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _gradeLabel.text = _gardStr;
    _describeLabel.text = [NSString stringWithFormat:@"做错%lu题,%lu种考点未达标",(unsigned long)_errorData.count,(unsigned long)_mutDic.allKeys.count];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger n = 0;
    if (section == 0) {
        n = _mutDic.allKeys.count;
    }else{
        n = _allDic.allKeys.count;
    }
    return n;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    UITableViewCell *cell;
//    cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [_firstDic objectForKey:indexPath];
            if (!cell) {
                cell = [[SubjectOneAnalysisNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:index];
                 [_firstDic setObject:cell forKey:indexPath];
                
            }
            ((SubjectOneAnalysisNormalTableViewCell *)cell).titleLabel.text = [NSString stringWithFormat:@"试卷覆盖点（%lu个）",(unsigned long)_allDic.allKeys.count];

        }else{
            cell = [_secondDic objectForKey:indexPath];
            if (!cell) {
                cell = [[SubjectOneAnalysisTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
                [_secondDic setObject:cell forKey:indexPath];
            }
            ((SubjectOneAnalysisTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:[self getImageWith:_allDic.allKeys[indexPath.row-1]]];
            ((SubjectOneAnalysisTableViewCell *)cell).titleLabel.text = [self getTitleWith:_allDic.allKeys[indexPath.row-1]];
            ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)((NSMutableArray *)_allDic.allValues[indexPath.row-1]).count];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        if (indexPath.row == 0) {
            cell = [_firstDic objectForKey:indexPath];
            if (!cell) {
                cell = [[SubjectOneAnalysisNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:index];
                 [_firstDic setObject:cell forKey:indexPath];
                
            }
            ((SubjectOneAnalysisNormalTableViewCell *)cell).titleLabel.text = [NSString stringWithFormat:@"错题考点（%lu个）",(unsigned long)_mutDic.allKeys.count];
        }else{
            cell = [_secondDic objectForKey:indexPath];
            if (!cell) {
                cell = [[SubjectOneAnalysisTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
                [_secondDic setObject:cell forKey:indexPath];
            }
            ((SubjectOneAnalysisTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:[self getImageWith:_mutDic.allKeys[indexPath.row-1]]];
            ((SubjectOneAnalysisTableViewCell *)cell).titleLabel.text = [self getTitleWith:_mutDic.allKeys[indexPath.row-1]];
            ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)((NSMutableArray *)_mutDic.allValues[indexPath.row-1]).count];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSString *)getTitleWith:(NSString *)title{
    NSString *str;
    NSLog(@"title---:%@",title);
    if ([title isEqualToString:@"98"]) {
        str = @"难理解题";
    }else if ([title isEqualToString:@"99"]){
        str = @"易错题";
    }else if ([title isEqualToString:@"100"]){
        str = @"时间";
    }else if ([title isEqualToString:@"101"]){
        str = @"距离";
    }else if ([title isEqualToString:@"102"]){
        str = @"罚款";
    }else if ([title isEqualToString:@"103"]){
        str = @"标线";
    }else if ([title isEqualToString:@"104"]){
        str = @"标志";
    }else if ([title isEqualToString:@"105"]){
        str = @"速度";
    }else if ([title isEqualToString:@"106"]){
        str = @"手势";
    }else if ([title isEqualToString:@"107"]){
        str = @"信号灯";
    }else if ([title isEqualToString:@"108"]){
        str = @"记分";
    }else if ([title isEqualToString:@"109"]){
        str = @"酒驾";
    }else if ([title isEqualToString:@"110"]){
        str = @"灯光";
    }else if ([title isEqualToString:@"111"]){
        str = @"仪表";
    }else if ([title isEqualToString:@"112"]){
        str = @"装置";
    }else if ([title isEqualToString:@"113"]){
        str = @"路况";
    }else{
        str = @"未分类";
    }
    
    return str;
}

- (NSString *)getImageWith:(NSString *)title{
    NSString *str;
    if ([title isEqualToString:@"98"]) {
        str = @"";
    }else if ([title isEqualToString:@"99"]){
        str = @"";
    }else if ([title isEqualToString:@"100"]){
        str = @"icon_shijian";
    }else if ([title isEqualToString:@"101"]){
        str = @"icon_juli";
    }else if ([title isEqualToString:@"102"]){
        str = @"icon_fakuan";
    }else if ([title isEqualToString:@"103"]){
        str = @"icon_biaoxian";
    }else if ([title isEqualToString:@"104"]){
        str = @"icon_biaozhi";
    }else if ([title isEqualToString:@"105"]){
        str = @"icon_sudu";
    }else if ([title isEqualToString:@"106"]){
        str = @"icon_shoushi";
    }else if ([title isEqualToString:@"107"]){
        str = @"icon_xinhaodeng";
    }else if ([title isEqualToString:@"108"]){
        str = @"icon_jifen";
    }else if ([title isEqualToString:@"109"]){
        str = @"icon_jiujia";
    }else if ([title isEqualToString:@"110"]){
        str = @"icon_dengguang";
    }else if ([title isEqualToString:@"111"]){
        str = @"icon_yibiao";
    }else if ([title isEqualToString:@"112"]){
        str = @"icon_shezhi";
    }else if ([title isEqualToString:@"113"]){
        str = @"icon_lukuang";
    }else{
        str = @"icon_lukuang";
    }
    
    return str;
}

- (void)leftBtnActive:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
