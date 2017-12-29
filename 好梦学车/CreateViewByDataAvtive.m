//
//  CreateViewByDataAvtive.m
//  好梦学车
//
//  Created by haomeng on 2017/12/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "CreateViewByDataAvtive.h"
#import "createNormalCellModel.h"
#import "NSMutableAttributedString+ADDITIONS.h"

@implementation CreateViewByDataAvtive

static CreateViewByDataAvtive *_shareDefaulte;
+ (CreateViewByDataAvtive *)shareDefaulte{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareDefaulte = [[super alloc] init];
    });
    
    return _shareDefaulte;
}

- (void)getViewDataWithModel:(ProgressDataModel *)modela andProgress:(NSString *)progrss andSubProgress:(NSString *)subProgress andBlock:(void (^)(NSMutableArray *))block{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    _block = block;
    
    if ([progrss isEqualToString:@"0"]) {
        
        if ([modela.status isEqualToString:@"0"]) {
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
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@""] andOtherStr:@"① 本地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        
                        break;
                    case 7:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证   " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 8:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@""] andOtherStr:@"② 增驾请携带：" andBound:CGRectMake(0,-3,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 9:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 10:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 11:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@""] andOtherStr:@"③ 外地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 12:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 13:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"暂住证明或居住证" andBound:CGRectMake(0,-1,14,14)];
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
                
                [data addObject:model];
            }
        }else if ([modela.status isEqualToString:@"1"]){
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
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@""] andOtherStr:@"① 本地身份证请携带：" andBound:CGRectMake(0,-3,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 4:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 5:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@""] andOtherStr:@"② 增加请携带：" andBound:CGRectMake(0,-3,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 6:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 7:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 8:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@""] andOtherStr:@"③ 外地身份证请携带：" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 9:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithImage:[UIImage imageNamed:@"note_star"] andWithStr:@"身份证  " andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"体检表" andBound:CGRectMake(0,-1,14,14)];
                        model.style = createNormalCellStyleUserDdfinedForth;
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                    }
                        break;
                    case 10:{
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"" andImage:[UIImage imageNamed:@"note_star"] andOtherStr:@"暂住证明或居住证" andBound:CGRectMake(0,-1,14,14)];
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
                
                [data addObject:model];
            }
        }else if ([subProgress isEqualToString:@"2"]){
            
        }else if ([subProgress isEqualToString:@"3"]){
            
        }else {
            
        }
        
    }else if ([progrss isEqualToString:@"1"]){
        if ([modela.cwStatus isEqualToString:@"0"] || [modela.govCheckStatus isEqualToString:@"0"]) {
            NSArray *arra = @[@"banner_one",@"",@"img_waitfor",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@150,@40,@40,@100,@100,@40];
            NSArray *title;
            NSString *cw = @"入籍资格审核：审核中    ";
            NSString *gov = @"考试资格审核：审核中    ";
            if ([modela.cwStatus isEqualToString:@"0"]) {
               
            }else{
                cw = @"入籍资格审核：审核通过";
            }
            if ([modela.govCheckStatus isEqualToString:@"0"]) {
                gov = @"考试资格审核：审核中    ";
            }else if ([modela.govCheckStatus isEqualToString:@"1"]){
                gov = @"考试资格审核：审核通过";
            }
            else{
                gov = @"考试资格审核：审核失败";
            }
            title = @[@"",@"",@"",cw,gov,@"尊敬的好梦学员，您的报名资料已经提交到交管部门审核，请耐心等待。您可以先下载西培学堂APP提前进行科目一练习。 ",@"下载西培学堂APP",@""];
            
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
                        [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(7,4)];
                        model.AttributedStr = str;
                        model.color = TEXT_COLOR;
                    }
                        break;
                    case 4:{
                        model.style = createNormalCellStyleUserDdfinedFifth;
                        model.titleFont = 20*TYPERATION;
                        NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@"btn_why"] andOtherStr:@"" andBound:CGRectMake(0,-1,18,18)];
                        [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(7,4)];
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
                
                [data addObject:model];
            }
        }else if ([modela.cwStatus isEqualToString:@"1"] && [modela.govCheckStatus  isEqualToString:@"1"]){
            NSArray *arra = @[@"banner_one",@"",@"img_adopt",@"",@"",@""];
            NSArray *heights = @[@100,@20,@150,@100,@100,@40];
            NSArray *title = @[@"",@"",@"",@"尊敬的好梦学院，您的资料已经审核通过，您可以在完成西培学堂的学习后预约考试啦。有任何问题欢迎随时联系我们呃客服。联系电话：40000000  ",@"下载西培学堂APP",@""];
            
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
                        [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(str.length-11,8)];
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
                
                [data addObject:model];
            }
        }else{
            
        }
    }else if ([progrss isEqualToString:@"2"]){
        
        //练题完成
        if ([subProgress isEqualToString:@"1"] || [subProgress isEqualToString:@"0"]) {
            NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@60,@20,@150,@100];
            NSArray *title = @[@"",@"",@"",@"",@"",@"在西培学堂完成1320分钟学习后即可约考"];
            
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
                        model.detailTitle = [NSString stringWithFormat:@"%ldmin",(long)modela.cwSubjectOneValidTime];
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
                
                [data addObject:model];
            }
            
            
        }else if ([subProgress isEqualToString:@"2"]){
            NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@60,@20,@150,@100];
            NSArray *title = @[@"",@"",@"",@"",@"",@"立即约考"];
            
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
                        model.detailTitle = [NSString stringWithFormat:@"%ldmin",(long)modela.cwSubjectOneValidTime];
                    }
                        break;
                        
                    case 5:{
                        model.style = createNormalCellStyleUserDdfinedSeven;
                        model.titleFont = 18*TYPERATION;
                        model.color = [UIColor whiteColor];
                        model.bgColor = BLUE_BACKGROUND_COLOR;
                        
                    }
                        break;
                        
                        
                        
                        
                    default:
                        break;
                }
                
                [data addObject:model];
            }
            //科目一预约考试
        }else if ([subProgress isEqualToString:@"6"]){
            NSArray *arra = @[@"banner_two",@"",@""];
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
                
                [data addObject:model];
            }
            
           //科目一未通过考试
        }else if ([subProgress isEqualToString:@"5"]){
            NSArray *arra = @[@"banner_two",@"",@"",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@60,@20,@100,@150,@200,@40];
            NSArray *title = @[@"",@"",@"",@"",@"",@"",@"预约考试",@""];
            
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
                        model.grade = [modela.lastExamScore floatValue];;
                        
                        
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
                
                [data addObject:model];
            }
            
            //科目一通过考试
        }else if ([subProgress isEqualToString:@"4"]){
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
                        model.grade = [modela.lastExamScore floatValue];
                        
                        
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
                
                [data addObject:model];
            }
            
        }else if ([subProgress isEqualToString:@"5"]){
            
        }else {
            
        }
        
    }else if ([progrss isEqualToString:@"3"]){
        
        
        if ([subProgress isEqualToString:@"0"]) {
            
            NSArray *arra = @[@"banner_three",@""];
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
                
                [data addObject:model];
            }
        }else if ([subProgress isEqualToString:@"6"]){
            NSArray *arra = @[@"banner_three",@"",@"img_match",@"",@"",@"",@""];
            NSArray *heights = @[@100,@30,@130,@60,@60,@10,@120];
            NSArray *title = @[@"",@"",@"",@"场地名称:",@"详细地址:",@"场地名称:",@"系统正在为你匹配教练，匹配成功后，教练会与您联系，如果长时间教练没有和您联系，请拨打：4008392366  客服热线"];
            
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
                        model.style = createNormalCellStyleUserDdfinedImageOnly;
                        model.detailTitle = @"";
                        model.contenModel = UIViewContentModeCenter;
                        model.hasFootViewLine = YES;
                    }
                        break;
                    case 3:{
                        model.style = createNormalCellStyleNormal1;
                        model.color = TEXT_COLOR;
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:modela.trainPlaceName andImage:[UIImage imageNamed:@""] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
                        
                        model.titleFont = 14;
                    }
                        break;
                    case 4:{
                        model.style = createNormalCellStyleNormal1;
                        model.color = TEXT_COLOR;
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:[NSString stringWithFormat:@"%@ ",modela.trainPlaceAddress] andImage:[UIImage imageNamed:@"content_btn_link"] andOtherStr:@"" andBound:CGRectMake(0,-3,13,13)];
                        model.color = UNMAIN_TEXT_COLOR;
                        model.titleFont = 14;
                        
                    }
                        break;
                    case 5:{
                        model.style = createNormalCellStyleOnlyImageCenter;
                        model.color = [UIColor whiteColor];
                    }
                        break;
                    case 6:{
                        model.style = createNormalCellStyleUserDdfinedWhite;
                        model.titleFont = 14*TYPERATION;
                        NSMutableAttributedString *str = [NSMutableAttributedString textKitAboutWithStr:model.title andImage:[UIImage imageNamed:@""] andOtherStr:@"" andBound:CGRectMake(0,-3,14,14)];
                        [str addAttribute:NSForegroundColorAttributeName value:BLUE_BACKGROUND_COLOR range:NSMakeRange(str.length-16,10)];
                        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                        [style setLineSpacing:6];
                        [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
                        model.AttributedStr = str;
                        model.color = ADB1B9;
                    }
                        break;
                    case 7:{
                        model.style = createNormalCellStyleUserDdfinedTwo;
                        model.hasDefalut = YES;
                    }
                        break;
                        
                    default:
                        break;
                }
                
                [data addObject:model];
            }
            //科目二扫码打卡界面
        }else if ([subProgress isEqualToString:@"1"] || [subProgress isEqualToString:@"2"]){
            NSArray *arra = @[@"banner_three",@"",@"",@"",@"",@"img_waitfor",@""];
            NSArray *heights = @[@100,@20,@60,@20,@50,@250,@100];
            NSArray *title = @[@"",@"",@"",@"",@"",@"在西培学堂完成1320分钟学习后即可约考",@"立即约考"];
            
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
                        model.detailTitle = [NSString stringWithFormat:@"%d次",modela.studyCount];
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
                
                [data addObject:model];
            }
            // 科目二预约
        }else if ([subProgress isEqualToString:@"3"]){
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
                
                [data addObject:model];
            }
            //科目二未通过考试
        }else if ([subProgress isEqualToString:@"5"]){
            NSArray *arra = @[@"banner_three",@"",@"",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@60,@20,@100,@150,@200,@40];
            NSArray *title = @[@"",@"",@"",@"",@"",@"",@"继续练车",@""];
            
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
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"观看视频  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
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
                        model.style = createNormalCellStyleUserDdfinedThere;
                        model.color = BLUE_BACKGROUND_COLOR;
                        model.detailTitle = @"很遗憾，您未能通过考试,请继续加油!";
                        model.hasFootViewLine = YES;
                    }
                        break;
                    case 5:{
                        model.style = createNormalCellStyleBang;
                        model.grade = [modela.lastExamScore floatValue];
                        
                        
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
                
                [data addObject:model];
            }
            //科目二通过考试
        }else if ([subProgress isEqualToString:@"4"]){
            NSArray *arra = @[@"banner_three",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@100,@150,@100,@40];
            NSArray *title = @[@"",@"",@"",@"",@"开始科目三的学习",@""];
            
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
                        model.detailTitle = @"恭喜您通过科目二考试";
                        model.hasFootViewLine = YES;
                    }
                        break;
                    case 3:{
                        model.style = createNormalCellStyleBang;
                        model.grade = [modela.lastExamScore floatValue];
                        
                        
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
                
                [data addObject:model];
            }
        }else if ([subProgress isEqualToString:@"6"]){
            
        }else {
            
        }
        
    }else if ([progrss isEqualToString:@"4"]){
        
        //科目三扫码打卡界面
        if ([subProgress isEqualToString:@"0"]|| [subProgress isEqualToString:@"1"]) {
            NSArray *arra = @[@"banner_four",@"",@"",@"",@"",@"img_waitfor",@""];
            NSArray *heights = @[@100,@20,@60,@20,@50,@250,@100];
            NSArray *title = @[@"",@"",@"",@"",@"",@"",@"立即约考"];
            
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
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"科目三学习视频  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
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
                        model.title = @"科目三练车打卡累积";
                        model.detailTitle = [NSString stringWithFormat:@"%d次",modela.studyCount];
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
                
                [data addObject:model];
            }
           //科目三预约考试
        }else if ([subProgress isEqualToString:@"3"]){
            NSArray *arra = @[@"banner_four",@"",@""];
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
                
                [data addObject:model];
            }
             //科目三未通过考试
        }else if ([subProgress isEqualToString:@"5"]){
            NSArray *arra = @[@"banner_four",@"",@"",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@60,@20,@100,@150,@200,@40];
            NSArray *title = @[@"",@"",@"",@"",@"",@"",@"再次练车",@""];
            
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
                        model.AttributedStr = [NSMutableAttributedString textKitAboutWithStr:@"观看视频  " andImage:[UIImage imageNamed:@"btn_go"] andOtherStr:@"" andBound:CGRectMake(0,-3,8,13)];
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
                        model.style = createNormalCellStyleUserDdfinedThere;
                        model.color = BLUE_BACKGROUND_COLOR;
                        model.detailTitle = @"很遗憾，您未能通过考试,请继续加油!";
                        model.hasFootViewLine = YES;
                    }
                        break;
                    case 5:{
                        model.style = createNormalCellStyleBang;
                        model.grade = [modela.lastExamScore floatValue];
                        
                        
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
                
                [data addObject:model];
            }
            //科目三通过考试
        }else if ([subProgress isEqualToString:@"4"]){
            NSArray *arra = @[@"banner_four",@"",@"",@"",@"",@""];
            NSArray *heights = @[@100,@20,@100,@150,@100,@40];
            NSArray *title = @[@"",@"",@"",@"",@"进入科目四",@""];
            
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
                        model.detailTitle = @"恭喜您通过科目三考试";
                        model.hasFootViewLine = YES;
                    }
                        break;
                    case 3:{
                        model.style = createNormalCellStyleBang;
                        model.grade = [modela.lastExamScore floatValue];
                        
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
                
                [data addObject:model];
            }
        }else if ([subProgress isEqualToString:@"3"]){
            
        }else {
            
        }
        
    }else if ([progrss isEqualToString:@"5"]){
        
        if ([subProgress isEqualToString:@"0"]) {
            
        }else if ([subProgress isEqualToString:@"1"]){
            
        }else if ([subProgress isEqualToString:@"2"]){
            
        }else if ([subProgress isEqualToString:@"3"]){
            
        }else {
            
        }
        
    }else if ([progrss isEqualToString:@"6"]){
        
        if ([subProgress isEqualToString:@"0"]) {
            
        }else if ([subProgress isEqualToString:@"1"]){
            
        }else if ([subProgress isEqualToString:@"2"]){
            
        }else if ([subProgress isEqualToString:@"3"]){
            
        }else {
            
        }
        
    }else{
        
    }
    
    if (_block) {
        _block(data);
    }
}

@end
