//
//  QRCodeGenerateVC.m
//  SGQRCodeExample
//
//  Created by kingsic on 16/8/25.
//  Copyright © 2016年 kingsic. All rights reserved.
//

#import "QRCodeGenerateVC.h"
#import "UIImageView+WebCache.h"
#import "SGQRCode.h"

@interface QRCodeGenerateVC ()

@end

@implementation QRCodeGenerateVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BLUE_BACKGROUND_COLOR;
    
    // 生成二维码(Default)
//    [self setupGenerateQRCode];
    
    // 生成二维码(中间带有图标)
    [self setupGenerate_Icon_QRCode];
    
    // 生成二维码(彩色)
//    [self setupGenerate_Color_QRCode];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 22, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"btn_back_gray.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = TEXT_COLOR;
    titleLabel.center = CGPointMake(CURRENT_BOUNDS.width/2, 42);
    titleLabel.text = @"我的二维码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
}

- (void)leftBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"..");
}

// 生成二维码
- (void)setupGenerateQRCode {

    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 250;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 80;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    
    // 2、将CIImage转换成UIImage，并放大显示
    imageView.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://github.com/kingsic" imageViewWidth:imageViewW];
    
#pragma mark - - - 模仿支付宝二维码样式（添加用户头像）
    CGFloat scale = 0.22;
    CGFloat borderW = 5;
    UIView *borderView = [[UIView alloc] init];
    CGFloat borderViewW = imageViewW * scale;
    CGFloat borderViewH = imageViewH * scale;
    CGFloat borderViewX = 0.5 * (imageViewW - borderViewW);
    CGFloat borderViewY = 0.5 * (imageViewH - borderViewH);
    borderView.frame = CGRectMake(borderViewX, borderViewY, borderViewW, borderViewH);
    borderView.layer.borderWidth = borderW;
    borderView.layer.borderColor = [UIColor purpleColor].CGColor;
    borderView.layer.cornerRadius = 10;
    borderView.layer.masksToBounds = YES;
    borderView.layer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;

//    [imageView addSubview:borderView];
}

#pragma mark - - - 中间带有图标二维码生成
- (void)setupGenerate_Icon_QRCode {
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width-50, CURRENT_BOUNDS.height-155-32)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    bgView.center = CGPointMake(CURRENT_BOUNDS.width/2, CURRENT_BOUNDS.height/2+32);
    [self.view addSubview:bgView];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, 45, 45)];
    logoImageView.image = [UIImage imageNamed:@"bg_personal_defaultavatar"];
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius = 45/2;
    NSData *image = [userDic objectForKey:@"userLogoImage"];
    if (image && [image isKindOfClass:[NSData class]]) {
       
        logoImageView.image = [UIImage imageWithData:image];
        
    }else{
        [logoImageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)image] placeholderImage:[UIImage imageNamed:@"bg_personal_defaultavatar"]];
    }
    [bgView addSubview:logoImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame)+25/2, 16, bgView.frame.size.width-100, 17)];
    nameLabel.textColor = TEXT_COLOR;
    nameLabel.text = [userDic objectForKey:@"userName"];
    nameLabel.font = [UIFont systemFontOfSize:17];
    [bgView addSubview:nameLabel];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame)+25/2, CGRectGetMaxY(nameLabel.frame)+6, nameLabel.frame.size.width, 13)];
    locationLabel.textColor = UNMAIN_TEXT_COLOR;
    locationLabel.font = [UIFont systemFontOfSize:13];
    locationLabel.text = [userDic objectForKey:@"address"];
    [bgView addSubview:locationLabel];
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = CURRENT_BOUNDS.width-100;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 80;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.center = CGPointMake(bgView.frame.size.width/2, bgView.frame.size.height/2);
    [bgView addSubview:imageView];
    
    CGFloat scale = 0.2;
    
    
    // 2、将最终合得的图片显示在UIImageView上
    imageView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:userId logoImageName:@"" logoScaleToSuperView:scale];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, 14)];
    showLabel.font = [UIFont systemFontOfSize:14];
    showLabel.textColor = UNMAIN_TEXT_COLOR;
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.text = @"扫描上面的二维码，完成学车打卡";
    showLabel.center = CGPointMake(bgView.frame.size.width/2, bgView.frame.size.height -(bgView.frame.size.height-CGRectGetMaxY(imageView.frame))/2);
    [bgView addSubview:showLabel];
    
}

#pragma mark - - - 彩色图标二维码生成
- (void)setupGenerate_Color_QRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 400;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    // 2、将二维码显示在UIImageView上
    imageView.image = [SGQRCodeGenerateManager generateWithColorQRCodeData:@"https://github.com/kingsic" backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8] mainColor:[CIColor colorWithRed:0.3 green:0.2 blue:0.4]];
}


@end

