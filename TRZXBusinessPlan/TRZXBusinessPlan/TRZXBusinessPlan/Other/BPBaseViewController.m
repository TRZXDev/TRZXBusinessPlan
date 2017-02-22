//
//  BPBaseViewController.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "BPBaseViewController.h"
#import "TRZXBusinessPlanHeader.h"

@interface BPBaseViewController ()

@end

@implementation BPBaseViewController

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void)dealloc
{//移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.定制navigationBar
    [self setNavigationBar];
}
#pragma mark - UI
- (void)setNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    _navigationView = [[UIView alloc] init];
    // 设置背景色
    _navigationView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
    // 设置frame
    // 把白色view加到控制器中
    [self.view addSubview:_navigationView];
    [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@(64));
    }];
    _lab = [[UILabel alloc]init];
    _lab.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [_navigationView addSubview:_lab];
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(63.5);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@(0.5));
    }];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_backBtn setImage:[UIImage imageNamed:@"business_back"] forState:UIControlStateNormal];
    _backBtn.adjustsImageWhenHighlighted = NO;
    [_backBtn.layer setCornerRadius:15.0];
    [_backBtn setAdjustsImageWhenHighlighted:NO];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(14,10,12,63);
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1]  forState:UIControlStateNormal];
    _backBtn.titleEdgeInsets = UIEdgeInsetsMake(15,0,11,25);
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_navigationView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.height.equalTo(@(43));
        make.width.equalTo(@(83));
        make.left.equalTo(self.view.mas_left).offset(0);
    }];
    
    
    
    
    
    _mainTitle = [[UILabel alloc] init];
    _mainTitle.font = [UIFont boldSystemFontOfSize:19];
    _mainTitle.textColor = grayKColor;
    //对齐
    _mainTitle.textAlignment = NSTextAlignmentCenter;
    _mainTitle.lineBreakMode = 1;
    _mainTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [_navigationView addSubview:_mainTitle];
    [_mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(25);
        make.height.equalTo(@(30));
        make.left.right.equalTo(@(60));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.hidden = true;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:TRZXMainColor forState:UIControlStateNormal];
    _saveBtn.adjustsImageWhenHighlighted = NO;
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _saveBtn.titleEdgeInsets = UIEdgeInsetsMake(15,0,11,15);
    _saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [_navigationView addSubview:_saveBtn];
    
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@(43));
        make.width.equalTo(@(83));
    }];
    _bgdImage = [[UIImageView alloc]init];
    _bgdImage.image = [UIImage imageNamed:@"列表无内容.png"];
    //    _bgdImage.contentMode =  UIViewContentModeScaleAspectFill;
    _bgdImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    _bgdImage.center = self.view.center;
    [self.view addSubview:_bgdImage];
    _bgdImage.hidden = YES;
}

- (void)backAction{
    
//    [LCProgressHUD hide];
    [self.navigationController popViewControllerAnimated:true];
}

-(void)saveAction{
    
    
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
