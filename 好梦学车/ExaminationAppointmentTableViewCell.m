//
//  ExaminationAppointmentTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/12/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ExaminationAppointmentTableViewCell.h"
#import "NSMutableAttributedString+ADDITIONS.h"

@interface ExaminationAppointmentTableViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end;

@implementation ExaminationAppointmentTableViewCell
{
    NSArray *_data1;
    NSArray *_data2;
}
+ (id)cellWithTableToDequeueReusable:(UITableView *)table
                          identifier:(NSString *)identifier
                             nibName:(NSString *)nibName
{
    if (table) {
        id reused = [table dequeueReusableCellWithIdentifier:identifier];
        if (reused) return reused;
    }
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)ExaminationAppointmentWithBlock:(void (^)(UIButton *))block{
    _block = block;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createView];
}

- (void)createView{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 40)];
    titleLabel.text = @"当前预约";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UNMAIN_TEXT_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = EEEEEE;
    [self addSubview:titleLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, CURRENT_BOUNDS.width, 300+44*5) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    [self addSubview:_tableView];
    
    [_tableView setTableFooterView:[self createFootView]];
    _data1 = @[@"科目一",@"报考姓名",@"考试场地",@"考试场次"];
    _data2 = @[@"  受理中",@"张涛涛",@"科目一九龙坡西彭考场",@"2017-12-5（逸动）8:00－12:00"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.textColor = UNMAIN_TEXT_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = _data1[indexPath.row];
    if (indexPath.row == 0) {
        NSString *str = _data2[indexPath.row];
        cell.detailTextLabel.attributedText = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"content_img_msg"] andOtherStr:str andBound:CGRectMake(0, -3, 14, 14)];
    }else{
        cell.detailTextLabel.text = _data2[indexPath.row];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)createFootView{
    UIView *footView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 300)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.frame = CGRectMake(20, 30, (CURRENT_BOUNDS.width-80)/2, 40);
    [btn1 setTitle:@"注意事项" forState:UIControlStateNormal];
    [btn1 setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
    btn1.tag = 1001;
    [btn1 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = [UIFont systemFontOfSize:18];
    
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 5;
    btn1.layer.borderWidth = 1;
    btn1.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
    btn1.backgroundColor = [UIColor whiteColor];
    [footView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn2.frame = CGRectMake(CURRENT_BOUNDS.width/2+20, 30, (CURRENT_BOUNDS.width-80)/2, 40);
    [btn2 setTitle:@"考场导航" forState:UIControlStateNormal];
    [btn2 setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
    btn2.tag = 1002;
    [btn2 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    btn2.backgroundColor = [UIColor whiteColor];
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 5;
    btn2.layer.borderWidth = 1;
    btn2.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
    [footView addSubview:btn2];
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(btn2.frame)+20, CURRENT_BOUNDS.width-40, 60)];
    desLabel.numberOfLines = 0;
    desLabel.textColor = UNMAIN_TEXT_COLOR;
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.font = [UIFont systemFontOfSize:14];
    desLabel.text = @"您的预考申请已经提交到交管部门，受理成功后您会收到重庆交管平台发送的约考成功的短信，如果考试前一天仍未收到短信，请及时联系交管部门";
    [footView addSubview:desLabel];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 200, 40);
    btn3.center = CGPointMake(CURRENT_BOUNDS.width/2, CGRectGetMaxY(desLabel.frame)+40);
    btn3.tag = 1003;
    btn3.backgroundColor = BLUE_BACKGROUND_COLOR;
    btn3.layer.masksToBounds = YES;
    btn3.layer.cornerRadius = 20;
    [btn3 setTitle:@"联系交管" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:18];
    [footView addSubview:btn3];
    
    
    
    
    return footView;
}

- (void)btnClickActive:(UIButton *)btn{
    if (_block) {
        _block(btn);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
