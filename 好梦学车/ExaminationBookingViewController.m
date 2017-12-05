//
//  ExaminationBookingViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ExaminationBookingViewController.h"

#define footViewHeight 400

@interface ExaminationBookingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ExaminationBookingViewController
{
    NSArray *_data1;
    NSArray *_data2;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[self createFootView]];
    
    _data1 = @[@"姓名",@"证件号码",@"手机号码",@"准驾车型",@"考试原因"];
    _data2 = @[@"张涛涛",@"50023619988***********1616",@"158****78",@"小型汽车（C1）",@"初次申领"];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indx = @"ind";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indx];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indx];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _data1[indexPath.row];
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.text = _data2[indexPath.row];
    return cell;
}



- (UIView *)createFootView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, footViewHeight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, CURRENT_BOUNDS.width, 25)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"122平台登陆";
    titleLabel.textColor = TEXT_COLOR;
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [view addSubview:titleLabel];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic03"]];
    logoView.frame = CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(titleLabel.frame)+20, 50, 50);
//    logoView.backgroundColor = [UIColor redColor];
    [view addSubview:logoView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView.frame), 200, 0.5)];
    lineView.backgroundColor = EEEEEE;
    [view addSubview:lineView];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoView.frame),  CGRectGetMaxY(titleLabel.frame)+20, 150, 40)];
    textFiled.borderStyle = UITextBorderStyleNone;
    textFiled.textColor = UNMAIN_TEXT_COLOR;
    textFiled.font = [UIFont systemFontOfSize:18];
    textFiled.textAlignment = NSTextAlignmentCenter;
    textFiled.placeholder = @"输入账号，身份证";
    [view addSubview:textFiled];
    
    UIImageView *logoView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic03"]];
    logoView1.frame = CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView.frame)+20, 50, 50);
//    logoView1.backgroundColor = [UIColor redColor];
    [view addSubview:logoView1];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView1.frame), 200, 0.5)];
    lineView1.backgroundColor = EEEEEE;
    [view addSubview:lineView1];
    
    UITextField *textFiled1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoView.frame),  CGRectGetMaxY(logoView.frame)+20, 150, 40)];
    textFiled1.borderStyle = UITextBorderStyleNone;
    textFiled1.textColor = UNMAIN_TEXT_COLOR;
    textFiled1.font = [UIFont systemFontOfSize:18];
    textFiled1.textAlignment = NSTextAlignmentCenter;
    textFiled1.placeholder = @"输入密码";
    [view addSubview:textFiled1];
    
    UIButton *logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoBtn.frame = CGRectMake((CURRENT_BOUNDS.width-220)/2*TYPERATION, CGRectGetMaxY(textFiled1.frame)+30, 220, 40);
    logoBtn.backgroundColor = BLUE_BACKGROUND_COLOR;
    [logoBtn setTitle:@"立即登陆" forState: UIControlStateNormal];
    logoBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [logoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoBtn addTarget:self action:@selector(logoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    logoBtn.layer.masksToBounds = YES;
    logoBtn.layer.cornerRadius = 20;
    [view addSubview:logoBtn];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoBtn.frame)+20, CURRENT_BOUNDS.width, 18)];
    tipsLabel.font = [UIFont systemFontOfSize:12];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = UNMAIN_TEXT_COLOR;
    tipsLabel.text = @"请根据12123500（重庆交巡警）发送的短信内容进行登录";
    [view addSubview:tipsLabel];
    
    return view;
}

- (void)logoBtnClick:(UIButton *)btn{
    
    NSLog(@"btn Click");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
