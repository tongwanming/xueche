//
//  SubscribeTestViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/12/6.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubscribeTestViewController.h"
#import "NSMutableAttributedString+ADDITIONS.h"
#import "TestSiteChoosedViewController.h"
#import "ApplySureViewController.h"
#import "ChoosedDateBtn.h"
#import "URLConnectionHelper.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.m"
#import "CustomAlertView.h"
#import "SubscribeTestModel.h"
#import "SubscribeTestSubModel.h"
#import "SureApplyModel.h"

typedef void(^SubscribeOneBlock)(UIButton *btn);

@interface SubscribeTableViewCell1:UITableViewCell

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSMutableAttributedString *locationStr;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *choosedPlaceBtn;

@property (nonatomic, copy) SubscribeOneBlock block;

@property (nonatomic, strong) NSString *eMonth;

@property (nonatomic, strong) NSString *eLocation;

- (void)SubscribeOneBlockActiveWithBlock:(SubscribeOneBlock)block;

@end

@implementation SubscribeTableViewCell1

- (void)setEMonth:(NSString *)eMonth{
    if (eMonth.length > 0) {
        _timeLabel.text = eMonth;
    }
}

- (void)setELocation:(NSString *)eLocation{
    if (eLocation.length > 0) {
        NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:[NSString stringWithFormat:@"%@  ",eLocation] andImage:[UIImage imageNamed:@"btn_study_unfolded"] andOtherStr:@"" andBound:CGRectMake(0,0,10,6)];
        
        [_choosedPlaceBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
}

- (void)SubscribeOneBlockActiveWithBlock:(SubscribeOneBlock)block{
    _block = block;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, (40-14)/2, 80, 14)];
        _timeLabel.textColor = FF8400;
        _timeLabel.font = [UIFont boldSystemFontOfSize:14];
        _timeLabel.text = @"11月";
        [self addSubview:_timeLabel];
        _choosedPlaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _choosedPlaceBtn.frame = CGRectMake(0, 0, 200, 40);
        _choosedPlaceBtn.center = CGPointMake(CURRENT_BOUNDS.width/2, 20);
        [_choosedPlaceBtn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
        _choosedPlaceBtn.titleLabel.textColor = TEXT_COLOR;
        _choosedPlaceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        _choosedPlaceBtn.backgroundColor = [UIColor redColor];
        NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:@"选择考试场地 " andImage:[UIImage imageNamed:@"btn_study_unfolded"] andOtherStr:@"" andBound:CGRectMake(0,0,10,6)];
       
        [_choosedPlaceBtn setAttributedTitle:str forState:UIControlStateNormal];
        [self addSubview:_choosedPlaceBtn];
    }
    return self;
}

- (void)setTime:(NSString *)time{
    _timeLabel.text = time;
}

- (void)setLocationStr:(NSMutableAttributedString *)locationStr{
    [_choosedPlaceBtn setAttributedTitle:locationStr forState:UIControlStateNormal];
}

- (void)btnClickActive:(UIButton *)btn{
    if (_block) {
        _block(btn);
    }
}

@end


typedef void(^SubscribeTwoBlock)(UIButton *btn);

@interface SubscribeTableViewCell2:UITableViewCell

@property (nonatomic, copy) SubscribeTwoBlock block;

@property (nonatomic, strong) NSArray *dateData;

- (void)SubscribeTwoBlockActiveWithBlock:(SubscribeOneBlock)block;

@end

@implementation SubscribeTableViewCell2

- (void)setDateData:(NSArray *)dateData{
    _dateData = dateData;
    
    if (dateData && dateData.count > 0) {
        
    }else{
        return;
    }
    
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16+i*((CURRENT_BOUNDS.width-32)/7), 0, (CURRENT_BOUNDS.width-32)/7, 53/2)];
        label.textColor = UNMAIN_TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = ((SubscribeTestModel *)_dateData[i]).weeks;
        [self addSubview:label];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, CURRENT_BOUNDS.width, 1)];
    lineView.backgroundColor = EEEEEE;
    [self addSubview:lineView];
    
    for (int i = 0; i < 7; i++) {
        ChoosedDateBtn *btn = [ChoosedDateBtn buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(16+i*((CURRENT_BOUNDS.width-32)/7), 53/2, (CURRENT_BOUNDS.width-32)/7, 45);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13*TYPERATION];
        
        [btn setTitle:((SubscribeTestModel *)_dateData[i]).examLastr forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i== 0 || i == 6) {
            [btn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        }
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [self addSubview:btn];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 53/2)];
        topView.backgroundColor = EEEEEE;
        [self addSubview:topView];
        
       
    }
    return self;
}

- (void)firstActive{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[ChoosedDateBtn class]]) {
            if (view.tag == btn.tag) {
                [(ChoosedDateBtn *)view setImage:[UIImage imageNamed:@"img_chooeds"] forState:UIControlStateNormal];
                [(ChoosedDateBtn *)view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }else{
                [(ChoosedDateBtn *)view setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [(ChoosedDateBtn *)view setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
            }
        }
    }
    if (_block) {
        _block(btn);
    }
}

- (void)btnClick:(UIButton *)btn{
    NSLog(@"%@---btn",@(btn.tag));
   
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[ChoosedDateBtn class]]) {
            if (view.tag == btn.tag) {
                [(ChoosedDateBtn *)view setImage:[UIImage imageNamed:@"img_chooeds"] forState:UIControlStateNormal];
                [(ChoosedDateBtn *)view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                NSLog(@"点击的tag：%ld",(long)btn.tag);
            }else{
                [(ChoosedDateBtn *)view setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [(ChoosedDateBtn *)view setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
            }
        }
    }
    if (_block) {
        _block(btn);
    }
}

- (void)SubscribeTwoBlockActiveWithBlock:(SubscribeOneBlock)block{
    _block = block;
}

@end

@interface SubscribeTableViewCell3:UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *canUserLabel;

@property (nonatomic, strong) UILabel *youLocationLabel;

@property (nonatomic, strong) SubscribeTestSubModel *model;

@end

@implementation SubscribeTableViewCell3

- (void)setModel:(SubscribeTestSubModel *)model{
    _model = model;
    _timeLabel.text = model.ksccMc;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已报%@/可报%@",model.sqrs,model.kkrs]];
//    [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(2,str.length-8)];
    
    _canUserLabel.attributedText = str;
    
    _youLocationLabel.text = [NSString stringWithFormat:@"已报学员中您排名%@",model.pxh];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, CURRENT_BOUNDS.width/2, 13)];
        _timeLabel.textColor = TEXT_COLOR;
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.text = @"9:00-11:00";
        [self addSubview:_timeLabel];
        
        
        _canUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_timeLabel.frame)+14, CURRENT_BOUNDS.width/2, 13)];
        _canUserLabel.textColor = TEXT_COLOR;
        _canUserLabel.font = [UIFont systemFontOfSize:13];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"已报111/可报400"];
        [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(2,str.length-8)];
        
        _canUserLabel.attributedText = str;
        [self addSubview:_canUserLabel];
        
        _youLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2, 40, CURRENT_BOUNDS.width/2-16, 13)];
        _youLocationLabel.textColor = ADB1B9;
        _youLocationLabel.font = [UIFont systemFontOfSize:13];
        _youLocationLabel.textAlignment = NSTextAlignmentRight;
        _youLocationLabel.text = @"已报学员中您排名12";
        [self addSubview:_youLocationLabel];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, CURRENT_BOUNDS.width, 1)];
        lineView.backgroundColor = EEEEEE;
        [self addSubview:lineView];
    }
    return self;
}
@end



@interface SubscribeTestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSArray *subData;

@property (nonatomic, strong) NSString *locationName;

@property (nonatomic, strong) NSString *examTime;

@property (nonatomic, strong) SureApplyModel *model;

@end

@implementation SubscribeTestViewController

- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        [CustomAlertView showAlertViewWithVC:self];
        NSDictionary *dic = @{@"username":_userName};
        [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:@"http://172.31.101.114:7080/student/v201701/send/appoint/sms" andDic:dic andSuccessBlock:^(NSArray *data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                ApplySureViewController *v = [[ApplySureViewController alloc] init];
                v.model = _model;
                [self.navigationController pushViewController:v animated:YES];
            });
        } andFiledBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"短息验证失败！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
                
            });
        }];
        
        
        
    }else{
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[SureApplyModel alloc] init];
    _locationName = @"";
    _examTime = @"";
    _data = [[NSMutableArray alloc] init];
    _subData = [[NSArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [_tableView setTableFooterView:[self createFootView]];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _subData.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ind = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ind];
    if (indexPath.row == 0) {
        if (!cell) {
            cell = [[SubscribeTableViewCell1 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ind];
        }
        ((SubscribeTableViewCell1*)cell).eMonth = _examTime;
        ((SubscribeTableViewCell1*)cell).eLocation = _locationName;
        [((SubscribeTableViewCell1*)cell) SubscribeOneBlockActiveWithBlock:^(UIButton *btn) {
            TestSiteChoosedViewController *v = [[TestSiteChoosedViewController alloc] init];
            
            v.kskm = _kskm;
            v.userName = _userName;
            [v TestSiteChoosedViewControllerActive:^(TestSiteChoosedModel *model) {
                _locationName = model.name;
                _model.startTime = model.startTime;
                _model.endTime = model.endTime;
                _model.username = _userName;
                [self getDataWithModel:model];
            }];
            [self.navigationController pushViewController:v animated:YES];
        }];
    }else if (indexPath.row == 1){
        if (!cell) {
            cell = [[SubscribeTableViewCell2 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ind];
        }
        ((SubscribeTableViewCell2 *)cell).dateData = _data;
        [((SubscribeTableViewCell2 *)cell) SubscribeTwoBlockActiveWithBlock:^(UIButton *btn) {
            _subData = ((SubscribeTestModel *)_data[btn.tag]).subData;
            _examTime = ((SubscribeTestModel *)_data[btn.tag]).examMonth;
            
            [_tableView reloadData];
        }];
    }else{
        if (!cell) {
            cell = [[SubscribeTableViewCell3 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ind];
        }
        if (_subData && _subData.count > indexPath.row - 2) {
            ((SubscribeTableViewCell3 *)cell).model = _subData[indexPath.row - 2];
        }
        
    }
    if (indexPath.row < 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        return;
    }else{
        SubscribeTestSubModel *model = _subData[indexPath.row - 2];
        _model.examTimeCode = model.jhxh;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }else if (indexPath.row == 1){
        return 80;
    }else
        return 80;
}

- (UIView *)createFootView{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 66+40)];
    v.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(80*TYPERATION, 66, CURRENT_BOUNDS.width-80*TYPERATION*2, 40);
    btn.backgroundColor = BLUE_BACKGROUND_COLOR;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
    [btn setTitle:@"立即预约" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1002;
    [v addSubview:btn];
    
    return v;
}

- (void)getDataWithModel:(TestSiteChoosedModel *)model{
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic = @{ @"addressCode": model.kcdddh,
                          @"endTime": model.endTime,
                          @"startTime": model.startTime,
                          @"username": _userName};
    NSString *url = @"http://172.31.101.114:7080/student/v201701/exam/time";
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:url andDic:dic andSuccessBlock:^(NSArray *data) {
        NSArray *detailData = [((NSDictionary *)data) objectForKey:@"data"];
        for (NSDictionary *dic in detailData) {
            SubscribeTestModel *model = [[SubscribeTestModel alloc] init];
            model.examDate = [dic objectForKey:@"ksrq"];
            model.weeks = [self getWeekDay:[dic objectForKey:@"ksrq"]];
            model.examMonth = [self getCurrentMonthWithStr:[dic objectForKey:@"ksrq"]];
            model.examLastr = [self getCurrentDateWithStr:[dic objectForKey:@"ksrq"]];
            NSArray *subData = [dic objectForKey:@"grids"];
            NSMutableArray *mutArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in subData) {
                SubscribeTestSubModel *subModel = [[SubscribeTestSubModel alloc] init];
                subModel.sqrs = [dic objectForKey:@"sqrs"];
                subModel.ksccMc = [dic objectForKey:@"ksccMc"];
                subModel.kkrs = [dic objectForKey:@"kkrs"];
                subModel.pxh = [dic objectForKey:@"pxh"];
                subModel.jhxh = [dic objectForKeyWithNoNsnull:@"jhxh"];
                
                if (![subModel.jhxh isEqualToString:@""]) {
                    [mutArr addObject:subModel];
                }
                
            }
          
            model.subData = mutArr;
            
            [_data addObject:model];
            
        }
        NSLog(@"%@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
             [CustomAlertView hideAlertView];
            [_tableView reloadData];
        });
       
        
       
        
        
    } andFiledBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getCurrentMonthWithStr:(NSString *)str{
    NSString *newStr = @"";
    NSMutableString *mut = [NSMutableString stringWithString:str];
    NSArray *arr = [mut componentsSeparatedByString:@"-"];
    if (arr && arr.count) {
        newStr = arr[1];
    }
    return newStr;
    
}

- (NSString *)getCurrentDateWithStr:(NSString *)str{
    NSString *newStr = @"";
    NSMutableString *mut = [NSMutableString stringWithString:str];
    NSArray *arr = [mut componentsSeparatedByString:@"-"];
    if (arr && arr.count) {
        newStr = arr.lastObject;
    }
    return newStr;
    
}

- (NSString*)getWeekDay:(NSString*)currentStr

{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    
    NSDate*date =[dateFormat dateFromString:currentStr];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
    
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    
    return[weekdays objectAtIndex:theComponents.weekday];
    
}

@end
