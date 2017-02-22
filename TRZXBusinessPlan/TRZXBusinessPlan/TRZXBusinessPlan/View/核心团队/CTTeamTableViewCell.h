//
//  CTTeamTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTeamTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *positionLable;
@property (weak, nonatomic) IBOutlet UILabel *gufenTitle;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *positionText;

@property (weak, nonatomic) IBOutlet UITextField *gufenText;



@end
