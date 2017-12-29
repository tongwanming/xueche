//
//  NoticeViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/12/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *text;

@end

@implementation NoticeViewController
- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setDes:(NSString *)des{
    _des = des;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _text.text = _des;
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
