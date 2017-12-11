//
//  SubjectOneViewController.m
//  test
//
//  Created by auralic on 17/11/30.
//  Copyright © 2017年 tidalicHifi. All rights reserved.
//

#import "SubjectOneViewControllera.h"

#import "ChoosePayTypeCell.h"
#import "TestAppointmentViewController.h"

@interface SubjectOneViewControllera ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *firstData;

@property (nonatomic, strong) NSArray *secondData;

@property (nonatomic, strong) NSArray *imageData;

@end

@implementation SubjectOneViewControllera
{
    NSArray *_data1;
    NSArray *_data2;
    NSInteger _choosedPaidWay;
    NSMutableDictionary *_dic;
}

- (IBAction)btnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)firstData{
    if (!_firstData) {
        _firstData = @[@"微信支付",@"支付宝支付"];
    }
    
    return _firstData;
}

- (NSArray *)secondData{
    if (!_secondData) {
        _secondData = @[@"微信快捷支付，2.0版本以上",@"建议安装手机客户端5.0版本以上使用"];
    }
    return _secondData;
}

- (NSArray *)imageData{
    if (!_imageData) {
        _imageData = @[@"icon_weichat",@"icon_zhifubao"];
    }
    return _imageData;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _choosedPaidWay = 5;
    _dic = [[NSMutableDictionary alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[self creeateFootView]];
    [_tableView setTableHeaderView:[self createHeaderView]];
    
    _data1 = @[@"姓名",@"证件号码",@"考试时间",@"考试场地",@"准考车型"];
    _data2 = @[@"张涛涛",@"50023619988***********1616",@"2017-15-5 15:00-18:00",@"渝北互联网",@"C1"];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
        return 40;
    }else
        return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_dic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (indexPath.row < 5) {
        static NSString *index = @"";
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
            [_dic setObject:cell forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        cell.detailTextLabel.textColor = UNMAIN_TEXT_COLOR;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.text = _data1[indexPath.row];
        cell.detailTextLabel.text = _data2[indexPath.row];
    }else{
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePayTypeCell" owner:nil options:nil] lastObject];
            [_dic setObject:cell forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
        
        if (indexPath.row == _choosedPaidWay) {
            ((ChoosePayTypeCell *)cell).checkImage.image = [UIImage imageNamed:@"btn_box_click"];
        }else{
            ((ChoosePayTypeCell *)cell).checkImage.image = [UIImage imageNamed:@"btn_box_normal"];
        }
        ((ChoosePayTypeCell *)cell).logoImage.image = [UIImage imageNamed:self.imageData[indexPath.row-5]];
        ((ChoosePayTypeCell *)cell).firstLabel.text = self.firstData[indexPath.row-5];
        ((ChoosePayTypeCell *)cell).secondLabel.text = self.secondData[indexPath.row-5];
    }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
        return;
    }else{
        _choosedPaidWay = indexPath.row;
        [_tableView reloadData];
    }

}

- (UIView *)createHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 100)];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CURRENT_BOUNDS.width, 20)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UNMAIN_TEXT_COLOR;
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.text = @"科目一考试费用代缴：";
    [headerView addSubview:titleLable];
    
    UILabel *titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable.frame)+20, CURRENT_BOUNDS.width, 40)];
    titleLable1.textAlignment = NSTextAlignmentCenter;
    titleLable1.textColor = [UIColor redColor];
    titleLable1.font = [UIFont systemFontOfSize:34];
    titleLable1.text = @"¥:50";
    [headerView addSubview:titleLable1];
    
    
    
    return headerView;
}


- (UIView *)creeateFootView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 200)];
    headerView.backgroundColor = EEEEEE;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width-100, 40);
    btn.center = CGPointMake(CURRENT_BOUNDS.width/2, 50);
    btn.backgroundColor = BLUE_BACKGROUND_COLOR;
    [btn setTitle:@"确认支付" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
    [headerView addSubview:btn];
    
    return headerView;
}

-(void)btnClickActive:(UIButton *)btn{
    TestAppointmentViewController *v = [[TestAppointmentViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
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
