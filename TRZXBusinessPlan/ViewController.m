//
//  ViewController.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "KipoMyBusinessPlanViewController.h"
#define UIColorFromRGB(rgbValue)            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    KipoMyBusinessPlanViewController *bs = [[KipoMyBusinessPlanViewController alloc]init];
    bs.titleStr = @"我的商业计划书";
    [self.navigationController pushViewController:bs animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
