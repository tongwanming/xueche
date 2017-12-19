//
//  SuperFirstViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/11/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SuperFirstViewController.h"
#import "FirstViewController.h"

#import "SubjectOneCurrentViewController.h"

@interface SuperFirstViewController ()<FirstViewControllerDelegate,SubjectOneCurrentViewControllerDelegate>

@end

@implementation SuperFirstViewController{
    FirstViewController *_firstV;
    SubjectOneCurrentViewController *_progressV;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//    if (_firstV == nil) {
//        _firstV = [[FirstViewController alloc] init];
//        _firstV.delegate = self;
//    }
//    _firstV.view.frame = self.view.bounds;
//    [_firstV didMoveToParentViewController:self];
//    [self.view addSubview:_firstV.view];
//    return;
    
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
            _progressV = [[SubjectOneCurrentViewController alloc] init];
            _progressV.delegate = self;
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

#pragma mark - SubjectOneCurrentViewControllerDelegateActive

- (void)SubjectOneCurrentViewControllerDelegateWithActiveVC:(BasicViewController *)v andTag:(NSString *)tag{
    
    if (tag.length > 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertViewActiveWithDes:tag];
        });
        
        return;
    }
    switch ([tag intValue]) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:v];
                
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
                
            });
        }

            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:v animated:YES];
            });
        }
            
            break;
        case 3:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E8%A5%BF%E5%9F%B9%E5%AD%A6%E5%A0%82/id1189867693?mt=8"]];
            });
            
        }
            
            break;
        case 4:{
            
        }
            
            break;
        case 5:{
            
        }
            
            break;
            
        default:
            break;
    }
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

- (void)showAlertViewActiveWithDes:(NSString *)des{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:des preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

@end
