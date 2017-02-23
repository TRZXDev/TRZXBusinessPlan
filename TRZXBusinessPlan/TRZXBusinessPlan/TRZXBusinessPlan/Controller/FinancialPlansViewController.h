//
//  FinancialPlansViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//


#import "BPBaseViewController.h"

@class NewBPMoneyPlanModel;

/**
 *  融资计划 已添加记忆功能
 */

@interface FinancialPlansViewController : BPBaseViewController

@property (nonatomic,strong)NewBPMoneyPlanModel *model;

@property (nonatomic,copy)void (^saveFPBlock)();

@end
