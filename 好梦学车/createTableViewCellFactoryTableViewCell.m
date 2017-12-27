//
//  createTableViewCellFactoryTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "createTableViewCellFactoryTableViewCell.h"
#import "UILabel+changeLineSpace.h"
#import "SGQRCodeGenerateManager.h"

#define LEFT_INTEVAL 16
#define GRADE_PROGRESS 100

@implementation createTableViewCellFactoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andModel:(createNormalCellModel *)model{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = EEEEEE;
        switch (model.style) {
            case createNormalCellStyleOnlyImageCenter:{
                
                if (model.color == nil) {
                    UIView *bacV = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                    bacV.backgroundColor = [UIColor whiteColor];
                    [self addSubview:bacV];
                }
                
                UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.imageViewStr]];
                im.frame = CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION, model.he);
                im.center = CGPointMake(CURRENT_BOUNDS.width/2, model.he/2);
                if (model.contenModel) {
                    im.contentMode = model.contenModel;
                }else{
                    im.contentMode = UIViewContentModeScaleAspectFit;
                }
                
                if (model.hasFootViewLine) {
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                    NSString *userId = [userDic objectForKey:@"userId"];
                    
                    CGFloat scale = 0.2;
                    
                    // 2、将最终合得的图片显示在UIImageView上
                    im.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:userId logoImageName:@"" logoScaleToSuperView:scale];
                }
                
                [self addSubview:im];
                self.backgroundColor = model.color;
            }
                break;
            case createNormalCellStyleUserDdfinedOne:{
                
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                backView.backgroundColor = [UIColor whiteColor];
                backView.layer.masksToBounds = YES;
                backView.layer.cornerRadius = 8;
                [self addSubview:backView];
                
                UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, model.he-10, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 10)];
                backView1.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:backView1];
                
                UIView *centerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, model.he)];
                centerLineView.center = CGPointMake(CURRENT_BOUNDS.width/2, model.he/2);
                centerLineView.backgroundColor = EEEEEE;
                [self addSubview:centerLineView];
                
                UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, model.he-1, CURRENT_BOUNDS.width, 1)];
                footView.backgroundColor = EEEEEE;
                [self addSubview:footView];
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, model.he*1/4, CURRENT_BOUNDS.width/2, model.he/4)];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.textColor = BLUE_BACKGROUND_COLOR;
                
                titleLabel.font = [UIFont systemFontOfSize:30];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.title];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0]
                 range:NSMakeRange(model.title.length-3, 3)];
                titleLabel.attributedText = str;
                [self addSubview:titleLabel];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, model.he*3/5, CURRENT_BOUNDS.width/2, model.he/4)];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = TEXT_COLOR;
                label.text = @"学习时长";
                label.font = [UIFont systemFontOfSize:20];
                [self addSubview:label];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 3)];
                view.backgroundColor = BLUE_BACKGROUND_COLOR;
                view.center = CGPointMake(CURRENT_BOUNDS.width/4, model.he/2+10);
                [self addSubview:view];
                
                UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2, model.he*1/4, CURRENT_BOUNDS.width/2, model.he/4)];
                titleLabel1.textAlignment = NSTextAlignmentCenter;
                titleLabel1.textColor = BLUE_BACKGROUND_COLOR;
                
                titleLabel1.font = [UIFont systemFontOfSize:30];
                NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:model.detailTitle];
                [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0]
                            range:NSMakeRange(model.detailTitle.length-3, 3)];
                titleLabel1.attributedText = str1;
                [self addSubview:titleLabel1];
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2, model.he*3/5, CURRENT_BOUNDS.width/2, model.he/4)];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.textColor = TEXT_COLOR;
                label1.text = @"累计学习";
                label1.font = [UIFont systemFontOfSize:20];
                [self addSubview:label1];
                
                UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 3)];
                view1.backgroundColor = BLUE_BACKGROUND_COLOR;
                view1.center = CGPointMake(CURRENT_BOUNDS.width*3/4, model.he/2+10);
                [self addSubview:view1];
                
            }
                break;
                
            case createNormalCellStyleNormal:{
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, model.he)];
                titLabel.text = model.title;
                titLabel.textColor = model.color;
                titLabel.textAlignment = NSTextAlignmentCenter;
                titLabel.font = [UIFont systemFontOfSize:model.titleFont];
                [self addSubview:titLabel];
            }
                break;
            case createNormalCellStyleUserDdfinedTwo:{
                UIView *backView;
                if (model.hasDefalut) {
                    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, model.he)];
                    backView.backgroundColor = [UIColor whiteColor];
                    
                    [self addSubview:backView];
                }else{
                    backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                    backView.backgroundColor = [UIColor whiteColor];
                    backView.layer.masksToBounds = YES;
                    backView.layer.cornerRadius = 8;
                    [self addSubview:backView];
                }
                
                
                UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 10)];
                backView1.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:backView1];
                
                UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                sureBtn.frame = CGRectMake(0, 0, backView.frame.size.width-88*TYPERATION, 40);
                sureBtn.backgroundColor = BLUE_BACKGROUND_COLOR;
                [sureBtn setTitle:model.title forState:UIControlStateNormal];
                sureBtn.userInteractionEnabled = NO;
                sureBtn.center = CGPointMake(CURRENT_BOUNDS.width/2, 40);
                [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sureBtn.layer.masksToBounds = YES;
                sureBtn.layer.cornerRadius = 20;
                sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [self addSubview:sureBtn];
                
                if (model.detailTitle) {
                    sureBtn.center = CGPointMake(CURRENT_BOUNDS.width/2, 30);
                    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width-88*TYPERATION, 50)];
                    detailLabel.textColor = UNMAIN_TEXT_COLOR;
                    detailLabel.text = model.detailTitle;
                    detailLabel.font = [UIFont systemFontOfSize:model.titleFont];
                    detailLabel.numberOfLines = 0;
                    detailLabel.textAlignment = NSTextAlignmentCenter;
                    detailLabel.center = CGPointMake(CURRENT_BOUNDS.width/2,
                                                     CGRectGetMaxY(sureBtn.frame)+50);
                    [detailLabel changeLineSpaceForLabel:detailLabel WithSpace:6];
                    [self addSubview:detailLabel];
                }
                
            }
                break;
                
            case createNormalCellStyleUserDdfinedThere:{
                UIImageView *bacvView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.imageViewStr]];
                if (model.contenModel) {
                    bacvView.contentMode = model.contenModel;
                }else{
                    bacvView.contentMode = UIViewContentModeTop;
                }
                
                bacvView.frame = CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he);
                bacvView.backgroundColor = [UIColor whiteColor];
                bacvView.layer.masksToBounds = YES;
                bacvView.layer.cornerRadius = 8;
                [self addSubview:bacvView];
                
                UIImageView *bacvView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
                bacvView1.frame = CGRectMake(LEFT_INTEVAL*TYPERATION, model.he-10, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 10);
                bacvView1.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:bacvView1];
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CURRENT_BOUNDS.width, 18)];
                titleLabel.font = [UIFont systemFontOfSize:18*TYPERATION];
                if (model.color) {
                    titleLabel.textColor = model.color;
                }else{
                   titleLabel.textColor = TEXT_COLOR;
                }
                
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.text = model.title;
                [self addSubview:titleLabel];
                
                UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+6, CURRENT_BOUNDS.width, 18)];
                titleLabel1.font = [UIFont systemFontOfSize:18*TYPERATION];
                if (model.color) {
                    titleLabel1.textColor = model.color;
                }else{
                    titleLabel1.textColor = TEXT_COLOR;
                }
                
                titleLabel1.textAlignment = NSTextAlignmentCenter;
                titleLabel1.text = model.detailTitle;
                [self addSubview:titleLabel1];
                if (model.hasFootViewLine) {
                    
                }else{
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 1.5)];
                    lineView.backgroundColor = BLUE_BACKGROUND_COLOR;
                    lineView.center = CGPointMake(CURRENT_BOUNDS.width/2, CGRectGetMaxY(titleLabel1.frame)+30);
                    [self addSubview:lineView];
                }
                
                
            }
                break;
            case createNormalCellStyleUserDdfinedImageOnly:{
                UIImageView *bacvView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.imageViewStr]];
                if (model.contenModel) {
                    bacvView.contentMode = model.contenModel;
                }else{
                    bacvView.contentMode = UIViewContentModeTop;
                }
                
                bacvView.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, model.he);
                bacvView.backgroundColor = [UIColor whiteColor];
              
                [self addSubview:bacvView];
                
                UIImageView *bacvView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
                bacvView1.frame = CGRectMake(LEFT_INTEVAL*TYPERATION, model.he-10, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 10);
                bacvView1.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:bacvView1];
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CURRENT_BOUNDS.width, 18)];
                titleLabel.font = [UIFont systemFontOfSize:18*TYPERATION];
                if (model.color) {
                    titleLabel.textColor = model.color;
                }else{
                    titleLabel.textColor = TEXT_COLOR;
                }
                
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.text = model.title;
                [self addSubview:titleLabel];
                
                UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+6, CURRENT_BOUNDS.width, 18)];
                titleLabel1.font = [UIFont systemFontOfSize:18*TYPERATION];
                if (model.color) {
                    titleLabel1.textColor = model.color;
                }else{
                    titleLabel1.textColor = TEXT_COLOR;
                }
                
                titleLabel1.textAlignment = NSTextAlignmentCenter;
                titleLabel1.text = model.detailTitle;
                [self addSubview:titleLabel1];
                if (model.hasFootViewLine) {
                    
                }else{
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 1.5)];
                    lineView.backgroundColor = BLUE_BACKGROUND_COLOR;
                    lineView.center = CGPointMake(CURRENT_BOUNDS.width/2, CGRectGetMaxY(titleLabel1.frame)+30);
                    [self addSubview:lineView];
                }
                
                
            }
                break;
            case createNormalCellStyleUserDdfinedForth:{
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                view.backgroundColor = [UIColor whiteColor];
                [self addSubview:view];
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/3, 0, CURRENT_BOUNDS.width*2/3-LEFT_INTEVAL*TYPERATION, model.he)];
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.font = [UIFont systemFontOfSize:model.titleFont];
                titleLabel.textColor = model.color;
                titleLabel.textAlignment = NSTextAlignmentLeft;
                titleLabel.attributedText = model.AttributedStr;
                
                [self addSubview:titleLabel];
            }
                break;
            case createNormalCellStyleUserDdfinedFifth:{
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                view.backgroundColor = [UIColor whiteColor];
                [self addSubview:view];
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/5, 0, CURRENT_BOUNDS.width*3/5, model.he)];
                titleLabel.backgroundColor = [UIColor whiteColor];
                titleLabel.font = [UIFont systemFontOfSize:model.titleFont];
                titleLabel.textColor = model.color;
                titleLabel.textAlignment = NSTextAlignmentLeft;
                titleLabel.numberOfLines = 0;
                titleLabel.attributedText = model.AttributedStr;
                [self addSubview:titleLabel];
            }
                break;
            case createNormalCellStyleUserDdfinedSix:{
                
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION,0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                backView.backgroundColor = [UIColor whiteColor];
                backView.layer.masksToBounds = YES;
                backView.layer.cornerRadius = 8;
                [self addSubview:backView];
                
                if (model.hasDefalut) {
                    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40*TYPERATION, 0, 100, model.he)];
                    titleLabel1.text = model.title;
                    titleLabel1.font = [UIFont systemFontOfSize:model.titleFont];
                    titleLabel1.textColor = model.color;
                    titleLabel1.textAlignment = NSTextAlignmentLeft;
                    [backView addSubview:titleLabel1];
                    
                    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width-40*TYPERATION-100, 0, 100, model.he)];
                    titleLabel2.font = [UIFont systemFontOfSize:model.titleFont];
                    titleLabel2.textColor = model.color;
                    titleLabel2.textAlignment = NSTextAlignmentRight;
                    titleLabel2.attributedText = model.AttributedStr;
                    [backView addSubview:titleLabel2];
                }else{
                    UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                    titleLabel3.font = [UIFont systemFontOfSize:model.titleFont];
                    titleLabel3.textColor = model.color;
                    titleLabel3.textAlignment = NSTextAlignmentCenter;
                    titleLabel3.attributedText = model.AttributedStr;
                    [backView addSubview:titleLabel3];
                }
                
                
                
                
            }
                break;
            case createNormalCellStyleUserDdfinedSeven:{
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                backView.backgroundColor = model.bgColor;
                backView.layer.masksToBounds = YES;
                backView.layer.cornerRadius = 8;
                
                [self addSubview:backView];
                
                UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 10)];
                backView1.backgroundColor = model.bgColor;
                
                [self addSubview:backView1];
                
                UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, model.he)];
                titLabel.text = model.title;
                titLabel.font = [UIFont systemFontOfSize:model.titleFont];
                titLabel.textColor = model.color;
                titLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:titLabel];
            }
                break;
            case createNormalCellStyleValue1:{
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                backView.backgroundColor = [UIColor whiteColor];
                backView.layer.masksToBounds = YES;
                backView.layer.cornerRadius = 8;
                [self addSubview:backView];
                
                UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, model.he-10, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 10)];
                backView1.backgroundColor = [UIColor whiteColor];
                [self addSubview:backView1];
                UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10*TYPERATION, 0, 200, model.he)];
                titleLabel1.text = model.title;
                titleLabel1.font = [UIFont systemFontOfSize:model.titleFont-2];
                titleLabel1.textColor = model.color;
                titleLabel1.textAlignment = NSTextAlignmentLeft;
               
                [backView addSubview:titleLabel1];
                
                UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width-10*TYPERATION-105, 0, 100, model.he)];
                titleLabel2.font = [UIFont systemFontOfSize:model.titleFont-2];
                titleLabel2.textColor = UNMAIN_TEXT_COLOR;
                titleLabel2.textAlignment = NSTextAlignmentRight;
                titleLabel2.text = model.detailTitle;
                [backView addSubview:titleLabel2];
                
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, model.he-1, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, 1)];
                lineView.backgroundColor = EEEEEE;
                [self addSubview:lineView];
            }
                break;
            case createNormalCellStyleBang:{
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                bgView.backgroundColor = [UIColor whiteColor];
                [self addSubview:bgView];
                UIImageView *image;
                if (model.grade >=90) {
                    image = [self createImageWithBgImage:@"circle" andLogoImage:@"hook" andName:[NSString stringWithFormat:@"%0.0lf",model.grade]];
                }else{
                    image = [self createImageWithBgImage:@"circle" andLogoImage:@"bang" andName:[NSString stringWithFormat:@"%0.0lf",model.grade]];
                }
            
                image.frame = CGRectMake(0, (model.he-GRADE_PROGRESS)/2, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, GRADE_PROGRESS);
                [bgView addSubview:image];
                
            }
                break;
            case createNormalCellStyleUserDdfinedEight:{
                
                UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, model.he/2)];
                topView.backgroundColor = BLUE_BACKGROUND_COLOR;
                [self addSubview:topView];
                
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION,0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                backView.backgroundColor = [UIColor whiteColor];
                backView.layer.masksToBounds = YES;
                backView.layer.cornerRadius = 8;
                [self addSubview:backView];
                
                if (model.hasDefalut) {
                    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40*TYPERATION, 0, 100, model.he)];
                    titleLabel1.text = model.title;
                    titleLabel1.font = [UIFont systemFontOfSize:model.titleFont];
                    titleLabel1.textColor = model.color;
                    titleLabel1.textAlignment = NSTextAlignmentLeft;
                    [backView addSubview:titleLabel1];
                    
                    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width-40*TYPERATION-100, 0, 100, model.he)];
                    titleLabel2.font = [UIFont systemFontOfSize:model.titleFont];
                    titleLabel2.textColor = model.color;
                    titleLabel2.textAlignment = NSTextAlignmentRight;
                    titleLabel2.attributedText = model.AttributedStr;
                    [backView addSubview:titleLabel2];
                }else{
                    UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                    titleLabel3.font = [UIFont systemFontOfSize:model.titleFont];
                    titleLabel3.textColor = model.color;
                    titleLabel3.textAlignment = NSTextAlignmentCenter;
                    titleLabel3.attributedText = model.AttributedStr;
                    [backView addSubview:titleLabel3];
                }
            }
                break;
            case createNormalCellStyleUserDdfinedTen:{
                
            }
                break;
            case createNormalCellStyleNormal1:{
                self.backgroundColor = [UIColor whiteColor];
                UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20*TYPERATION, 15, 150, model.he)];
                titleLabel1.text = model.title;
                titleLabel1.font = [UIFont systemFontOfSize:model.titleFont];
                titleLabel1.textColor = model.color;
                titleLabel1.textAlignment = NSTextAlignmentLeft;
                [self addSubview:titleLabel1];
                
                UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-20*TYPERATION-200, 15, 200, model.he)];
                titleLabel2.font = [UIFont systemFontOfSize:model.titleFont];
                titleLabel2.attributedText = model.AttributedStr;
                titleLabel2.textAlignment = NSTextAlignmentRight;
                [self addSubview:titleLabel2];
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20*TYPERATION, model.he-1, CURRENT_BOUNDS.width-20*TYPERATION*2, 1)];
                lineView.backgroundColor = EEEEEE;
                [self addSubview:lineView];
            }
                break;
                
            case createNormalCellStyleUserDdfinedWhite:{
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, model.he)];
                bgView.backgroundColor = [UIColor whiteColor];
                [self addSubview:bgView];
                
                UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20*TYPERATION, 15, CURRENT_BOUNDS.width-20*TYPERATION*2, model.he-15)];
                titleLabel2.textColor = model.color;
                titleLabel2.font = [UIFont systemFontOfSize:model.titleFont];
                titleLabel2.attributedText = model.AttributedStr;
                titleLabel2.textAlignment = NSTextAlignmentCenter;
                titleLabel2.numberOfLines = 2;
                [bgView addSubview:titleLabel2];
            }
                break;
            default:
                break;
        }
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIImageView *)createImageWithBgImage:(NSString *)bgImageStr andLogoImage:(NSString *)logoImageStr andName:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImageStr]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.backgroundColor = [UIColor orangeColor];
    imageView.frame = CGRectMake(0, 0, GRADE_PROGRESS, GRADE_PROGRESS);
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:logoImageStr]];
    logoImage.frame = CGRectMake(0, 0, GRADE_PROGRESS/3, GRADE_PROGRESS/3);
//    logoImage.backgroundColor = [UIColor redColor];
    logoImage.center = CGPointMake((CURRENT_BOUNDS.width-LEFT_INTEVAL*2)/2, GRADE_PROGRESS/2-20);
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [imageView addSubview:logoImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CURRENT_BOUNDS.width-LEFT_INTEVAL*2)/2-50, CGRectGetMaxY(logoImage.frame)+10, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = BLUE_BACKGROUND_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = [NSString stringWithFormat:@"%@分",title];
    [imageView addSubview:titleLabel];
    return imageView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
