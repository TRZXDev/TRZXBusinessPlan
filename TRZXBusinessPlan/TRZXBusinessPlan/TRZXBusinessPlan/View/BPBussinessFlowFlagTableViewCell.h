//
//  BPBussinessFlowFlagTableViewCell.h
//  tourongzhuanjia
//
//  Created by Rhino on 16/5/21.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPBussinessFlowFlagTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *flowMoneyText;
@property (weak, nonatomic) IBOutlet UIButton *no;
@property (weak, nonatomic) IBOutlet UIButton *yes;
@property (weak, nonatomic) IBOutlet UITextField *glowMoneyTF;
@property (weak, nonatomic) IBOutlet UILabel *titles1;
@property (weak, nonatomic) IBOutlet UILabel *titles2;
@property (weak, nonatomic) IBOutlet UILabel *titles3;

@property (weak, nonatomic) IBOutlet UILabel *danwei;

@property (nonatomic,copy)void (^flowStatusBlock)(NSString *);

- (IBAction)btn:(id)sender;
- (IBAction)yes:(id)sender;

@end
