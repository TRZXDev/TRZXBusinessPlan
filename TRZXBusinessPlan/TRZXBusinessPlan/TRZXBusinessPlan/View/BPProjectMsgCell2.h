//
//  ProjectMsgCell2.h
//  tourongzhuanjia
//
//  Created by 移动微 on 16/4/18.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPProjectMsgCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,copy)NSString *stratDateStr;

@property(nonatomic,copy)void (^dateButtonClick)();

@end
