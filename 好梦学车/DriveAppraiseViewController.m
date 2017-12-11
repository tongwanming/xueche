//
//  DriveAppraiseViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/12/8.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "DriveAppraiseViewController.h"
#import "StartButton.h"

@interface DriveAppraiseViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DriveAppraiseViewController{
    UIView *topView;
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
    
    for (int i = 0; i < 5; i++) {
        StartButton *btn = [StartButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        btn.tag = 1+i;
        [btn addTarget:self action:@selector(btnClicka:) forControlEvents:UIControlEventTouchUpInside];
        //        btn.backgroundColor = [UIColor purpleColor];
        [topView addSubview:btn];
    }
    
    UIView *bottonView = [[UIView alloc] initWithFrame:CGRectMake(16*TYPERATION, CGRectGetMaxY(topView.frame)+1, CURRENT_BOUNDS.width-16*TYPERATION*2, 436)];
    bottonView.backgroundColor = [UIColor whiteColor];
    bottonView.layer.masksToBounds = YES;
    bottonView.layer.cornerRadius = 6;
    [_scrollView addSubview:bottonView];
}

- (void)btnClicka:(UIButton *)btn{
    NSInteger n = btn.tag;
   
    for (UIView *button in topView.subviews) {
        if ([button isKindOfClass:[StartButton class]]) {
            if (((StartButton *)button).tag <= n) {
                [(StartButton *)button setImage:[UIImage imageNamed:@"star_big"] forState:UIControlStateNormal];
            }else{
                [(StartButton *)button setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
            }
        }
        
    }
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
