//
//  MyBusinessListTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBusinessListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *xuanTianLable;
@property (weak, nonatomic) IBOutlet UILabel *xuanTianStatus;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
