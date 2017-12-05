//
//  createTableViewCellFactoryTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/12/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "createTableViewCellFactoryTableViewCell.h"
#import "UILabel+changeLineSpace.h"

#define LEFT_INTEVAL 16

@implementation createTableViewCellFactoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andModel:(createNormalCellModel *)model{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = EEEEEE;
        switch (model.style) {
            case createNormalCellStyleOnlyImageCenter:{
                UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.imageViewStr]];
                im.frame = CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION, model.he);
                im.center = CGPointMake(CURRENT_BOUNDS.width/2, model.he/2);
                if (model.contenModel) {
                    im.contentMode = model.contenModel;
                }else{
                    im.contentMode = UIViewContentModeScaleAspectFit;
                }
                

                [self addSubview:im];
                self.backgroundColor = model.color;
            }
                break;
            case createNormalCellStyleUserDdfinedOne:{
                UIView *centerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, model.he)];
                centerLineView.center = CGPointMake(CURRENT_BOUNDS.width/2, model.he/2);
                centerLineView.backgroundColor = EEEEEE;
                [self addSubview:centerLineView];
                
                UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, model.he-1, CURRENT_BOUNDS.width, 1)];
                footView.backgroundColor = EEEEEE;
                [self addSubview:footView];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, model.he*2/3, CURRENT_BOUNDS.width/2, model.he/4)];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = TEXT_COLOR;
                label.text = @"学习时长";
                label.font = [UIFont systemFontOfSize:20];
                [self addSubview:label];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 3)];
                view.backgroundColor = BLUE_BACKGROUND_COLOR;
                view.center = CGPointMake(CURRENT_BOUNDS.width/4, model.he/2);
                [self addSubview:view];
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2, model.he*2/3, CURRENT_BOUNDS.width/2, model.he/4)];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.textColor = TEXT_COLOR;
                label1.text = @"累计学习";
                label1.font = [UIFont systemFontOfSize:20];
                [self addSubview:label1];
                
                UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 3)];
                view1.backgroundColor = BLUE_BACKGROUND_COLOR;
                view1.center = CGPointMake(CURRENT_BOUNDS.width*3/4, model.he/2);
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
                
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_INTEVAL*TYPERATION, 0, CURRENT_BOUNDS.width-LEFT_INTEVAL*TYPERATION*2, model.he)];
                backView.backgroundColor = [UIColor whiteColor];
                backView.layer.masksToBounds = YES;
                backView.layer.cornerRadius = 8;
                [self addSubview:backView];
                
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
                [self addSubview:sureBtn];
                
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
                titleLabel.font = [UIFont systemFontOfSize:18];
                titleLabel.textColor = TEXT_COLOR;
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.text = model.title;
                [self addSubview:titleLabel];
                
                UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CURRENT_BOUNDS.width, 18)];
                titleLabel1.font = [UIFont systemFontOfSize:18];
                titleLabel1.textColor = TEXT_COLOR;
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
//                [titleLabel changeLineSpaceForLabel:titleLabel WithSpace:6];
                [self addSubview:titleLabel];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
