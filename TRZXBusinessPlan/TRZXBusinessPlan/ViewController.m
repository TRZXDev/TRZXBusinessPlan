//
//  ViewController.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "KipoMyBusinessPlanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    KipoMyBusinessPlanViewController *bs = [[KipoMyBusinessPlanViewController alloc]init];
    bs.titleStr = @"我的商业计划书";
    [self.navigationController pushViewController:bs animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
