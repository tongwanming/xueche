//
//  SuperFirstViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SuperFirstViewController.h"
#import "FirstViewController.h"
#import "ProgressViewController.h"

@interface SuperFirstViewController ()

@end

@implementation SuperFirstViewController{
    FirstViewController *_firstV;
    ProgressViewController *_progressV;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        if (_firstV == nil) {
            _firstV = [[FirstViewController alloc] init];
        }
        _firstV.view.frame = self.view.bounds;
        [_firstV didMoveToParentViewController:self];
        [self.view addSubview:_firstV.view];
    }else{
        if (_progressV == nil) {
            _progressV = [[ProgressViewController alloc] init];
        }
        _progressV.view.frame = self.view.bounds;
        [_progressV didMoveToParentViewController:self];
        [self.view addSubview:_progressV.view];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    
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
