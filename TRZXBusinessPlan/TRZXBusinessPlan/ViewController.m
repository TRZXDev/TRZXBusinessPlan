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
//
//
//
//    NSString *str = @"#C6AE5F";
//    self.view.backgroundColor = UIColorFromRGB([self color:str]);
}

//- (unsigned long)changeColor:(NSString *)color{
//    if (![color hasPrefix:@"#"]) {
//        return 0xffffff;
//    }
//    NSMutableString *colorStr = [[NSMutableString alloc]initWithString:color];
//    [colorStr replaceCharactersInRange:NSMakeRange(0, 1) withString:@"0x"];
//    //先以16为参数告诉strtoul字符串参数表示16进制数字，然后使用0x%X转为数字类型
//    unsigned long colorHex = strtoul([colorStr UTF8String],0,16);
//    NSLog(@"转换完的数字为：%lx",colorHex);
//    return colorHex;
//}

//- (NSUInteger)color:(NSString *)color{
//    if (![color hasPrefix:@"#"]) {
//        return 0xffffff;
//    }
//    NSMutableString *colorStr = [[NSMutableString alloc]initWithString:color];
//    [colorStr replaceCharactersInRange:NSMakeRange(0, 1) withString:@"0x"];
//    
//    NSUInteger inouts  = 0;
//    [[NSScanner scannerWithString:colorStr] scanHexInt:&inouts];
//    NSLog(@"%lu",inouts);
//    return inouts;
//}

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
