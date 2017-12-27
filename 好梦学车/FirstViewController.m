//
//  FirstViewController.m
//  haomengxueche
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstViewController.h"
#import "IdentifyingViewController.h"
#import "SamailerImgBtn.h"
#import "ChoosedPlaceViewController.h"
#import "CustomAlertView.h"
#import "DefaultManager.h"
#import "PersonIndentViewController.h"
#import "OrderValidityManager.h"
#import "PersonIndentViewControllerOther.h"
#import "PersonCenterViewController.h"
#import "SubjectTwoPopWebViewController.h"
#import "installment_ViewController.h"
#import "ServiceStationDetailViewController.h"

//cell
#import "FirstTobTableViewCellSc.h"
#import "FirstCatStyleTableViewCell.h"
#import "FirstLocationTableViewCell.h"
#import "FirstServiceSystemTableViewCell.h"
#import "FirstOfflineTableViewCell.h"

//数据模型
#import "ChoosedClassModel.h"
#import "FirstCatStyleModel.h"
#import "FirstLocationModel.h"
#import "OffLineServerStation.h"

//control
#import "CatStyleApplyNowBtn.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "ManuallyLocateViewController2.h"
#import "ChoosecClassViewController.h"

//test
#import "SinginViewController.h"
#import "ApplyOrderViewController.h"
#import "AppDelegate.h"
#import "URLConnectionHelper.h"
#import "SubjectOneCurrentViewController.h"

@interface FirstNavRightBtn : UIButton

@end

@implementation FirstNavRightBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,FirstCatStyleTableViewCellDelegate,FirstLocationTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *offLineData;

@property (nonatomic, strong) NSMutableArray *imageUrlData;

@property (nonatomic, strong) NSMutableArray *htmlUrlData;

@property (nonatomic, strong) NSArray *locationData;

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) NSString *address;

@end

@implementation FirstViewController{
    NSMutableArray *_coachData;
    UIView *_topView;
    CatStyleApplyNowBtn *letBtn;
    SamailerImgBtn *righBtn;
    BOOL _isCompletedOrder;
}

- (NSMutableArray *)getLocationStyleData{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSArray *typeArr = @[@"距你3.40km",@"距你7.40km",@"距你9.40km"];
    NSArray *priceArr = @[@"竹林公园训练场",@"金星训练场",@"今开训练场"];
    for (int i = 0; i < 3; i++) {
        FirstLocationModel *model = [[FirstLocationModel alloc] init];
//        model.backGroundImageName = imageArr[i];
        model.distance = typeArr[i];
        model.LocationName = priceArr[i];
        [arr addObject:model];
    }
    return arr;
}


//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
//    [self setStatusBarBackgroundColor:[UIColor blackColor]];
    
    
    _coachData = [[NSMutableArray alloc] init];
    _dataDic = [[NSMutableDictionary alloc] init];
    _offLineData = [[NSMutableArray alloc] init];
    _locationData = [[NSArray alloc] init];
    _htmlUrlData = [[NSMutableArray alloc] init];
    self.navigationController.title = @"好梦学车";
    _imageUrlData = [[NSMutableArray alloc] init];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 64)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.alpha = 0;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, CURRENT_BOUNDS.width, 0.5)];
    lineView.backgroundColor = EEEEEE;
    [_topView addSubview:lineView];
    
    
    letBtn = [CatStyleApplyNowBtn buttonWithType:UIButtonTypeCustom];
//    [letBtn setImage:[UIImage imageNamed:@"index_go"] forState:UIControlStateNormal];
    [letBtn setTitle:@"重庆" forState:UIControlStateNormal];
    letBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    [letBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    letBtn.frame = CGRectMake(16, 20, 80, 44);
    
    
    righBtn = [SamailerImgBtn buttonWithType:UIButtonTypeCustom];
    [righBtn setImage:[UIImage imageNamed:@"nav_btn_service"] forState:UIControlStateNormal];
//    righBtn.contentMode = UIViewContentModeScaleAspectFill;
    //    letBtn.backgroundColor = [UIColor redColor];
    [righBtn addTarget:self action:@selector(rightBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    righBtn.frame = CGRectMake(CURRENT_BOUNDS.width-60, 20, 44, 44);
   
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50+20) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
//    _tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    [self.view addSubview:_topView];
    [self.view addSubview:righBtn];
    [self.view addSubview:letBtn];
    [self getScrollViewDataWithProvince:@"重庆市"];
    [self loadDataWithServerStation];
    
    [self loadCarTypeData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getScrollViewDataWithProvince:(NSString *)province{
    if (_imageUrlData.count > 0) {
        return;
    }
    NSDictionary *dic =@{@"imageType":@"STU_APP_INDEX",@"city":province};
    
    
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:[NSString stringWithFormat:@"http://%@:7072/order-service/api/common/carouse/query",PUBLIC_LOCATION] andDic:dic andSuccessBlock:^(NSArray *data) {
        
        [_imageUrlData removeAllObjects];
        [_htmlUrlData removeAllObjects];
        for (NSDictionary *dic in data) {
            NSString *str = [dic objectForKey:@"imageUrl"];
            [_imageUrlData addObject:str];
            [_htmlUrlData addObject:[dic objectForKey:@"imageLinks"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andFiledBlock:^(NSError *error) {
        UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [v addAction:active];
        [self presentViewController:v animated:YES completion:^{
            
        }];
    }];
}

- (void)leftBtnActive:(UIButton *)btn{
    
    return;
    __weak __typeof(&*self) weakSelf=self;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [weakSelf shareImageToPlatformType:platformType];
    }];
    
}

- (void)rightBtnActive:(UIButton *)btn{
    SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
    v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
    v.titleStr = @"在线咨询";
    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
    }
//    [self.navigationController pushViewController:v animated:YES];
}

- (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe {
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIColor *redColor = [UIColor clearColor];
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [redColor CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
        return _offLineData.count;
    }else
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 100;
    switch (indexPath.section) {
        case 0:
            height = 274*TYPERATION;
            break;
        case 1:
            height = 382/2;
            break;
        case 2:
            height = 405;
            break;
        case 3:
            height = 275;
            break;
        case 4:
            height = 95;
            break;
            
        default:
            break;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"indexPath";
    UITableViewCell *cell = [_dataDic objectForKey:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == 0) {
        if (!cell) {
            cell = [FirstTobTableViewCellSc cellWithTableToDequeueReusable:tableView identifier:index nibName:@"FirstTobTableViewCellSc"];
            [_dataDic setObject:cell forKey:indexPath];
        }
        ((FirstTobTableViewCellSc *)cell).arr = _imageUrlData;
        
        [((FirstTobTableViewCellSc *)cell) addBlockActive:^(NSInteger tag) {
            NSString *url = _htmlUrlData[tag];
            SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
            v.url = url;
            v.titleStr = @"详情界面";
            if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
            }
//            [self.navigationController pushViewController:v animated:YES];
        }];
    }else if (indexPath.section == 1){
        if (!cell) {
            cell = [FirstCatStyleTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"FirstCatStyleTableViewCell"];
             [_dataDic setObject:cell forKey:indexPath];
        }
        ((FirstCatStyleTableViewCell *)cell).dataArray = _coachData;
        ((FirstCatStyleTableViewCell *)cell).delegate = self;
    }else if (indexPath.section == 2){
        if (!cell) {
            cell = [FirstLocationTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"FirstLocationTableViewCell"];
             [_dataDic setObject:cell forKey:indexPath];
        }
        ((FirstLocationTableViewCell *)cell).dataArray = [self getLocationStyleData];
        ((FirstLocationTableViewCell *)cell).delegate = self;
         [((FirstLocationTableViewCell *)cell) retunLoadDataWithBlock:^(NSArray *data) {
             _locationData = data;
             [DefaultManager shareDefaultManager].locationData = data;
         }];
        
        __weak __typeof (&*self) weakSelf = self;
    
        [((FirstLocationTableViewCell *)cell) retunLoadDataWithProvinceBlock:^(NSString *province, NSString *address) {
//            [weakSelf getScrollViewDataWithProvince:province];
//            [weakSelf loadDataWithServerStation];
//            
//            [weakSelf loadCarTypeData];
            weakSelf.address = address;
        }];
        [((FirstLocationTableViewCell *)cell) returnCoordinateBlock:^(CLLocationCoordinate2D coordinate) {
            weakSelf.coordinate = coordinate;
        }];
    }else if (indexPath.section == 3){
        if (!cell) {
            cell = [FirstServiceSystemTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"FirstServiceSystemTableViewCell"];
             [_dataDic setObject:cell forKey:indexPath];
        }
    
    }else if (indexPath.section == 4){
        if (!cell) {
            cell = [FirstOfflineTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"FirstOfflineTableViewCell"];
             [_dataDic setObject:cell forKey:indexPath];
        }
        ((FirstOfflineTableViewCell *)cell).model = _offLineData[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    
    }else{
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
             [_dataDic setObject:cell forKey:indexPath];
        }
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
    
        ServiceStationDetailViewController *v = [[ServiceStationDetailViewController alloc] init];
        v.model = _offLineData[indexPath.row];
//        v.latitude = [NSString stringWithFormat:@"%f",self.coordinate.latitude];
//        v.longitude = [NSString stringWithFormat:@"%f",self.coordinate.longitude];
        v.address = self.address;
        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
        }
//        [self.navigationController pushViewController:v animated:YES];
        NSLog(@"点击线下服务站");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 4){
        return 46;
    }else
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 100;
    }else
        return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 46)];
        view.backgroundColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.93f alpha:1.00f];;
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width, 36)];
        subView.backgroundColor = [UIColor whiteColor];
        [view addSubview:subView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, tableView.frame.size.width, 16)];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textColor = TEXT_COLOR;
        [view addSubview:titleLabel];
        titleLabel.text = @"专业线下服务站";
        titleLabel.backgroundColor = [UIColor clearColor];
        
        return view;
    }else
        return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4 && !_isCompletedOrder) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 200)];
        view.backgroundColor = [UIColor clearColor];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300*TYPERATION, 60)];
//        imageView.center = CGPointMake(CURRENT_BOUNDS.width/2, 30+60/2);
//        imageView.image = [UIImage imageNamed:@"btn_homepage_signup"];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = 30;
//        imageView.backgroundColor = [UIColor redColor];
//        [view addSubview:imageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width-50, 50);
        btn.center = CGPointMake(CURRENT_BOUNDS.width/2, 30+60/2);
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"立即报名" forState:UIControlStateNormal];
        btn.titleLabel.textColor = WHITE_TEXT_COLOR;
        btn.backgroundColor = [UIColor clearColor];
        btn.backgroundColor = BLUE_BACKGROUND_COLOR;
//        [btn setImage:[UIImage imageNamed:@"btn_homepage_signup"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"btn_homepage_signup"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(signUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        
        
        [view addSubview:btn];
        
        
        
        
        
        return view;
    }else
        return nil;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
//    NSLog(@"%f--%lf",scrollView.contentOffset.y,velocity);
    if (scrollView.contentOffset.y >= 50) {
        //向上拖动，隐藏导航栏

        _topView.alpha = 1;
        [letBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [letBtn setImage:[UIImage imageNamed:@"index_go_black"] forState:UIControlStateNormal];
        [righBtn setImage:[UIImage imageNamed:@"btn_service"] forState:UIControlStateNormal];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else if ( scrollView.contentOffset.y < 50) {
        //向下拖动，显示导航栏

        
        _topView.alpha = 0;
        [letBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [letBtn setImage:[UIImage imageNamed:@"index_go"] forState:UIControlStateNormal];
        [righBtn setImage:[UIImage imageNamed:@"nav_btn_service"] forState:UIControlStateNormal];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else if(velocity == 0){
        //停止拖拽
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {

    //singIn
    SinginViewController *v = [[SinginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
//    [self.navigationController pushViewController:v animated:YES];
    //ApplyOrder
//    ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
//    [self.navigationController pushViewController:v animated:YES];
    
//
   
}

- (void)signUpBtnClick:(UIButton *)btn{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *choosedType = [userDic objectForKey:@"choosedPayType"];
    NSString *payNum = [userDic objectForKey:@"payNum"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
            //已经完成订单支付
            if ([choosedType isEqualToString:@"ONLINE"]) {
                PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
                if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
//                [self.navigationController pushViewController:v animated:YES];
            }else{
                installment_ViewController *v = [[installment_ViewController alloc] init];
                v.payNum = payNum;
                if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
//                [self.navigationController pushViewController:v animated:YES];
            }
            
            
            
        }else{
            BOOL isCreateOrder = [[OrderValidityManager defaultManager] orderValidity];
            
            if ([choosedType isEqualToString:@"ONLINE"]) {
                if (isCreateOrder) {
                    
                    PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                    }
//                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (_coachData.count < 1) {
                        [self showMistake];
                    }else{
                        ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
                        FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
                        ChoosedClassModel *choosedModel = _coachData[1];
                        model.type = choosedModel.titleStr;
                        model.price = choosedModel.C1Str;
                        model.price2 = choosedModel.C2Str;
                        model.isInstalments = choosedModel.isInstalmentsC1;
                        model.backGroundImageName = choosedModel.imageStr;
                        model.categoryCode = choosedModel.categoryCode;
                        model.projectTypeCode = choosedModel.projectTypeCode;
                        v.model = model;
                        v.data = _offLineData;
                        v.locationData = _locationData;
                        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                        }
//                        [self.navigationController pushViewController:v animated:YES];
                    }
                    
                }
            }else{
                if (choosedType && choosedType.length > 0) {
                    installment_ViewController *v = [[installment_ViewController alloc] init];
                    v.payNum = payNum;
                    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                    }
//                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (_coachData.count < 1) {
                        [self showMistake];
                    }else{
                        ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
                        FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
                        ChoosedClassModel *choosedModel = _coachData[1];
                        model.type = choosedModel.titleStr;
                        model.price = choosedModel.C1Str;
                        model.price2 = choosedModel.C2Str;
                        model.isInstalments = choosedModel.isInstalmentsC1;
                        model.backGroundImageName = choosedModel.imageStr;
                        model.categoryCode = choosedModel.categoryCode;
                        model.projectTypeCode = choosedModel.projectTypeCode;
                        v.model = model;
                        v.data = _offLineData;
                        v.locationData = _locationData;
                        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                        }
//                        [self.navigationController pushViewController:v animated:YES];
                    }
                }
            }
            
        }
        
    }else{
        IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
        }
//        [self.navigationController pushViewController:v animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

   
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
    
    NSLog(@"子界面进入");
    
    if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
        _isCompletedOrder = YES;
    }else{
        _isCompletedOrder = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if (_topView.alpha == 0) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if ([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleLightContent) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    NSLog(@"子界面退出");
}

#pragma mark - FirstCatStyleTableViewCellDelegate

- (void)tapTopScrollviewWithTag:(NSInteger)tag{
    
}

- (void)firstCatStyleTableViewCellSubCellDidSelectActiveAndIndex:(NSIndexPath *)indexPath{
    NSLog(@"当前选择的行数：%ld",(long)indexPath.row);
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *choosedType = [userDic objectForKey:@"choosedPayType"];
    NSString *payNum = [userDic objectForKey:@"payNum"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
            //已经完成订单支付
            if ([choosedType isEqualToString:@"ONLINE"]) {
                PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
                if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
//                [self.navigationController pushViewController:v animated:YES];
            }else{
                installment_ViewController *v = [[installment_ViewController alloc] init];
                v.payNum = payNum;
                if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
//                [self.navigationController pushViewController:v animated:YES];
            }
        }else{
            BOOL isCreateOrder = [[OrderValidityManager defaultManager] orderValidity];
            
            if ([choosedType isEqualToString:@"ONLINE"]) {
                if (isCreateOrder) {
                    PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                    }
//                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (_coachData.count < 1) {
                        [self showMistake];
                    }else{
                        ChoosecClassViewController *v = [[ChoosecClassViewController alloc] init];
                        v.currentIndex = (int)indexPath.row;
                        [v returnActiveWithBlock:^(ChoosedClassModel *model) {
                            NSLog(@"%@",model.C1Str);
                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                            [dic setObject:model.titleStr forKey:@"myClass"];
                            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                        }];
                        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                        }
//                        [self.navigationController pushViewController:v animated:YES];
                    }
                }
            }else{
                if (choosedType && choosedType.length > 0) {
                    installment_ViewController *v = [[installment_ViewController alloc] init];
                    v.payNum = payNum;
                    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                    }
//                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (_coachData.count < 1) {
                        [self showMistake];
                    }else{
                        ChoosecClassViewController *v = [[ChoosecClassViewController alloc] init];
                        v.currentIndex = (int)indexPath.row;
                        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                        }
//                        [v returnActiveWithBlock:^(ChoosedClassModel *model) {
//                            NSLog(@"%@",model.C1Str);
//                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
//                            [dic setObject:model.titleStr forKey:@"myClass"];
//                            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
//                        }];
//                        [self.navigationController pushViewController:v animated:YES];
                    }
                }
            }
        }
    }else{
        IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
        }
//        IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
//        [self.navigationController pushViewController:v animated:YES];
    }
}

#pragma mark -locationTableViewCellDelegate

-(void)searchActive{
    ManuallyLocateViewController2 *v = [[ManuallyLocateViewController2 alloc] init];
    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"2"];
    }
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
//
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
}

- (void)firstLocationTableViewCellSubCellSelectActive:(NSIndexPath *)indexpath andData:(NSArray *)array{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *choosedType = [userDic objectForKey:@"choosedPayType"];
    NSString *payNum = [userDic objectForKey:@"payNum"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        
        if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
            //已经完成订单支付
            if ([choosedType isEqualToString:@"ONLINE"]) {
                PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
                if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
//                [self.navigationController pushViewController:v animated:YES];
            }else{
                installment_ViewController *v = [[installment_ViewController alloc] init];
                v.payNum = payNum;
                if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
//                [self.navigationController pushViewController:v animated:YES];
            }
        }else{
            BOOL isCreateOrder = [[OrderValidityManager defaultManager] orderValidity];
            
            if ([choosedType isEqualToString:@"ONLINE"]) {
                if (isCreateOrder) {
                    PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                    }
//                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (array.count < 1) {
                        [self showMistake];
                    }else{
                        //预选场地
                        ChoosedPlaceViewController *typeVc = [[ChoosedPlaceViewController alloc] init];
                        typeVc.allExerciseLocationData = array;
                        typeVc.isByPersonVC = YES;
                        [typeVc returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
                            [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
                        }];
                        
                        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:typeVc withObject:@"1"];
                        }
//                        [self.navigationController pushViewController:typeVc animated:YES];
                    }
                }
            }else{
                if (choosedType && choosedType.length > 0) {
                    installment_ViewController *v = [[installment_ViewController alloc] init];
                    v.payNum = payNum;
                    if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                        [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                    }
//                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (array.count < 1) {
                        [self showMistake];
                    }else{
                        //预选场地
                        ChoosedPlaceViewController *typeVc = [[ChoosedPlaceViewController alloc] init];
                        typeVc.allExerciseLocationData = array;
                        typeVc.isByPersonVC = YES;
                        [typeVc returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
                            [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
                        }];
//                        SubjectOneCurrentViewController *typeVc = [[SubjectOneCurrentViewController alloc] init];
//                        typeVc.locationData = array;
                       
                        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
                            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:typeVc withObject:@"1"];
                        }
//                        [self.navigationController pushViewController:typeVc animated:YES];
                    }
                }
            }
        }
    }else{
        IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
        if ([self.delegate respondsToSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:)]) {
            [self.delegate performSelector:@selector(FirstViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
        }
//        [self.navigationController pushViewController:v animated:YES];
    }
}


#pragma mark - loadDataWith专业线下服务站
- (void)loadDataWithServerStation{
    NSDictionary *dic = @{
                          @"city":@"重庆",
                          @"district":@"",
                          @"name":@"",
                          @"province":@"重庆"
                          };
    
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:[NSString stringWithFormat:@"http://%@:7072/manage-service/serviceStation/findServiceStation",PUBLIC_LOCATION] andDic:dic andSuccessBlock:^(NSArray *data) {
        [_offLineData removeAllObjects];
        
      
        //                NSLog(@"%@",jsonDict);
        for (NSDictionary *dic in data) {
            OffLineServerStation *model = [[OffLineServerStation alloc] init];
            model.address = [dic objectForKey:@"address"];
            model.city = [dic objectForKey:@"city"];
            model.district = [dic objectForKey:@"district"];
            model.offLineServerId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            model.latitude = [dic objectForKey:@"latitude"];
            model.longitude = [dic objectForKey:@"longitude"];
            model.name = [dic objectForKey:@"name"];
            model.phone = [dic objectForKey:@"phone"];
            model.province = [dic objectForKey:@"province"];
            model.imageUrl = [dic objectForKey:@"imageUrl"];
            
            model.mapImageUrl = [dic objectForKey:@"mapImageUrl"];
            model.lightRailDes = [dic objectForKey:@"lightRailDes"];
            model.publicBusName = [dic objectForKey:@"publicBusName"];
            model.publicBusDes = [dic objectForKey:@"publicBusDes"];
            [_offLineData addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andFiledBlock:^(NSError *error) {
        UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [v addAction:active];
        [self presentViewController:v animated:YES completion:^{
            
        }];
    }];
    
    
    
}

- (void)loadCarTypeData{
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic =@{@"categoryCode":@"",@"city":@"重庆市"};
    [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:[NSString stringWithFormat:@"http://%@:7072/order-service/api/common/classType/query",PUBLIC_LOCATION] andDic:dic andSuccessBlock:^(NSArray *data) {
        if (_coachData.count > 0 ) {
            [_coachData removeAllObjects];
        }
        for (NSDictionary *dic in data) {
            ChoosedClassModel *model = [[ChoosedClassModel alloc] init];
            
            NSArray * arr = [dic objectForKey:@"productList"];
            
            if (arr.count > 1) {
                
                for (NSDictionary *subDic in arr) {
                    NSLog(@"%@--%@",[subDic objectForKey:@"price"],[subDic objectForKey:@"isInstalments"]);
                    if ([[subDic objectForKey:@"projectTypeName"] isEqualToString:@"C1"]) {
                        model.C1Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.isInstalmentsC1 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }else{
                        model.C2Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.isInstalmentsC2 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        //                                model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }
                    
                }
            }else{
                
                for (NSDictionary *subDic in arr) {
                    if ([[subDic objectForKey:@"projectTypeName"] isEqualToString:@"C1"]) {
                        model.C1Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.isInstalmentsC1 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }else{
                        model.C2Str = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[subDic objectForKey:@"price"]]];
                        model.isInstalmentsC2 = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"isInstalments"]];
                        model.projectTypeCode = [NSString stringWithFormat:@"%@",[subDic objectForKey:@"projectTypeCode"]];
                    }
                }
            }
            
            model.categoryCode = [dic objectForKey:@"categoryCode"];
            model.imageStr = [dic objectForKey:@"imageUrl"];
            model.priceStr = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]];
            model.descStr = [dic objectForKey:@"description"];
            model.titleStr = [dic objectForKey:@"categoryName"];
            
            [_coachData addObject:model];
        }
        self.carClassData = _coachData;
        ((AppDelegate *)[[UIApplication sharedApplication]delegate]).carClassData = _coachData;
        [DefaultManager shareDefaultManager].carStyleData = _coachData;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
        });
        
    } andFiledBlock:^(NSError *error) {
        UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [v addAction:active];
        [self presentViewController:v animated:YES completion:^{
            
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
        });
    }];
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

- (void)showMistake{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器异常！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:v animated:YES completion:^{
            
        }];
    });
}

//um--test
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    NSString * _shareTitle =@"title";
    NSString *   _shareImg = @"image";
    NSString * _shareIntro = @"desc";
    
   // NSString *urlKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:_shareImg]];
    
    //UIImage *image =  [[SDImageCache sharedImageCache] imageFromCacheForKey:urlKey];
    UIImage *image;
    if (!image) {
        image = [UIImage imageNamed:@"icon_order_two@3x"];
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
#warning 图片!
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_shareTitle descr:_shareIntro thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = @"www.baidu.com";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
//            [self shareError];
            NSString * result = [NSString string];
            switch (error.code) {
                case UMSocialPlatformErrorType_Unknow:
                    break;
                case UMSocialPlatformErrorType_NotSupport:
                    result = @"不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持";
                    break;
                case UMSocialPlatformErrorType_AuthorizeFailed:
                    result = @"授权失败";
                    break;
                case UMSocialPlatformErrorType_ShareFailed:
                    result = @"分享失败";
                    break;
                case UMSocialPlatformErrorType_RequestForUserProfileFailed:
                    result = @"请求用户信息失败";
                    break;
                case UMSocialPlatformErrorType_ShareDataNil:
                    result = @"分享内容为空";
                    break;
                case UMSocialPlatformErrorType_ShareDataTypeIllegal:
                    result = @"分享内容不支持";
                    break;
                case UMSocialPlatformErrorType_CheckUrlSchemaFail:
                    result = @"schemaurl fail";
                    break;
                case UMSocialPlatformErrorType_NotInstall:
                    result = @"应用未安装";
                    break;
                case UMSocialPlatformErrorType_Cancel:
                    result = @"您已取消分享";
                    break;
                case UMSocialPlatformErrorType_NotNetWork:
                    result = @"网络异常";
                    break;
                case UMSocialPlatformErrorType_SourceError:
                    result = @"第三方错误";
                    break;
                case UMSocialPlatformErrorType_ProtocolNotOverride:
                    result = @"对应的UMSocialPlatformProvider的方法没有实现";
                    break;
                default:
                    break;
            }
//            MBShowError(result);
        }else{
//            DLog(@"response data is %@",data);
            //如果是车圈的分享成功了刷新车圈分享数量?
//            if ([User sharedUser].shareChequan) {
//                [User sharedUser].shareChequan = NO;
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadChequanTableViewData" object:nil];
//            }
//            MBShowError(@"分享成功!");
//            [self shareSuccess];
        }
    }];
}
//分别在分享成功与失败后调用  让后台知道
//- (void)shareSuccess{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:NUM([self.shareDic[@"sid"] intValue]),@"sid", nil];
//    NSString * url = @"user/share.json?do=save_succeed";
//    [YCLHttp postUrlString:url needLogin:YES parmsDic:dic success:^(id responseObj) {
//        DLog(@"%@",responseObj);
//    } failure:^(NSError *error) {
//        DLog(@"%@",error);
//    }];
//}
//- (void)shareError{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:NUM([self.shareDic[@"sid"] intValue]),@"sid", nil];
//    NSString * url = @"user/share.json?do=save_failed";
//    [YCLHttp postUrlString:url needLogin:YES parmsDic:dic success:^(id responseObj) {
//        DLog(@"%@",responseObj);
//    } failure:^(NSError *error) {
//        DLog(@"%@",error);
//    }];
//}


@end
