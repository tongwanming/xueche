//
//  ApplySureViewController.m
//  test
//
//  Created by auralic on 17/11/30.
//  Copyright © 2017年 tidalicHifi. All rights reserved.
//

#import "ApplySureViewController.h"

@interface ApplySureViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnView;

@end

@implementation ApplySureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btnView.layer.masksToBounds = YES;
    _btnView.layer.cornerRadius = 20;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //[self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
    
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
