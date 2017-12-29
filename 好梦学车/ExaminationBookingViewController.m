//
//  ExaminationBookingViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ExaminationBookingViewController.h"
#import "SubscribeTestViewController.h"
#import "URLConnectionHelper.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.m"
#import "CustomAlertView.h"
#import "Masonry.h"
#define footViewHeight 400

@interface ExaminationBookingViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ExaminationBookingViewController
{
    NSArray *_data1;
    NSArray *_data2;
    UIImageView *_testView;
    NSString *_verifyCode;
    UITextField *_textFiled;
    UITextField *_textFiled1;
    UITextField *_textFiled2;
}
- (IBAction)btnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
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
    
    _data1 = @[@"姓名",@"证件号码",@"手机号码",@"准驾车型"];
    

    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applySuccessActive:) name:@"applySuccess" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)applySuccessActive:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
}

- (void)keyboardDidShow:(NSNotification *)notification{
    
    //kbSize即為鍵盤尺寸 (有width, height)
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.top).offset(-100);
                make.bottom.equalTo(self.view.bottom);
                make.left.equalTo(self.view.left);
                make.right.equalTo(self.view.right);
            }];
        }];
    });
}

- (void)keyboardDidHide:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.top).offset(104);
                make.bottom.equalTo(self.view.bottom);
                make.left.equalTo(self.view.left);
                make.right.equalTo(self.view.right);
            }];
        }];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

#pragma mark - textFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1001) {
        [_textFiled1 becomeFirstResponder];
    }else if (textField.tag == 1002){
        [_textFiled2 becomeFirstResponder];
    }else{
        [_textFiled2 resignFirstResponder];
        [self getLoginActive];
    }
    NSLog(@"%@",textField);
    return NO;
}

- (UIView *)createFootView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, footViewHeight)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *topImagve = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    topImagve.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, 8);
//    topImagve.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:topImagve];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topImagve.frame), CURRENT_BOUNDS.width, 15)];
    topView.backgroundColor = EEEEEE;
    [view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+31, CURRENT_BOUNDS.width, 15)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"122平台登陆";
    titleLabel.textColor = TEXT_COLOR;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [view addSubview:titleLabel];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_account"]];
    logoView.frame = CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(titleLabel.frame)+26, 15, 15);
//    logoView.backgroundColor = [UIColor redColor];
    [view addSubview:logoView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView.frame), 230, 0.5)];
    lineView.backgroundColor = EEEEEE;
    [view addSubview:lineView];
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoView.frame)+22,  CGRectGetMaxY(logoView.frame)-16, 150, 13)];
    _textFiled.borderStyle = UITextBorderStyleNone;
    _textFiled.textColor = UNMAIN_TEXT_COLOR;
    _textFiled.font = [UIFont systemFontOfSize:13];
    _textFiled.textAlignment = NSTextAlignmentLeft;
    _textFiled.placeholder = @"输入账号，身份证";
    _textFiled.delegate = self;
    _textFiled.tag = 1001;
    [view addSubview:_textFiled];
    
    UIImageView *logoView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_password"]];
    logoView1.frame = CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView.frame)+20, 15, 15);
//    logoView1.backgroundColor = [UIColor redColor];
    [view addSubview:logoView1];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView1.frame), 230, 0.5)];
    lineView1.backgroundColor = EEEEEE;
    [view addSubview:lineView1];
    
    _textFiled1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoView.frame)+22,  CGRectGetMaxY(logoView1.frame)-16, 150, 13)];
    _textFiled1.borderStyle = UITextBorderStyleNone;
    _textFiled1.textColor = UNMAIN_TEXT_COLOR;
    _textFiled1.font = [UIFont systemFontOfSize:13];
    _textFiled1.textAlignment = NSTextAlignmentLeft;
    _textFiled1.placeholder = @"输入密码";
    _textFiled1.delegate = self;
    _textFiled1.tag = 1002;
    _textFiled1.secureTextEntry = YES;
    [view addSubview:_textFiled1];
    
    UIImageView *logoView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_verification"]];
    logoView2.frame = CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView1.frame)+20, 15, 15);
  
    [view addSubview:logoView2];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake((CURRENT_BOUNDS.width-200)/2*TYPERATION, CGRectGetMaxY(logoView2.frame), 100, 0.5)];
    lineView2.backgroundColor = EEEEEE;
    [view addSubview:lineView2];
    
    _textFiled2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoView.frame)+22,  CGRectGetMaxY(logoView2.frame)-16, 80, 13)];
    _textFiled2.tag = 1003;
    _textFiled2.borderStyle = UITextBorderStyleNone;
    _textFiled2.textColor = UNMAIN_TEXT_COLOR;
    _textFiled2.font = [UIFont systemFontOfSize:13];
    _textFiled2.textAlignment = NSTextAlignmentLeft;
    _textFiled2.placeholder = @"输入验证码";
    
    _textFiled2.delegate = self;
    [view addSubview:_textFiled2];
    
       NSString * src=@"data:image/jpeg;base64,R0lGODlhQQAZAPUAAAAAAF8VKkUoaGkpQVhdHHV9rnWmwaV7lbLHdqagi9XS2tbT3tTc1tbd1dbf1dXb3t7T3tje0tnd19/Y09va39jd2NfU4djU5N/T49va497b4dbj09Lg3t/i09zj1Nrh2NPk5dji4Njj4t3h49zg5d7k4ODW1eLW1ODT3OHY1OXb1+XX4+Ld5eLf5OLi1+Pi3eTh5ebv7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAQQAZAEUI/wAPCBxIsKDBgwgTKly4IIbDGBpiDJh4wOGEiTFCmBDAMcaFCw4tcBRgIQYBAhJSqlypMkCAlBQcuJTw8CGAig4bMtjpcOKAmg5HhgA60uFJhx9PAI3hMoaCpyNcgoiBIAaFElhLHADAtavXrwBWAKhQAQAHDg0aoFj7VQVYrxMYFJjLAMAFABs2nADrogPOhxMmLHV44mMMCIghDF68OIVVl5ADLL4Zo6GIyxF7TlSh4u/Iz6AvnDhJ+ihQCC4tlIRMoaaDBLD/VnaY2eHZmi0emoixkzMDoHMLTOhAvPiFvEoXZ8jwEMEI2YNPKIXwoLr169iza79OYft26BIHHP8IXBOjSI4lHSIuarI06cEuWzNtupRyQ9oPfYoHHIL9wwvsnURCDKoVCFRkLsGWgAMOPGTAgzjdB1F+E13mkAox+EdegAQoRQILD3nwlEP0HYZaABZQ8MKKDlH20H0anOXTTjQyMJIJnD1U1ATukXZccgi6tNxTTyGAAAUeeAAdjECRFcNtMbTQAgZUVmmllTwFByJSx20Aw5dgfumCC2CCV1NyjKWp5kPyDfbBB0C5aNFi0l2Q2Jp41tQmY29+AJ1PggFlwUQAdnRnhh211+NSKQRZYk1ylrcfeRhpNNIFBZY0EmKmqelSCvI9atMBEk4YnngHTERef4l6BFJRFpzUpBpijNHXaAANSvCgASpVtIAID2Wm3346gmasUYsSmKmjoCoIW4sRBnuZCD5diCGiAsRAXlAdXWDah4u5hFiB8b3gmgPR4qfZTzFYqIJ/FnGYFLg1PeXSCCOAMJW4EFDg2Iov/CWhBjtVSxRH1xYrgGA9noTmfI7mCwICEVAQwcWyMfkkB7jlViMDIST80FyBEefQh10+DNRyDhWp75LqxkDWWRxHmVsMuw0VgwofjzxXmEB/OZgLzDmEgJmm1rSCk1DullFNOT50JQbBTW01lS5QGRAAOw==";
    NSArray *imageArray = [src componentsSeparatedByString:@","];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageArray[1] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    
    _testView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_password"]];
    _testView.frame = CGRectMake(CGRectGetMaxX(_textFiled2.frame), CGRectGetMaxY(logoView2.frame)-20, 60, 19);
//    _testView.backgroundColor = [UIColor redColor];
    _testView.image = [UIImage imageWithData:imageData];
    [view addSubview:_testView];
    
    UIButton *logoBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    logoBtn2.frame = CGRectMake(CGRectGetMaxX(_testView.frame), CGRectGetMaxY(logoView2.frame)-16-10, 80, 30);
    logoBtn2.backgroundColor = [UIColor whiteColor];
    [logoBtn2 setTitle:@"换一张" forState: UIControlStateNormal];
    logoBtn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoBtn2 setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
//    logoBtn2.backgroundColor = [UIColor redColor];
    [logoBtn2 addTarget:self action:@selector(logoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   logoBtn2.tag = 1002;
    [view addSubview:logoBtn2];
    
    UIButton *logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoBtn.frame = CGRectMake((CURRENT_BOUNDS.width-220)/2*TYPERATION, CGRectGetMaxY(_textFiled2.frame)+30, 220, 40);
    logoBtn.backgroundColor = BLUE_BACKGROUND_COLOR;
    [logoBtn setTitle:@"立即登陆" forState: UIControlStateNormal];
    logoBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [logoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoBtn addTarget:self action:@selector(logoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    logoBtn.layer.masksToBounds = YES;
    logoBtn.layer.cornerRadius = 20;
    logoBtn.tag = 1001;
    [view addSubview:logoBtn];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoBtn.frame)+20, CURRENT_BOUNDS.width, 18)];
    tipsLabel.font = [UIFont systemFontOfSize:11];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = ADB1B9;
    tipsLabel.text = @"请根据12123500（重庆交巡警）发送的短信内容进行登录";
    [view addSubview:tipsLabel];
    
    return view;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _textFiled2) {
        [self getData];
    }
}

- (void)logoBtnClick:(UIButton *)btn{
    if (btn.tag == 1001) {
    
        if (_textFiled.text.length < 1 || _textFiled2.text.length <1 || _textFiled1.text.length <1) {
            [_textFiled2 resignFirstResponder];
             [_textFiled1 resignFirstResponder];
             [_textFiled resignFirstResponder];
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"输入错误，请检查输入的密码、账号和验证码！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
        }else{
            [_textFiled2 resignFirstResponder];
            [_textFiled1 resignFirstResponder];
            [_textFiled resignFirstResponder];
            [self getLoginActive];
        }
        
        
        NSLog(@"btn Click");
    }else if (btn.tag == 1002){
        
        [self getData];
    }
    else{
        
    }
}

- (void)setModel:(ProgressDataModel *)model{
    _model = model;
    _data2 = @[_model.realName,_model.idCard,_model.phone,_model.subject];
}

- (void)getData{
    NSDictionary *dic = @{@"username":_textFiled.text};
    NSString *url = @"http://101.37.161.13:7072/fecthdata-front-service/student/v201701/exam/check/image";
    [CustomAlertView showAlertViewWithVC:self];
    
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:url andDic:dic andSuccessBlock:^(NSArray *data) {
        NSLog(@"%@",data);
        
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:data[0] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _testView.image = [UIImage imageWithData:imageData];
        });
    } andDicFiledResonBlock:^(NSObject *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
    }];
    
}

- (void)getLoginActive{
    NSDictionary *dic = @{@"username":_textFiled.text,
                          @"password":_textFiled1.text,
                          @"verifyCode":_textFiled2.text,
                          };
    NSString *url = @"http://101.37.161.13:7072/fecthdata-front-service/student/v201701/imitate/login";
    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:url andDic:dic andSuccessBlock:^(NSArray *data) {
        NSLog(@"%@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            [self checkCanJoinExnation];
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

- (void)checkCanJoinExnation{
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic = @{@"username":_textFiled.text,
                          @"subject":@"2"
                          };
    NSString *url = @"http://101.37.161.13:7072/fecthdata-front-service/student/v201701/exam/check";

    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:url andDic:dic andSuccessBlock:^(NSArray *data) {
        NSLog(@"%@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            SubscribeTestViewController *v = [[SubscribeTestViewController alloc] init];
            v.userName = _textFiled.text;
            v.kskm = @"2";
            [self.navigationController pushViewController:v animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
