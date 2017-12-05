//
//  testOneViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "testOneViewController.h"

#import "ApplyLocationViewController.h"
#import "CheckMedicalStationViewController.h"

#import "TestSiteChoosedViewController.h"

#import "ExaminationBookingViewController.h"
#import "SubjectOneCurrentViewController.h"
#import "ApplySureViewController.h"

#import "SubjectOneViewControllera.h"

@interface testOneViewController ()

@end

@implementation testOneViewController
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    switch (btn.tag) {
        case 1001:{
            ApplyLocationViewController *v = [[ApplyLocationViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
            break;
        case 1002:{
            CheckMedicalStationViewController *v = [[CheckMedicalStationViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
            break;
        case 1003:{
            TestSiteChoosedViewController *v = [[TestSiteChoosedViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
            break;
        case 1004:{
            SubjectOneCurrentViewController *v = [[SubjectOneCurrentViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
