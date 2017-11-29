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

@interface SuperFirstViewController ()<FirstViewControllerDelegate>

@end

@implementation SuperFirstViewController{
    FirstViewController *_firstV;
    ProgressViewController *_progressV;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (_firstV == nil) {
        _firstV = [[FirstViewController alloc] init];
        _firstV.delegate = self;
    }
    _firstV.view.frame = self.view.bounds;
    [_firstV didMoveToParentViewController:self];
    [self.view addSubview:_firstV.view];
    return;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        if (_firstV == nil) {
            _firstV = [[FirstViewController alloc] init];
            _firstV.delegate = self;
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

#pragma mark - FirstViewControllerDelegateActive

- (void)FirstViewControllerDelegateWithActiveVC:(BasicViewController *)v andTag:(NSString *)tag{
    
    switch ([tag intValue]) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:v animated:YES];
            });}
            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(), ^{
               
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
                
                [self presentViewController:nav animated:YES completion:^{
                    
                }];

            });
        }
            
            break;
        case 3:{
            
        }
            
            break;
        case 4:
            
            break;
            
        default:
            break;
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
