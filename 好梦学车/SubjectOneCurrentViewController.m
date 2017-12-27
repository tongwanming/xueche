//
//  SubjectOneCurrentViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneCurrentViewController.h"
#import "createNormalCellModel.h"
#import "createTableViewHander.h"

#import "NSMutableAttributedString+ADDITIONS.h"
#import "CheckMedicalStationViewController.h"
#import "ApplyLocationViewController.h"
#import "TestMapTableViewCell.h"
#import "ManuallyLocateViewController2.h"
#import "ExaminationAppointmentTableViewCell.h"
#import "CreateViewByDataAvtive.h"

#import "URLConnectionHelper.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.m"
#import "CustomAlertView.h"
#import "ExaminationBookingViewController.h"
#import "ExerciseViewController.h"
#import "QuitAlertView.h"
#import "DoDriveExerciseViewController.h"

@interface SubjectOneCurrentViewController ()<UITableViewDelegate,UITableViewDataSource,QuitAlertViewBtnClickedDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong)FirstLocationModel *locationModela;

@property (nonatomic, strong)ProgressDataModel *currentModel;
@end

@implementation SubjectOneCurrentViewController{
    int _n;
    NSMutableDictionary *_dic;
    CLLocationCoordinate2D _p;
}
- (IBAction)click:(id)sender {
    NSLog(@"点击按钮 当前的n值：%d",_n);
    [self getDataAvite];
    return;
    NSArray *arr1 = @[@"0",@"0",@"1",@"1",@"2",@"2",@"2",@"2",@"2",@"3",@"3",@"3",@"3",@"3",@"3",@"4",@"4",@"4",@"4"];
    NSArray *arr2 = @[@"0",@"1",@"0",@"1",@"0",@"1",@"2",@"3",@"4",@"0",@"1",@"2",@"3",@"4",@"5",@"0",@"1",@"2",@"3"];
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:arr1[_n] andSubProgress:arr2[_n] andBlock:^(NSMutableArray *add) {
        _currentModel.periodNum = arr1[_n];
        _currentModel.status = arr2[_n];
        _data = add;
        createNormalCellModel *model = add[0];
        _progressImageView.image = [UIImage imageNamed:model.imageViewStr];
        [_tableView reloadData];
    }];
    _n+=1;
    if (_n == arr2.count) {
        _n = 0;
    }
    return;
    switch (_n) {
        case 1:
            [self getData];
            break;
        case 2:
            [self getDataTwo];
            break;
        case 3:
            [self getDataThree];
            break;
        case 4:
             [self getDataForth];
            break;
        case 5:
         [self getDataFifth];
            break;
        case 6:
             [self getDataSix];
            break;
        case 7:
            [self getDataSeven];
            break;
        case 8:
            [self getDataEight];
            break;
            
        default:
            break;
    }
   
    
    if (_n == 5) {
        _n =1;
    }
    _n+=1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [self getDataAvite];
}

- (void)setRefreshAvtive:(NSString *)refreshAvtive{
    _refreshAvtive = refreshAvtive;
    [self getDataAvite];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _n = 1;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    _dic = [[NSMutableDictionary alloc] init];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _data = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.scrollEnabled = NO;
    self.view.backgroundColor = EEEEEE;
//    [self getData];
   
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count-1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    createNormalCellModel *modle = _data[indexPath.row+1];
    return modle.he;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString *index = @"";
    _tableView.scrollEnabled = YES;
    createNormalCellModel *model = _data[indexPath.row+1];
    if (model.style == createNormalCellStyleUserDdfinedTen) {
        _tableView.scrollEnabled = NO;
        cell = [_dic objectForKey:@"map"];
        if (!cell) {
            cell = [TestMapTableViewCell cellWithTableToDequeueReusable:tableView identifier:@"TestMapTableViewCell" nibName:@"TestMapTableViewCell"];
            [_dic setObject:cell forKey:@"map"];
        }
        ((TestMapTableViewCell *)cell).pt = _p;
        ((TestMapTableViewCell *)cell).data = _locationData;
        ((TestMapTableViewCell *)cell).subVC = self;        
        [((TestMapTableViewCell *)cell) blcokActiveWithBlock:^(UIButton *btn, FirstLocationModel *model) {
            if (btn.tag == 1001) {
                ManuallyLocateViewController2 *v = [[ManuallyLocateViewController2 alloc] init];
                v.current = @"1";
                [self presentViewController:v animated:YES completion:^{
                    
                }];
                [v manuallBlokcWithBlock:^(NSArray *data, CLLocationCoordinate2D p) {
                    _p = p;
                    _locationData = data;
                    [_tableView reloadData];
                }];
            }else if (btn.tag == 1002){
                [self showNavigationWithModel:model];
            }else if (btn.tag == 1003){
                [self choosedCocoaActiveWithModel:model];
//                [self getDataEleven];
            }else{
                
            }
        }];
       
    }else if (model.style == createNormalCellStyleUserDdfinedAppointment){
        cell = [_dic objectForKey:@"appointment"];
        if (!cell) {
            cell = [ExaminationAppointmentTableViewCell cellWithTableToDequeueReusable:tableView identifier:@"ExaminationAppointmentTableViewCell" nibName:@"ExaminationAppointmentTableViewCell"];
            [_dic setObject:cell forKey:@"appointment"];
        }
        [((ExaminationAppointmentTableViewCell *)cell) ExaminationAppointmentWithBlock:^(UIButton *btn) {
            if (btn.tag == 1001) {
                //注意事项
            }else if (btn.tag == 1002){
                //考试导航
            }else{
                //联系交管
            }
        }];
        
    }else{
      cell  = [createTableViewHander createTableViewWithModel:_data[indexPath.row+1]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@---%@---%@",_currentModel.periodNum,_currentModel.status,@(indexPath.row));
    //报名
    if ([_currentModel.periodNum isEqualToString:@"0"]) {
        if ([_currentModel.cwStatus isEqualToString:@"0"]) {
            if (indexPath.row == 3-1) {
                CheckMedicalStationViewController *v = [[CheckMedicalStationViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            
            if (indexPath.row == 14-1) {
                ApplyLocationViewController *v = [[ApplyLocationViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
        }else if ([_currentModel.cwStatus isEqualToString:@"1"]){
            if (indexPath.row == 11-1) {
                ApplyLocationViewController *v = [[ApplyLocationViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            
        }else if ([_currentModel.status isEqualToString:@"2"]){
            
        }else if ([_currentModel.status isEqualToString:@"3"]){
            
        }else{
            
        }
        //入籍
    }else if ([_currentModel.periodNum isEqualToString:@"1"]){
        if ([_currentModel.cwStatus isEqualToString:@"0"] || [_currentModel.govCheckStatus isEqualToString:@"0"]) {
            if (indexPath.row == 3-1) {
                //入籍资格审核
                QuitAlertView *_quitrView = [QuitAlertView createShowView];
                _quitrView.delegate = self;
                _quitrView.frame = self.view.bounds;
                
                [_quitrView presentAddView:self.view withType:QuitBoxViewTypeCancelOnly];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _quitrView.describeStr = @"您的驾驶员报考资料将上传到122系统进行审核，审核通过后，您可预约考试。";
                });
               
            }
            if (indexPath.row == 4-1) {
                //考试资格
                QuitAlertView *_quitrView = [QuitAlertView createShowView];
                _quitrView.delegate = self;
                _quitrView.frame = self.view.bounds;
                
                [_quitrView presentAddView:self.view withType:QuitBoxViewTypeCancelOnly];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _quitrView.describeStr = @"西培学堂是重庆交管部门指定的科目一学习平台。";
                });
            }
            if (indexPath.row == 5-1) {
                //描述
                QuitAlertView *_quitrView = [QuitAlertView createShowView];
                _quitrView.delegate = self;
                _quitrView.frame = self.view.bounds;
                
                [_quitrView presentAddView:self.view withType:QuitBoxViewTypeCancelOnly];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _quitrView.describeStr = @"您的入籍资料将上传到成为系统进行审核，审核通过后，您会收到西培学堂的短信，您即可开始预约科目的学习。";
                });
                
            }
            if (indexPath.row == 6-1) {
                //下载西培学堂
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:nil withObject:@"3"];
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E8%A5%BF%E5%9F%B9%E5%AD%A6%E5%A0%82/id1189867693?mt=8"]];
            }
            
        }else if ([_currentModel.cwStatus isEqualToString:@"1"]){
            if (indexPath.row == 3-1) {
                //拨打电话
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:nil withObject:@"4"];
                }
            }
            if (indexPath.row == 4-1) {
                //下载西培学堂
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:nil withObject:@"3"];
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E8%A5%BF%E5%9F%B9%E5%AD%A6%E5%A0%82/id1189867693?mt=8"]];
            }
        }else if ([_currentModel.status isEqualToString:@"2"]){
            
        }else if ([_currentModel.status isEqualToString:@"3"]){
            
        }else{
            
        }
        //科目一
    }else if ([_currentModel.periodNum isEqualToString:@"2"]){
        if ([_currentModel.studyStatus isEqualToString:@"0"]) {
            if (indexPath.row == 2-1) {
                //立即练题
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
        }else if ([_currentModel.studyStatus isEqualToString:@"1"]){
            if (indexPath.row == 2-1) {
                //立即练题
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            if (indexPath.row == 5-1) {
                //立即约考
                ExaminationBookingViewController *v = [[ExaminationBookingViewController alloc] init];
                v.model = _currentModel;
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
        }else if ([_currentModel.studyStatus isEqualToString:@"2"]){
            
        }else if ([_currentModel.studyStatus isEqualToString:@"3"]){
            if (indexPath.row == 2-1) {
                //立即练题
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            if (indexPath.row == 6-1) {
                //预约考试
                ExaminationBookingViewController *v = [[ExaminationBookingViewController alloc] init];
                v.model = _currentModel;
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            if (indexPath.row == 3) {
                [self getLearnChangedActive];
            }
        }else if ([_currentModel.studyStatus isEqualToString:@"4"]){
            if (indexPath.row == 4-1) {
                //开始科目二的学习
                [self getLearnChangedActive];
            }
            
        }else{
            
        }
        //科目二
    }else if ([_currentModel.periodNum isEqualToString:@"3"]){
        if ([_currentModel.studyStatus isEqualToString:@"0"]) {
            
        }else if ([_currentModel.studyStatus isEqualToString:@"1"]){
            if (indexPath.row == 3-1) {
                //考试场地导航
            }
            
            if (indexPath.row == 5-1) {
                //联系电话
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:nil withObject:@"4"];
                }
            }
            if (indexPath.row == 2-1) {
                //科目二的视频学习
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            
            if (indexPath.row == 4-1) {
                //查看打卡累积
                DoDriveExerciseViewController *v = [[DoDriveExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"2"];
                }
            }
            if (indexPath.row == 5) {
                //立即约考
                QuitAlertView *_quitrView = [QuitAlertView createShowView];
                _quitrView.delegate = self;
                _quitrView.frame = self.view.bounds;
                
                [_quitrView presentAddView:self.view withType:QuitBoxViewTypeCancelAndSure];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _quitrView.describeStr = @"请与您的教练通报并获取同意，再确定是否预约科目二考试。";
                    _quitrView.letfTitle = @"再想想";
                    _quitrView.rightTitle = @"立即约考";
                });
                
                
            }
        }else if ([_currentModel.studyStatus isEqualToString:@"2"]){
            if (indexPath.row == 2-1) {
                //科目二的视频学习
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            
            if (indexPath.row == 4-1) {
                //查看打卡累积
                DoDriveExerciseViewController *v = [[DoDriveExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"2"];
                }
            }
            if (indexPath.row == 6-1) {
                //立即约考
               
                QuitAlertView *_quitrView = [QuitAlertView createShowView];
                _quitrView.delegate = self;
                _quitrView.frame = self.view.bounds;
                
                [_quitrView presentAddView:self.view withType:QuitBoxViewTypeCancelAndSure];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _quitrView.describeStr = @"请与您的教练通报并获取同意，再确定是否预约科目二考试。";
                    _quitrView.letfTitle = @"再想想";
                    _quitrView.rightTitle = @"立即约考";
                });
                
            }
            
        }else if ([_currentModel.studyStatus isEqualToString:@"3"]){
            
        }else if ([_currentModel.studyStatus isEqualToString:@"4"]){
            if (indexPath.row == 2-1) {
                //观看视频
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            if (indexPath.row == 6-1) {
                //继续练车
            }
        }else if ([_currentModel.studyStatus isEqualToString:@"5"]){
            if (indexPath.row == 4-1) {
                //开始科目三的学习
                [self getDataAvite];
            }
        }else{
            
        }
        //科目三
    }else if ([_currentModel.periodNum isEqualToString:@"4"]){
        if ([_currentModel.studyStatus isEqualToString:@"0"]) {
            if (indexPath.row == 2-1) {
                //科目三的学习
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            
            if (indexPath.row == 4-1) {
                //查看打卡记录
            }
            if (indexPath.row == 6-1) {
                //立即约考
                
            }
            
        }else if ([_currentModel.studyStatus isEqualToString:@"1"]){
            
        }else if ([_currentModel.studyStatus isEqualToString:@"2"]){
            if (indexPath.row == 2-1) {
                //科目三的学习
                ExerciseViewController *v = [[ExerciseViewController alloc] init];
                if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                    [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
                }
            }
            
           
            if (indexPath.row == 6-1) {
                //再次练车
            }
        }else if ([_currentModel.studyStatus isEqualToString:@"3"]){
            if (indexPath.row == 4-1) {
                //进入科目四
            }
        }else{
            
        }
        //科目四
    }else if ([_currentModel.periodNum isEqualToString:@"5"]){
        if ([_currentModel.studyStatus isEqualToString:@"0"]) {
            
        }else if ([_currentModel.studyStatus isEqualToString:@"1"]){
            
        }else if ([_currentModel.studyStatus isEqualToString:@"2"]){
            
        }else if ([_currentModel.studyStatus isEqualToString:@"3"]){
            
        }else{
            
        }
    }else{
        
    }
}

- (void)getDataTwo{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:@"1" andSubProgress:@"0" andBlock:^(NSMutableArray *add) {
        _data = add;
        [_tableView reloadData];
    }];
    
    
    
}

- (void)getData{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:@"0" andSubProgress:@"0" andBlock:^(NSMutableArray *add) {
        _data = add;
        [_tableView reloadData];
    }];
    

    
}

- (void)getDataThree{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:@"2" andSubProgress:@"0" andBlock:^(NSMutableArray *add) {
        _data = add;
        [_tableView reloadData];
    }];
}

- (void)getDataForth{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:@"3" andSubProgress:@"0" andBlock:^(NSMutableArray *add) {
        _data = add;
        [_tableView reloadData];
    }];
}

- (void)getDataFifth{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:@"4" andSubProgress:@"0" andBlock:^(NSMutableArray *add) {
        _data = add;
        [_tableView reloadData];
    }];
}

- (void)getDataSix{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:nil andProgress:@"1" andSubProgress:@"0" andBlock:^(NSMutableArray *add) {
        _data = add;
        [_tableView reloadData];
    }];
}

- (void)getDataSeven{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    
    [_tableView reloadData];
}

- (void)getDataEight{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    
    [_tableView reloadData];
}

- (void)getDataNine{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@60,@20,@100,@150,@200,@40];
    NSArray *title = @[@"",@"",@"",@"",@"",@"预约考试",@""];
    
    for (int i = 0; i<title.count; i++) {
        
        createNormalCellModel *model = [[createNormalCellModel alloc] init];
        model.imageViewStr = arra[i];
        model.he = [heights[i] floatValue];
        model.title = title[i];
        switch (i) {
            case 0:{
                model.color = BLUE_BACKGROUND_COLOR;
                model.style = createNormalCellStyleOnlyImageCenter;
                model.contenModel = UIViewContentModeScaleAspectFit;
            }
                break;
            
            case 1:{
                model.style = createNormalCellStyleUserDdfinedEight;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"立即练题  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
               
            }
                break;
                
            case 2:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 3:{
                model.style = createNormalCellStyleUserDdfinedThere;
                model.color = BLUE_BACKGROUND_COLOR;
                model.detailTitle = @"很遗憾，您未能通过考试,请继续加油!";
                model.hasFootViewLine = YES;
            }
                break;
            case 4:{
                model.style = createNormalCellStyleBang;
                model.grade = 89.0;
                
                
            }
                break;
            case 5:{
                model.style = createNormalCellStyleUserDdfinedTwo;
                model.detailTitle = @"根据交管部门的规定，您在首次考试10个工作日之后，即可再次预约考试。";
                model.titleFont = 14;
            }
                break;
            case 6:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
                
                
                
            default:
                break;
        }
        
        [_data addObject:model];
    }
    [_tableView reloadData];
}

- (void)getDataTen{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = NO;
    NSArray *arra = @[@"banner_two",@""];
    NSArray *heights = @[@100,@(CURRENT_BOUNDS.height-164-44)];
    NSArray *title = @[@"",@""];
    
    for (int i = 0; i<title.count; i++) {
        
        createNormalCellModel *model = [[createNormalCellModel alloc] init];
        model.imageViewStr = arra[i];
        model.he = [heights[i] floatValue];
        model.title = title[i];
        switch (i) {
            case 0:{
                model.color = BLUE_BACKGROUND_COLOR;
                model.style = createNormalCellStyleOnlyImageCenter;
                model.contenModel = UIViewContentModeScaleAspectFit;
            }
                break;
                
            case 1:{
                model.style = createNormalCellStyleUserDdfinedTen;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"立即练题  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
                
            }
                break;
            default:
                break;
        }
        
        [_data addObject:model];
    }
    [_tableView reloadData];
}

- (void)getDataEleven{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    NSArray *arra = @[@"banner_three",@"",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@30,@60,@60,@10,@60,@100];
    NSArray *title = @[@"",@"",@"场地名称:",@"详细地址:",@"场地名称:",@"系统正在为你匹配教练，匹配成功后，教练会与您联系，如果长时间教练没有和您联系，请拨打：40000000客服热线",@"教练已联系"];
    
    for (int i = 0; i<title.count; i++) {
        
        createNormalCellModel *model = [[createNormalCellModel alloc] init];
        model.imageViewStr = arra[i];
        model.he = [heights[i] floatValue];
        model.title = title[i];
        switch (i) {
            case 0:{
                model.color = BLUE_BACKGROUND_COLOR;
                model.style = createNormalCellStyleOnlyImageCenter;
                model.contenModel = UIViewContentModeScaleAspectFit;
            }
                break;
                
            case 1:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 2:{
                model.style = createNormalCellStyleNormal1;
                model.color = TEXT_COLOR;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"产业园教练场地" andImage:[UIImage imageNamed:@""] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
               
                model.titleFont = 14;
            }
                break;
            case 3:{
                model.style = createNormalCellStyleNormal1;
                model.color = TEXT_COLOR;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"两江新区互联网产业园 " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
              
            }
                break;
            case 4:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = [UIColor whiteColor];
            }
                break;
            case 5:{
                model.style = createNormalCellStyleUserDdfinedWhite;
                model.titleFont = 14*TYPERATION;
                NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@""] andOtherStr:@"" andBound:CGRectMake(0,-3,14,14)];
                [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(str.length-12,8)];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:6];
                [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
                model.AttributedStr = str;
                model.color = ADB1B9;
            }
                break;
            case 6:{
                model.style = createNormalCellStyleUserDdfinedTwo;
                model.hasDefalut = YES;
            }
                break;
                
            default:
                break;
        }
        
        [_data addObject:model];
    }
    [_tableView reloadData];
}

- (void)getDataTwelve{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    _tableView.scrollEnabled = YES;
    NSArray *arra = @[@"banner_three",@"",@""];
    NSArray *heights = @[@100,@0,@(300+44*5)];
    NSArray *title = @[@"",@"",@"场地名称:"];
    
    for (int i = 0; i<title.count; i++) {
        
        createNormalCellModel *model = [[createNormalCellModel alloc] init];
        model.imageViewStr = arra[i];
        model.he = [heights[i] floatValue];
        model.title = title[i];
        switch (i) {
            case 0:{
                model.color = BLUE_BACKGROUND_COLOR;
                model.style = createNormalCellStyleOnlyImageCenter;
                model.contenModel = UIViewContentModeScaleAspectFit;
            }
                break;
                
            case 1:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 2:{
                model.style = createNormalCellStyleUserDdfinedAppointment;
                model.color = TEXT_COLOR;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"产业园教练场地" andImage:[UIImage imageNamed:@""] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                
                model.titleFont = 14;
            }
                break;
            
                
            default:
                break;
        }
        
        [_data addObject:model];
    }
    [_tableView reloadData];
}

- (void)showNavigationWithModel:(FirstLocationModel *)model{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [model.latitude doubleValue];
    coordinate.longitude = [model.longitude doubleValue];
    _locationModela = model;
    //test
    NSArray *arr = [self getInstalledMapAppWithAddr:model.address withEndLocation:coordinate];
    [self showAlertViewWithData:arr andCoordinate:coordinate];
}

#pragma mark - 选择导航的功能

- (NSArray *)getInstalledMapAppWithAddr:(NSString *)addrString withEndLocation:(CLLocationCoordinate2D)endLocation

{
    
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    
    iosMapDic[@"title"] = @"苹果地图";
    
    [maps addObject:iosMapDic];
    
    NSString *appStr = NSLocalizedString(@"app_name", nil);
    
    //高德地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        
        gaodeMapDic[@"title"] = @"高德地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dname=%@&dev=0&t=2",appStr ,addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        gaodeMapDic[@"url"] = urlString;
        
        [maps addObject:gaodeMapDic];
        
    }
    
    //百度地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        
        baiduMapDic[@"title"] = @"百度地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=我的位置&destination=%@&mode=walking&src=%@",addrString ,appStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        baiduMapDic[@"url"] = urlString;
        
        [maps addObject:baiduMapDic];
        
    }
    
    //腾讯地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        
        qqMapDic[@"title"] = @"腾讯地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=walk&tocoord=%f,%f&to=%@&coord_type=1&policy=0",endLocation.latitude , endLocation.longitude ,addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        qqMapDic[@"url"] = urlString;
        
        [maps addObject:qqMapDic];
        
    }
    
    //谷歌地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        
        googleMapDic[@"title"] = @"谷歌地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%@&directionsmode=walking",addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        googleMapDic[@"url"] = urlString;
        
        [maps addObject:googleMapDic];
        
    }
    
    return maps;
    
}

-(void)showAlertViewWithData:(NSArray *)data andCoordinate:(CLLocationCoordinate2D)coordinate{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"地图" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = data[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:[dic objectForKey:@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([action.title isEqualToString:@"百度地图"]) {
                
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name=%@&destination=latlng:%@,%@|name=%@&mode=driving&coord_type=bd09ll",_currentLocation.latitude,_currentLocation.longitude,@"起点",self.locationModela.latitude, self.locationModela.longitude,self.locationModela.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
            }else if ([action.title isEqualToString:@"高德地图"]){
                
                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%lf&slon=%lf&sname=起点&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_currentLocation.latitude,_currentLocation.longitude,coordinate.latitude,coordinate.longitude,_locationModela.name]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
            }else if ([action.title isEqualToString:@"谷歌地图"]){
                //谷歌地图
                NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"好梦学车",@"",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else{
                //苹果自带地图
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
                
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                               MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            }
            NSLog(@"%@",action.title);
        }];
        
        [v addAction:action];
    }
    UIAlertAction *active1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active1];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

- (void)getDataAvite{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];
    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadGetDataWithUrl:[NSString stringWithFormat:@"http://101.37.161.13:7081/v1/student/basicInfo/%@",userId] andSuccessBlock:^(NSArray *data) {
        NSDictionary *dic = (NSDictionary *)data;
        ProgressDataModel *model = [[ProgressDataModel alloc] init];
        model.userId = [dic objectForKeyWithNoNsnull:@"userId"];
        model.idCard = [dic objectForKeyWithNoNsnull:@"idCard"];
        model.status = [dic objectForKeyWithNoNsnull:@"status"];
        model.belongPeriod = [dic objectForKeyWithNoNsnull:@"belongPeriod"];
        model.periodNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"periodNum"]];
        model.realName = [dic objectForKeyWithNoNsnull:@"realName"];
        model.nickName = [dic objectForKeyWithNoNsnull:@"nickName"];
        model.headPicture = [dic objectForKeyWithNoNsnull:@"headPicture"];
        model.phone = [dic objectForKeyWithNoNsnull:@"phone"];
        model.classTypeCode = [dic objectForKeyWithNoNsnull:@"classTypeCode"];
        model.classTypeName = [dic objectForKeyWithNoNsnull:@"classTypeName"];
        model.carTypeCode = [dic objectForKeyWithNoNsnull:@"carTypeCode"];
        model.carTypeName = [dic objectForKeyWithNoNsnull:@"carTypeName"];
        
        
        model.cwStatus = [dic objectForKeyWithNoNsnull:@"cwStatus"];
        model.cwSubjectOneValidTime = (long)[dic objectForKey:@"cwSubjectOneValidTime"];
        model.cwSubjectTwoValidTime = (long)[dic objectForKey:@"cwSubjectTwoValidTime"];
        model.cwSubjectThreeValidTime = (long)[dic objectForKey:@"cwSubjectThreeValidTime"];
        model.cwSubjectOneTrainTime = (long)[dic objectForKey:@"cwSubjectOneTrainTime"];
        model.cwSubjectTwoTrainTime = (long)[dic objectForKey:@"cwSubjectTwoTrainTime"];
        model.cwSubjectThreeTrainTime = (long)[dic objectForKey:@"cwSubjectThreeTrainTime"];
        model.govCheckStatus = [dic objectForKeyWithNoNsnull:@"govCheckStatus"];
        model.govFailReason = [dic objectForKeyWithNoNsnull:@"govFailReason"];
        
        model.subject = [dic objectForKeyWithNoNsnull:@"subject"];
        model.studyStatus = [dic objectForKeyWithNoNsnull:@"studyStatus"];
        model.studyStartTime = [dic objectForKeyWithNoNsnull:@"studyStartTime"];
        model.studyEndTime = [dic objectForKeyWithNoNsnull:@"studyEndTime"];
        model.examStatus = [dic objectForKeyWithNoNsnull:@"examStatus"];
        model.lastExamScore = [dic objectForKeyWithNoNsnull:@"lastExamScore"];
        model.examTimeLimit = [dic objectForKeyWithNoNsnull:@"examTimeLimit"];
        model.studyCount = [[dic objectForKey:@"studyCount"] intValue];
        NSLog(@"%@",model);
        _currentModel = model;
//        _currentModel.periodNum = @"3";
//        _currentModel.studyStatus = @"3";
        [[CreateViewByDataAvtive shareDefaulte] getViewDataWithModel:model andProgress:model.periodNum andSubProgress:model.studyStatus andBlock:^(NSMutableArray *add) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                createNormalCellModel *model = add[0];
                _progressImageView.image = [UIImage imageNamed:model.imageViewStr];
                _data = add;
                [_tableView reloadData];
            });
            
        }];
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

- (void)showAlertViewActiveWithDes:(NSString *)des{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:des preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

#pragma mark - QuitAlertViewBtnClickedDelegate
- (void)btnClickedWithBtn:(UIButton *)btn{
    if (btn.tag == 1001) {
        
    }else if (btn.tag == 1002){
        if ([_currentModel.periodNum isEqualToString:@"3"] && ([_currentModel.studyStatus isEqualToString:@"1"] || [_currentModel.studyStatus isEqualToString:@"2"])) {
            ExaminationBookingViewController *v = [[ExaminationBookingViewController alloc] init];
            v.model = _currentModel;
            if ([self.delegate respondsToSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:)]) {
                [self.delegate performSelector:@selector(SubjectOneCurrentViewControllerDelegateWithActiveVC:andTag:) withObject:v withObject:@"1"];
            }
        }
        
    }else if (btn.tag == 1003){
        
    }else{
        
    }
}

- (void)choosedCocoaActiveWithModel:(FirstLocationModel *)model{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];
    NSDictionary *dic =@{@"trainPlaceId":model.currentId,
                         @"stuId":userId
                         };
    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadPostTwoDataWithUrl:@"http://101.37.161.13:7081/v1/student/applicationCoach" andDic:dic andSuccessBlock:^(NSArray *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            [self getDataAvite];
        });
        
    } andFiledBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        
        });
    }];
}

//进入下一个学习阶段的方法
- (void)getLearnChangedActive{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];

    [CustomAlertView showAlertViewWithVC:self];
    [[URLConnectionHelper shareDefaulte] loadGetDataWithUrl:[NSString stringWithFormat:@"http://101.37.161.13:7081/v1/student/enterNextStudyProgress/%@",userId] andSuccessBlock:^(NSArray *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            [self getDataAvite];
        });
    } andFiledBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            
        });
    }];
}

@end
