//
//  ApplySureViewController.m
//  test
//
//  Created by auralic on 17/11/30.
//  Copyright © 2017年 tidalicHifi. All rights reserved.
//

#import "ApplySureViewController.h"
#import "SubjectOneViewControllera.h"
#import "CustomAlertView.h"
#import "URLConnectionHelper.h"

@interface ApplySureViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled1;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;




@end

@implementation ApplySureViewController

- (void)setModel:(SureApplyModel *)model{
    _model = model;
}

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
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSString *userId = [userDic objectForKey:@"userId"];
        if (_textFiled1.text.length == 6) {
            [CustomAlertView showAlertViewWithVC:self];
            NSDictionary *dic = @{@"endTime":_model.endTime,
                                  @"examTimeCode":_model.examTimeCode,
                                  @"smsCode":_textFiled1.text,
                                  @"startTime":_model.startTime,
                                  @"username":_model.username,
                                  @"studentUserId":userId
                                  };
            [[URLConnectionHelper shareDefaulte] loadPostDataWithUrl:@"http://101.37.161.13:7072/fecthdata-front-service/student/v201701/exam/apply" andDic:dic andSuccessBlock:^(NSArray *data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSDictionary *dic = (NSDictionary *)data;
                    [CustomAlertView hideAlertView];
                    
                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"预约成功" message:@"预约考试已经提交成功！" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        if ([[dic objectForKey:@"orderNo"] isEqual:[NSNull new]]) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"applySuccess" object:nil];
                        }else{
                            if ([[dic objectForKey:@"orderNo"] isEqual:[NSNull new]]) {
                                [self dismissViewControllerAnimated:YES completion:nil];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"applySuccess" object:nil];
                            }else{
                                SubjectOneViewControllera *v = [[SubjectOneViewControllera alloc] init];
                                v.payNum = [dic objectForKeyWithNoNsnull:@"orderNo"];
                                v.model = _model;
                                v.wwlsh = [dic objectForKeyWithNoNsnull:@"wwlsh"];
                                v.zjcx = [dic objectForKeyWithNoNsnull:@"zjcx"];
                                [self.navigationController pushViewController:v animated:YES];
                            }
                            
                        }
                        
                    }];
                    [v addAction:active];
                    [self presentViewController:v animated:YES completion:^{
                        
                    }];
                    
                });
            } andDicFiledResonBlock:^(NSObject *dic) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [CustomAlertView hideAlertView];
                    if ([dic isKindOfClass:[NSString class]]) {
                        UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:(NSString *)dic preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [v addAction:active];
                        [self presentViewController:v animated:YES completion:^{
                            
                        }];
                    }else{
                        UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [v addAction:active];
                        [self presentViewController:v animated:YES completion:^{
                            
                        }];
                    }
                });
            }];
        }else{
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"请输入正确的验证码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
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
