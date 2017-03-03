//
//  BPProjectCommentTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/6.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPProjectCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UILabel *topTitle;
@property (weak, nonatomic) IBOutlet UITextField *teamCountLable;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitle;

@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (copy, nonatomic) NSString *stratDateStr;
@property (weak, nonatomic) IBOutlet UILabel *year;

@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *day;

@property (copy, nonatomic) void (^dateButtonClick)();

@end
