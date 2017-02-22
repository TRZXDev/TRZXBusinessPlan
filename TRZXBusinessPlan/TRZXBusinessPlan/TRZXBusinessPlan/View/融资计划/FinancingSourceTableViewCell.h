//
//  FinancingSourceTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinancingSourceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *third;
@property (weak, nonatomic) IBOutlet UITextField *userCount;//用户数量
@property (weak, nonatomic) IBOutlet UITextField *guQuan;//出让股权
@property (weak, nonatomic) IBOutlet UITextField *timeLable;//使用周期
@property (weak, nonatomic) IBOutlet UILabel *stageLable;

@property (weak, nonatomic) IBOutlet UIView *FourView;

@property (weak, nonatomic) IBOutlet UILabel *title1;

@property (weak, nonatomic) IBOutlet UILabel *title2;

@property (weak, nonatomic) IBOutlet UILabel *title3;

@property (weak, nonatomic) IBOutlet UILabel *title4;





@end
