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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
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
    [self setlLeftNavigation:@"返回"];
    [self setRightNavigation:@"保存"];
}

- (void)setlLeftNavigation:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame= CGRectMake(0, 0, 40, 44);
    [btn setTitle:title  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.backBtn = btn;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}

- (void)setRightNavigation:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame= CGRectMake(0, 0, 60, 44);
    [btn setTitle:title  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    self.saveBtn = btn;
    [btn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];

}
- (void)backAction{
    
//    [LCProgressHUD hide];
    [self.navigationController popViewControllerAnimated:true];
}

-(void)saveAction:(UIButton *)btn{
    
    
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
