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

@interface SubjectOneCurrentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation SubjectOneCurrentViewController{
    int _n;
}
- (IBAction)click:(id)sender {
    NSLog(@"点击按钮 当前的n值：%d",_n);
   
    
    
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
   
    _n+=1;
    if (_n == 9) {
        _n =1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _n = 2;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _data = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    self.view.backgroundColor = EEEEEE;
    [self getDataTen];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    createNormalCellModel *modle = _data[indexPath.row];
    return modle.he;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString *index = @"";
    createNormalCellModel *model = _data[indexPath.row];
    if (model.style == createNormalCellStyleUserDdfinedTen) {
        cell = [TestMapTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"TestMapTableViewCell"];
    }else{
      cell  = [createTableViewHander createTableViewWithModel:_data[indexPath.row]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_n == 2) {
        if (indexPath.row == _data.count-2) {
            ApplyLocationViewController *v = [[ApplyLocationViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
    }
    
    if (_n == 3) {
        if (indexPath.row == 3) {
            CheckMedicalStationViewController *v = [[CheckMedicalStationViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
        if (indexPath.row == _data.count -2) {
            ApplyLocationViewController *v = [[ApplyLocationViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
    }
    if (_n == 4) {
        if (indexPath.row == _data.count-2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E8%A5%BF%E5%9F%B9%E5%AD%A6%E5%A0%82/id1189867693?mt=8"]];
        }
    }
    if (_n == 5) {
        if (indexPath.row == _data.count-2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E8%A5%BF%E5%9F%B9%E5%AD%A6%E5%A0%82/id1189867693?mt=8"]];
        }
    }
}

- (void)getDataTwo{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_one",@"",@"content_img_watermark",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@20,@100,@100,@20,@100,@40,@20,@40,@20,@20,@40,@20,@20,@100,@40];
    NSArray *title = @[@"",@"当前进度:科目一学时",@"恭喜你缴费成功！",@"查询体检站",@"",@"体检完成后",@"",@"",@"",@"",@"",@"",@"",@"",@"查询报名点",@""];
    
    for (int i = 0; i<title.count; i++) {
        
        createNormalCellModel *model = [[createNormalCellModel alloc] init];
        model.imageViewStr = arra[i];
        model.he = [heights[i] floatValue];
        model.title = title[i];
        switch (i) {
            case 0:{
                model.color = BLUE_BACKGROUND_COLOR;
                model.style = createNormalCellStyleOnlyImageCenter;
            }
                break;
            case 1:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 2:{
                model.style = createNormalCellStyleUserDdfinedThere;
                model.detailTitle = @"请前往就近体检站体检";
                model.hasFootViewLine = YES;
            }
                break;
            case 3:{
                model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
            case 4:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 5:{
                model.style = createNormalCellStyleUserDdfinedThere;
                model.detailTitle = @"请携带以下资料前往好梦报名点报名";
            }
                break;
            case 6:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"本地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = TEXT_COLOR;
                model.titleFont = 14;
            }
                
                break;
            case 7:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 8:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"增加请携带：" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 9:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 10:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 11:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"外地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 12:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 13:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"暂住证明或居住证" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 14:{
                model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
            case 15:{
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

- (void)getData{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_one",@"",@"content_img_watermark",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@20,@100,@40,@20,@40,@20,@20,@40,@20,@20,@100,@40];
    NSArray *title = @[@"",@"当前进度:科目一学时",@"恭喜你缴费成功！",@"",@"",@"",@"",@"",@"",@"",@"",@"查询报名点",@""];
   
    for (int i = 0; i<title.count; i++) {
        
        createNormalCellModel *model = [[createNormalCellModel alloc] init];
        model.imageViewStr = arra[i];
        model.he = [heights[i] floatValue];
        model.title = title[i];
        switch (i) {
            case 0:{
                model.color = BLUE_BACKGROUND_COLOR;
                model.style = createNormalCellStyleOnlyImageCenter;
            }
                break;
            case 1:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 2:{
                model.style = createNormalCellStyleUserDdfinedThere;
                model.detailTitle = @"请携带以下资料前往好梦报名点报名";
            }
                break;
            case 3:{
              model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"本地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 4:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 5:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"增加请携带：" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 6:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 7:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 8:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"外地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 9:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 10:{
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"暂住证明或居住证" andBound:CGRectMake(0,-3,14,14)];
                model.style = createNormalCellStyleUserDdfinedForth;
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
            case 11:{
                 model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
            case 12:{
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

- (void)getDataThree{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_one",@"",@"img_adopt",@"",@"",@""];
    NSArray *heights = @[@100,@20,@150,@100,@100,@40];
    NSArray *title = @[@"",@"",@"",@"尊敬的好梦学院，您的资料已经审核通过，您可以在完成西培学堂的学习后预约考试啦。有任何问题欢迎随时联系我们呃客服。联系电话：40000000",@"下载西培学堂APP",@""];
    
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
                model.style = createNormalCellStyleUserDdfinedThere;
                model.detailTitle = @"";
                model.contenModel = UIViewContentModeCenter;
                model.hasFootViewLine = YES;
            }
                break;
            case 3:{
                model.style = createNormalCellStyleUserDdfinedFifth;
                model.titleFont = 14*TYPERATION;
                NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"" andBound:CGRectMake(0,-3,14,14)];
                [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(str.length-9,8)];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:6];
                [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
                model.AttributedStr = str;
                model.color = UNMAIN_TEXT_COLOR;
               
            }
                break;
            case 4:{
                 model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
            case 5:{
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

- (void)getDataForth{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_one",@"",@"img_waitfor",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@20,@150,@40,@40,@100,@100,@40];
    NSArray *title = @[@"",@"",@"",@"入籍资格审核：审核中    ",@"考试资格审核：审核中    ",@"尊敬的好梦学员，您的报名资料已经提交到交管部门审核，请耐心等待。您可以先下载西培学堂APP提前进行科目一练习",@"下载西培学堂APP",@""];
    
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
                model.style = createNormalCellStyleUserDdfinedThere;
                model.detailTitle = @"";
                model.contenModel = UIViewContentModeCenter;
                model.hasFootViewLine = YES;
            }
                break;
            case 3:{
                model.style = createNormalCellStyleUserDdfinedFifth;
                model.titleFont = 20*TYPERATION;
                NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"" andBound:CGRectMake(0,-1,18,18)];
                [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(7,3)];
                model.AttributedStr = str;
                model.color = TEXT_COLOR;
            }
                break;
            case 4:{
                model.style = createNormalCellStyleUserDdfinedFifth;
                model.titleFont = 20*TYPERATION;
                NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"" andBound:CGRectMake(0,-1,18,18)];
                [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(7,3)];
                model.AttributedStr = str;
                model.color = TEXT_COLOR;
            }
                break;
            
            case 5:{
                model.style = createNormalCellStyleUserDdfinedFifth;
                model.titleFont = 14*TYPERATION;
                NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"" andBound:CGRectMake(0,-3,14,14)];
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:6];
                [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
                model.AttributedStr = str;
                model.color = UNMAIN_TEXT_COLOR;
                
            }
                break;
            case 6:{
                model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
            case 7:{
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

- (void)getDataFifth{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@20,@60,@20,@150,@100];
    NSArray *title = @[@"",@"",@"我的错题：32",@"",@"",@"在西培学堂完成1320分钟学习后即可约考"];
    
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
                model.style = createNormalCellStyleUserDdfinedSix;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"立即练题  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
                model.hasDefalut = YES;
            }
                break;
            
            case 3:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 4:{
                model.style = createNormalCellStyleUserDdfinedOne;
                model.titleFont = 20*TYPERATION;
                
                model.color = TEXT_COLOR;
                model.title = @"1320min";
                model.detailTitle = @"280min";
            }
                break;
                
            case 5:{
                model.style = createNormalCellStyleUserDdfinedSeven;
                model.titleFont = 18*TYPERATION;
                model.color = UNMAIN_TEXT_COLOR;
                model.bgColor = [UIColor whiteColor];
                
            }
                break;
            
                
                
                
            default:
                break;
        }
        
        [_data addObject:model];
    }
    [_tableView reloadData];
}

- (void)getDataSix{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_three",@"",@"",@"",@"",@"img_waitfor",@""];
    NSArray *heights = @[@100,@20,@60,@20,@50,@250,@100];
    NSArray *title = @[@"",@"",@"我的错题：32",@"",@"",@"在西培学堂完成1320分钟学习后即可约考",@"立即约考"];
    
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
                model.style = createNormalCellStyleUserDdfinedSix;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"科目二学习视频  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
            }
                break;
                
            case 3:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 4:{
                model.style = createNormalCellStyleValue1;
                model.titleFont = 20*TYPERATION;
                
                model.color = TEXT_COLOR;
                model.title = @"科目二练车打卡累积";
                model.detailTitle = @"100次";
            }
                break;
                
            case 5:{
                model.style = createNormalCellStyleOnlyImageCenter;
//                model.contenModel = UIViewContentModeCenter;
                model.hasFootViewLine = YES;
                
                
            }
                break;
            case 6:{
                model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
                
            default:
                break;
        }
        
        [_data addObject:model];
    }
    [_tableView reloadData];
}

- (void)getDataSeven{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@20,@60,@20,@100,@150,@200,@40];
    NSArray *title = @[@"",@"",@"我的错题：32",@"",@"",@"",@"预约考试",@""];
    
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
                model.style = createNormalCellStyleUserDdfinedSix;
                model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"立即练题  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                model.color = UNMAIN_TEXT_COLOR;
                model.titleFont = 14;
                model.hasDefalut = YES;
            }
                break;
                
            case 3:{
                model.style = createNormalCellStyleOnlyImageCenter;
                model.color = EEEEEE;
            }
                break;
            case 4:{
                model.style = createNormalCellStyleUserDdfinedThere;
                model.color = BLUE_BACKGROUND_COLOR;
                model.detailTitle = @"很遗憾，您未能通过考试,请继续加油!";
                model.hasFootViewLine = YES;
            }
                break;
            case 5:{
                model.style = createNormalCellStyleBang;
                model.grade = 89.0;
                
                
            }
                break;
            case 6:{
                model.style = createNormalCellStyleUserDdfinedTwo;
                model.detailTitle = @"根据交管部门的规定，您在首次考试10个工作日之后，即可再次预约考试。";
                model.titleFont = 14;
            }
                break;
            case 7:{
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

- (void)getDataEight{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@20,@100,@150,@100,@40];
    NSArray *title = @[@"",@"",@"",@"",@"开始科目二的学习",@""];
    
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
                model.style = createNormalCellStyleUserDdfinedThere;
                model.color = BLUE_BACKGROUND_COLOR;
                model.detailTitle = @"恭喜您通过科目一考试";
                model.hasFootViewLine = YES;
            }
                break;
            case 3:{
                model.style = createNormalCellStyleBang;
                model.grade = 100.0;
                
                
            }
                break;
            case 4:{
                model.style = createNormalCellStyleUserDdfinedTwo;
            }
                break;
            case 5:{
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

- (void)getDataNine{
    if (_data.count > 0) {
        [_data removeAllObjects];
    }
    NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@"",@""];
    NSArray *heights = @[@100,@60,@20,@100,@150,@200,@40];
    NSArray *title = @[@"",@"我的错题：32",@"",@"",@"",@"预约考试",@""];
    
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
                model.hasDefalut = YES;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
