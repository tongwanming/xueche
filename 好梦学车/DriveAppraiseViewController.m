//
//  DriveAppraiseViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "DriveAppraiseViewController.h"
#import "StartButton.h"
#import "StartButtonOne.h"
#import "StartButtonTwo.h"
#import "StartButtonThree.h"

@interface DriveAppraiseViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DriveAppraiseViewController{
    UIView *topView;
    UIView *bottonView;
    UITextView *textView;
}
- (IBAction)btnClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.contentSize = CGSizeMake(CURRENT_BOUNDS.width, 436+265);
    _scrollView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
    [self createView];
    // Do any additional setup after loading the view from its nib.
}

- (void)createView{
    topView = [[UIView alloc] initWithFrame:CGRectMake(16*TYPERATION, 15*TYPERATION, CURRENT_BOUNDS.width-16*TYPERATION*2, 254)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.masksToBounds = YES;
    topView.layer.cornerRadius = 6;
    [_scrollView addSubview:topView];
    
    CGFloat width;
    CGFloat height;
    
    UILabel *appraisLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, topView.frame.size.width-40, 40)];
    appraisLabel.numberOfLines = 2;
    appraisLabel.text = @"您的教练张淘淘于2017年6月3日与您完成了一次练车，请您对教练的教学进行评价";
    appraisLabel.textColor = UNMAIN_TEXT_COLOR;
    appraisLabel.textAlignment = NSTextAlignmentCenter;
    appraisLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:appraisLabel];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_user_logo"]];
    logoImage.frame = CGRectMake(topView.frame.size.width/2-40, CGRectGetMaxY(appraisLabel.frame)+20, 80, 80);
    logoImage.layer.masksToBounds = YES;
    logoImage.layer.cornerRadius = 40;
    [topView addSubview:logoImage];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImage.frame)+10, topView.frame.size.width, 16)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = TEXT_COLOR;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.text = @"张淘淘";
    [topView addSubview:nameLabel];
    
    UILabel *nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameLabel.frame)+25, 80, 40)];
    nameLabel1.textAlignment = NSTextAlignmentCenter;
    nameLabel1.textColor = TEXT_COLOR;
    nameLabel1.font = [UIFont systemFontOfSize:16];
    nameLabel1.text = @"总体评价";
    [topView addSubview:nameLabel1];
    
    for (int i = 0; i < 5; i++) {
        StartButton *btn = [StartButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"content_btn_star_default"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        btn.tag = 1+i;
        btn.frame = CGRectMake(CGRectGetMaxX(nameLabel1.frame)+i*40, CGRectGetMaxY(nameLabel.frame)+25, 40, 40);
        [btn addTarget:self action:@selector(btnClicka:) forControlEvents:UIControlEventTouchUpInside];
        //        btn.backgroundColor = [UIColor purpleColor];
        [topView addSubview:btn];
    }
    
    bottonView = [[UIView alloc] initWithFrame:CGRectMake(16*TYPERATION, CGRectGetMaxY(topView.frame)+1, CURRENT_BOUNDS.width-16*TYPERATION*2, 436)];
    bottonView.backgroundColor = [UIColor whiteColor];
    bottonView.layer.masksToBounds = YES;
    bottonView.layer.cornerRadius = 6;
    [_scrollView addSubview:bottonView];
    
    
    UILabel *nameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20,25, 80, 40)];
    nameLabel2.textAlignment = NSTextAlignmentCenter;
    nameLabel2.textColor = TEXT_COLOR;
    nameLabel2.font = [UIFont systemFontOfSize:16];
    nameLabel2.text = @"教学质量";
    [bottonView addSubview:nameLabel2];
    
    for (int i = 0; i < 5; i++) {
        StartButtonOne *btn = [StartButtonOne buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"content_btn_face_default"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        btn.tag = 1+i;
        btn.frame = CGRectMake(CGRectGetMaxX(nameLabel1.frame)+i*40, 25, 40, 40);
        [btn addTarget:self action:@selector(btnClickaOne:) forControlEvents:UIControlEventTouchUpInside];
        //        btn.backgroundColor = [UIColor purpleColor];
        [bottonView addSubview:btn];
    }
    
    UILabel *nameLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameLabel2.frame)+25, 80, 40)];
    nameLabel3.textAlignment = NSTextAlignmentCenter;
    nameLabel3.textColor = TEXT_COLOR;
    nameLabel3.font = [UIFont systemFontOfSize:16];
    nameLabel3.text = @"服务态度";
    [bottonView addSubview:nameLabel3];
    
    for (int i = 0; i < 5; i++) {
        StartButtonTwo *btn = [StartButtonTwo buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"content_btn_face_default"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        btn.tag = 1+i;
        btn.frame = CGRectMake(CGRectGetMaxX(nameLabel1.frame)+i*40, CGRectGetMaxY(nameLabel2.frame)+25, 40, 40);
        [btn addTarget:self action:@selector(btnClickaTwo:) forControlEvents:UIControlEventTouchUpInside];
        //        btn.backgroundColor = [UIColor purpleColor];
        [bottonView addSubview:btn];
    }
    
    UILabel *nameLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameLabel3.frame)+25, 80, 40)];
    nameLabel4.textAlignment = NSTextAlignmentCenter;
    nameLabel4.textColor = TEXT_COLOR;
    nameLabel4.font = [UIFont systemFontOfSize:16];
    nameLabel4.text = @"时间安排";
    [bottonView addSubview:nameLabel4];
    
    for (int i = 0; i < 5; i++) {
        StartButtonThree *btn = [StartButtonThree buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"content_btn_face_default"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        btn.tag = 1+i;
        btn.frame = CGRectMake(CGRectGetMaxX(nameLabel1.frame)+i*40, CGRectGetMaxY(nameLabel3.frame)+25, 40, 40);
        [btn addTarget:self action:@selector(btnClickaThree:) forControlEvents:UIControlEventTouchUpInside];
        //        btn.backgroundColor = [UIColor purpleColor];
        [bottonView addSubview:btn];
    }
    
   textView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameLabel4.frame)+25, bottonView.frame.size.width-40, 80)];
    textView.textColor = TEXT_COLOR;
    textView.backgroundColor = EEEEEE;
    [bottonView addSubview:textView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(textView.frame)+40, bottonView.frame.size.width-40, 40);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.backgroundColor = BLUE_BACKGROUND_COLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottonView addSubview:btn];
    [btn addTarget:self action:@selector(btnClickSure:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
}

- (void)btnClicka:(UIButton *)btn{
    NSInteger n = btn.tag;
   
    for (UIView *button in topView.subviews) {
        if ([button isKindOfClass:[StartButton class]]) {
            if (((StartButton *)button).tag <= n) {
                [(StartButton *)button setImage:[UIImage imageNamed:@"content_btn_star_selected"] forState:UIControlStateNormal];
            }else{
                [(StartButton *)button setImage:[UIImage imageNamed:@"content_btn_star_default"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)btnClickaOne:(UIButton *)btn{
    NSInteger n = btn.tag;
    
    for (UIView *button in bottonView.subviews) {
        if ([button isKindOfClass:[StartButtonOne class]]) {
            if (((StartButtonOne *)button).tag <= n) {
                [(StartButtonOne *)button setImage:[UIImage imageNamed:@"content_btn_face_selected"] forState:UIControlStateNormal];
            }else{
                [(StartButtonOne *)button setImage:[UIImage imageNamed:@"content_btn_face_default"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)btnClickaTwo:(UIButton *)btn{
    NSInteger n = btn.tag;
    
    for (UIView *button in bottonView.subviews) {
        if ([button isKindOfClass:[StartButtonTwo class]]) {
            if (((StartButtonTwo *)button).tag <= n) {
                [(StartButtonTwo *)button setImage:[UIImage imageNamed:@"content_btn_face_selected"] forState:UIControlStateNormal];
            }else{
                [(StartButtonTwo *)button setImage:[UIImage imageNamed:@"content_btn_face_default"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)btnClickaThree:(UIButton *)btn{
    NSInteger n = btn.tag;
    
    for (UIView *button in bottonView.subviews) {
        if ([button isKindOfClass:[StartButtonThree class]]) {
            if (((StartButtonThree *)button).tag <= n) {
                [(StartButtonThree *)button setImage:[UIImage imageNamed:@"content_btn_face_selected"] forState:UIControlStateNormal];
            }else{
                [(StartButtonThree *)button setImage:[UIImage imageNamed:@"content_btn_face_default"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)btnClickSure:(UIButton *)btn{
    NSLog(@"确定按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
