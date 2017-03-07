//
//  BPBaseViewController.h
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPBaseViewController : UIViewController

@property (strong, nonatomic)UIButton *backBtn;
@property (strong, nonatomic)UIButton *saveBtn;

- (void)backAction;
- (void)saveAction:(UIButton *)btn;

- (void)setlLeftNavigation:(NSString *)title;
- (void)setRightNavigation:(NSString *)title;

@end
