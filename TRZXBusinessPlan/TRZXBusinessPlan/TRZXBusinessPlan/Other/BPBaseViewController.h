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
@property (strong, nonatomic)UIView   *navigationView;
@property (strong, nonatomic)UILabel *mainTitle;
@property (strong, nonatomic)UIButton *saveBtn;
@property (strong, nonatomic)UIImageView *bgdImage;
@property (strong, nonatomic)UILabel * lab;


- (void)backAction;
-(void)saveAction;

@end
