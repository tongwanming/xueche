//
//  ChoosecClassViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosecClassViewController.h"
#import "FirstServiceSystemTableViewCell.h"
#import "TopChoosedClassView.h"
#import "ApplyOrderViewController.h"
#import "FirstCatStyleModel.h"
#import "CustomAlertView.h"
#import "OrderValidityManager.h"
#import "PersonIndentViewController.h"
#import "PersonIndentViewControllerOther.h"
#import "DefaultManager.h"
#import "ChoosedTableViewCell.h"
#import "ChoosedClassTableViewCell.h"
#import "choosedCarTypeViewTap.h"
#import "URLConnectionHelper.h"

#define HEAD_VIEW_HEIGHT 236

@interface ChoosecClassViewController ()<UITableViewDelegate,UITableViewDataSource,TopChoosedClassViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic, strong) UILabel *c1PriceLabel;
//
//@property (nonatomic, strong) UILabel *c2PriceLabel;

@property (nonatomic, strong) ChoosedClassModel *choosedModel;

@property (nonatomic, strong) FirstCatStyleModel *choosedClassModel;

@property (nonatomic, strong) choosedCarTypeViewTap *v1;

@property (nonatomic, strong) choosedCarTypeViewTap *v2;

@property (nonatomic, strong) choosedCarTypeViewTap *v3;

@end

@implementation ChoosecClassViewController{
    NSMutableArray *_coachData;
    UILabel *label2;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)returnActiveWithBlock:(ChoosecClassReturnBlock)block{
    _choosedBlock = block;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _coachData = [[NSMutableArray alloc] init];
    _choosedClassModel = [[FirstCatStyleModel alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    _choosedBtn.layer.masksToBounds = YES;
    _choosedBtn.layer.cornerRadius = 8;

    
    _tableView.hidden = YES;
     [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)getData{
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic =@{@"categoryCode":@"",
                         @"city":@"重庆市",
                         @"district":@"",
                         @"projectTypeCode":@"",
                         @"province":@"重庆市"
                         };
    
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:[NSString stringWithFormat:@"http://%@:7072/order-service/api/common/classType/query",PUBLIC_LOCATION] andDic:dic andSuccessBlock:^(NSArray *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
        });
        if (data == nil || data.count < 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMistake];
            });
            return;
        }
        for (NSDictionary *dic in data) {
            ChoosedClassModel *model = [[ChoosedClassModel alloc] init];
            
            NSArray * arr = [dic objectForKey:@"productList"];
            
            if (arr.count > 1) {
                
                for (NSDictionary *subDic in arr) {
                    
                    if ([[subDic objectForKey:@"projectTypeName"] isEqualToString:@"C1"]) {
                        model.C1Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.productCode1 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"productCode"]];
                        model.isInstalmentsC1 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }else{
                        model.C2Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.productCode2 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"productCode"]];
                        model.isInstalmentsC2 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }
                }
            }else{
                
                for (NSDictionary *subDic in arr) {
                    if ([[subDic objectForKey:@"projectTypeName"] isEqualToString:@"C1"]) {
                        model.C1Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.productCode1 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"productCode"]];
                        model.isInstalmentsC1 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }else{
                        model.C2Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.productCode2 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"productCode"]];
                        model.isInstalmentsC2 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }
                }
            }
            
            model.imageStr = [dic objectForKey:@"imageUrl"];
            model.priceStr = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]];
            model.descStr = [dic objectForKey:@"description"];
            model.titleStr = [dic objectForKey:@"categoryName"];
            model.categoryCode = [dic objectForKey:@"categoryCode"];
            model.contentServers = [dic objectForKey:@"serviceDetails"];
            model.detailPrice = [dic objectForKey:@"feeDetails"];
            [_coachData addObject:model];
        }
        NSLog(@"_coachData:%@",_coachData);
        dispatch_async(dispatch_get_main_queue(), ^{
            _choosedModel = _coachData[0];//默认选中第一个版型
            _choosedClassModel.type = _choosedModel.titleStr;
            _choosedClassModel.price = _choosedModel.C1Str;
            _choosedClassModel.price2 = _choosedModel.C2Str;
            _choosedClassModel.backGroundImageName = _choosedModel.imageStr;
            _tableView.tableHeaderView = [self createHenderView];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andFiledBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
             [self showMistake];
        });
    }];
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        //返回按钮
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        //选择此班型的按钮
//        if (self.choosedBlock) {
//            _choosedBlock(_choosedModel);
//    }
        if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
            //已经完成订单支付
            PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            BOOL isCreateOrder = [[OrderValidityManager defaultManager] orderValidity];
            if (isCreateOrder) {
                PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }else{
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                [dic setObject:_choosedModel.titleStr forKey:@"myClass"];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
                
                FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
                ChoosedClassModel *choosedModel = [DefaultManager shareDefaultManager].carStyleData[1];
                model.type = _choosedModel.titleStr;
                model.price = _choosedModel.C1Str;
                model.price2 = _choosedModel.C2Str;
                model.backGroundImageName = _choosedModel.imageStr;
                model.isInstalments = _choosedModel.isInstalmentsC1;
                model.backGroundImageName = _choosedModel.imageStr;
                model.categoryCode = _choosedModel.categoryCode;
                model.productCode1 = _choosedModel.productCode1;
                model.productCode2 = _choosedModel.productCode2;
                model.projectTypeCode = _choosedModel.projectTypeCode;
                if (_v3.hidden) {
                    if (_v1.isSelected) {
                        //  c1
                        v.appleType = @"C1手动挡";
                        model.projectTypeCode = @"001";
                    }else{
                        //  c2
                        v.appleType = @"C2自动挡";
                        model.projectTypeCode = @"002";
                    }
                }else{
                    // B
                    v.appleType = @"B2大货车班";
                    model.projectTypeCode = @"003";
                }
                v.model = model;
                [self.navigationController pushViewController:v animated:YES];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (_choosedModel.contentServers && _choosedModel.contentServers.length > 0) {
            NSArray *arr = [self arrAddWidthStr:_choosedModel.contentServers];
            
            return arr.count * 40+30;
        }else{
            return 100;
        }
        
    }else{
        if (_choosedModel.detailPrice && _choosedModel.detailPrice.length > 0) {
            NSArray *arr = [self arrAddWidthStr:_choosedModel.detailPrice];
            return 70*arr.count+30;
        }else{
            
            return 275;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
//    FirstServiceSystemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
//    if (!cell) {
//        cell = [FirstServiceSystemTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"FirstServiceSystemTableViewCell"];
//        
//    }
//    cell.name = @"你将获得一下特权：";
//    cell.titleNameLabel.font = [UIFont boldSystemFontOfSize:16];
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        if (!cell) {
            cell = [[ChoosedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
        }
        if (_coachData.count >0 && _coachData.count > indexPath.row) {
            
            ((ChoosedTableViewCell *)cell).str = _choosedModel.contentServers;
        }
    }else if (indexPath.row == 1){
        if (!cell) {
            cell = [[ChoosedClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
        }
        if (_coachData.count >0 && _coachData.count > indexPath.row) {
            ((ChoosedClassTableViewCell *)cell).str = _choosedModel.detailPrice;
        }
        
    }else{
    
    }
    
    
    
    return cell;
}

- (UIView *)createHenderView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEAD_VIEW_HEIGHT+160*TYPERATION)];
        headView.backgroundColor = [UIColor whiteColor];
    
    _choosedModel = _coachData[_currentIndex];
    
    TopChoosedClassView *topSubView = [[TopChoosedClassView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEAD_VIEW_HEIGHT)];
    topSubView.backgroundColor = [UIColor whiteColor];
    topSubView.delegate = self;
    topSubView.dataArr = _coachData;
    topSubView.currentIndex = _currentIndex;
    [headView addSubview:topSubView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(topSubView.frame), CURRENT_BOUNDS.width-40, 16)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = TEXT_COLOR;
    titleLabel.text = @"选择类型:";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:titleLabel];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+20, 60, 13)];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = UNMAIN_TEXT_COLOR;
    label1.text = @"C1手动挡:";
//    label1.backgroundColor = [UIColor redColor];
//    [headView addSubview:label1];
    
    if (((ChoosedClassModel *)_coachData[_currentIndex]).C1Str != nil && ((ChoosedClassModel *)_coachData[_currentIndex]).C2Str != nil) {
        _v1 = [[choosedCarTypeViewTap alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+25, (CURRENT_BOUNDS.width-55)/2, (CURRENT_BOUNDS.width-55)/4) andTitleOne:((ChoosedClassModel *)_coachData[_currentIndex]).C1Str andTitleTwo:@"C1手动挡"];
        _v1.isSelected = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(v1TapSelectedActive:)];
        [_v1 addGestureRecognizer:tap1];
        [headView addSubview:_v1];
        
        _v2 = [[choosedCarTypeViewTap alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_v1.frame)+15, CGRectGetMaxY(titleLabel.frame)+25, (CURRENT_BOUNDS.width-55)/2, (CURRENT_BOUNDS.width-55)/4) andTitleOne:((ChoosedClassModel *)_coachData[_currentIndex]).C2Str andTitleTwo:@"C2自动挡"];
        _v2.isSelected = NO;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(v2TapSelectedActive:)];
        [_v2 addGestureRecognizer:tap2];
        [headView addSubview:_v2];
        
        _v3 = [[choosedCarTypeViewTap alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+25, (CURRENT_BOUNDS.width-40), (CURRENT_BOUNDS.width-55)/4) andTitleOne:((ChoosedClassModel *)_coachData[_currentIndex]).C2Str andTitleTwo:@"B2大货车班"];
        _v3.isSelected = YES;
        _v3.hidden = YES;
        [headView addSubview:_v3];
    }else{
        _v1 = [[choosedCarTypeViewTap alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+25, (CURRENT_BOUNDS.width-55)/2, (CURRENT_BOUNDS.width-55)/4) andTitleOne:((ChoosedClassModel *)_coachData[_currentIndex]).C1Str andTitleTwo:@"C1手动挡"];
        _v1.isSelected = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(v1TapSelectedActive:)];
        [_v1 addGestureRecognizer:tap1];
        _v1.hidden = YES;
        [headView addSubview:_v1];
        
        _v2 = [[choosedCarTypeViewTap alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_v1.frame)+15, CGRectGetMaxY(titleLabel.frame)+25, (CURRENT_BOUNDS.width-55)/2, (CURRENT_BOUNDS.width-55)/4) andTitleOne:((ChoosedClassModel *)_coachData[_currentIndex]).C2Str andTitleTwo:@"C2自动挡"];
        _v2.isSelected = NO;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(v2TapSelectedActive:)];
        [_v2 addGestureRecognizer:tap2];
        _v2.hidden = YES;
        [headView addSubview:_v2];
        
        _v3 = [[choosedCarTypeViewTap alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+25, (CURRENT_BOUNDS.width-40), (CURRENT_BOUNDS.width-55)/4) andTitleOne:((ChoosedClassModel *)_coachData[_currentIndex]).C2Str andTitleTwo:@"B2大货车班"];
        _v3.isSelected = YES;
        _v3.hidden = NO;
        [headView addSubview:_v3];
    }
 
    return headView;
}

#pragma mark -TopChoosedClassViewDelegate
- (void)scrollViewStopWithIndex:(NSIndexPath *)index{
    NSLog(@"---:%ld",(long)index.row);
    if (index.row > 4) {
        return;
    }
    if (!_choosedClassModel) {
        _choosedClassModel = [[FirstCatStyleModel alloc] init];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        label2.hidden = NO;
        if (index.row >2) {
            if (((ChoosedClassModel *)_coachData[index.row]).C1Str) {
                _v1.title1 = ((ChoosedClassModel *)_coachData[index.row]).C1Str;
                _v2.title1 = ((ChoosedClassModel *)_coachData[index.row]).C2Str;
                _v1.hidden = NO;
                _v2.hidden = NO;
                _v3.hidden = YES;
//                _c1PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C1Str];
//                _c2PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C2Str];
            }else{
                _v3.hidden = NO;
                _v1.hidden = YES;
                _v2.hidden = YES;
                _v3.title1 = ((ChoosedClassModel *)_coachData[index.row]).C2Str;
//                _c1PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C2Str];
//                _c2PriceLabel.text = @"";
                label2.hidden = YES;
            }
            
            
            _choosedModel = _coachData[index.row];
            _choosedClassModel.type = _choosedModel.titleStr;
            _choosedClassModel.price = _choosedModel.C1Str;
            _choosedClassModel.backGroundImageName = _choosedModel.imageStr;
            _choosedClassModel.price2 = _choosedModel.C2Str;
        }else{
            _v1.title1 = ((ChoosedClassModel *)_coachData[index.row]).C1Str;
            _v2.title1 = ((ChoosedClassModel *)_coachData[index.row]).C2Str;
            _v2.hidden = NO;
            _v1.hidden = NO;
            _v3.hidden = YES;
//            _c1PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C1Str];
//            _c2PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C2Str];
            _choosedModel = _coachData[index.row];
            _choosedClassModel.type = _choosedModel.titleStr;
            _choosedClassModel.price = _choosedModel.C1Str;
            _choosedClassModel.backGroundImageName = _choosedModel.imageStr;
            _choosedClassModel.price2 = _choosedModel.C2Str;
        }
        [_tableView reloadData];
    });
}

- (void)scrollViewStopWithIndexTwo:(NSIndexPath *)index{
    NSLog(@"---:%ld",(long)index.row);
    
    if (!_choosedClassModel) {
        _choosedClassModel = [[FirstCatStyleModel alloc] init];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        label2.hidden = NO;
        if (index.row >2) {
            if (index.row == 5) {
                _v3.hidden = NO;
                _v2.hidden = YES;
                _v1.hidden = YES;
                _v3.title1 = ((ChoosedClassModel *)_coachData[index.row-2]).C2Str;
                
//                _c1PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row-2]).C2Str];
                _choosedModel = _coachData[index.row-2];
//                _c2PriceLabel.text = @"";
                label2.hidden = YES;
            }else{
                NSString *str1 = ((ChoosedClassModel *)_coachData[index.row-1]).C1Str;
                if (str1 == nil) {
                    _v3.hidden = NO;
                    _v2.hidden = YES;
                    _v1.hidden = YES;
                    _v3.title1 = ((ChoosedClassModel *)_coachData[index.row-1]).C2Str;
                }else{
                    _v1.title1 = ((ChoosedClassModel *)_coachData[index.row-1]).C1Str;
                    _v2.title1 = ((ChoosedClassModel *)_coachData[index.row-1]).C2Str;
                    _v1.hidden = NO;
                    _v2.hidden = NO;
                    _v3.hidden = YES;
                }
                
//                _c1PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row-1]).C1Str];
//                _c2PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row-1]).C2Str];
                _choosedModel = _coachData[index.row-1];
            }
            
            
            
            _choosedClassModel.type = _choosedModel.titleStr;
            _choosedClassModel.price = _choosedModel.C1Str;
            _choosedClassModel.backGroundImageName = _choosedModel.imageStr;
            _choosedClassModel.price2 = _choosedModel.C2Str;
        }else{
            _v1.title1 = ((ChoosedClassModel *)_coachData[index.row]).C1Str;
            _v2.title1 = ((ChoosedClassModel *)_coachData[index.row]).C2Str;
            _v1.hidden = NO;
            _v2.hidden = NO;
            _v3.hidden = YES;
//            _c1PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C1Str];
//            _c2PriceLabel.text = [NSString stringWithFormat:@"¥:%@",((ChoosedClassModel *)_coachData[index.row]).C2Str];
            _choosedModel = _coachData[index.row];
            _choosedClassModel.type = _choosedModel.titleStr;
            _choosedClassModel.price = _choosedModel.C1Str;
            _choosedClassModel.backGroundImageName = _choosedModel.imageStr;
            _choosedClassModel.price2 = _choosedModel.C2Str;
        }
        [_tableView reloadData];
    });
}

- (NSString *)changeTypeWithStr:(NSString *)str{
    int n = [str intValue];
    int newN = n/100;
    
    NSString *newStr = [NSString stringWithFormat:@"%d",newN];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:newStr];
    [mutStr insertString:@"," atIndex:1];
    
    NSString *resultStr = [NSString stringWithString:mutStr];
    
    return resultStr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMistake{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器异常！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [v addAction:active];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:v animated:YES completion:^{
            
        }];
    });
}

//拆分字符串
- (NSArray *)arrAddWidthStr:(NSString *)str{
    
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    
    NSMutableArray *mutArr = [mutStr componentsSeparatedByString:@"#"];
    
    NSArray *arr = [NSArray arrayWithArray:mutArr];
    
    return arr;
}

//点击方法
- (void)v1TapSelectedActive:(UITapGestureRecognizer *)tap{
    _v1.isSelected = YES;
    _v2.isSelected = NO;
}

- (void)v2TapSelectedActive:(UITapGestureRecognizer *)tap{
    _v1.isSelected = NO;
    _v2.isSelected = YES;
}

@end
