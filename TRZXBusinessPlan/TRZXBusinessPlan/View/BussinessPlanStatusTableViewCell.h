//
//  BussinessPlanStatusTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  流水状态
 */
@interface BussinessPlanStatusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *yesWater;

@property (weak, nonatomic) IBOutlet UIButton *noneWater;

@property (nonatomic,copy)void (^clickStatusBlock)(NSString *);
@end
