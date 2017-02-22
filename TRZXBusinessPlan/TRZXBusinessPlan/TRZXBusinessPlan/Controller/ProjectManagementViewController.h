//
//  ProjectManagementViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPBaseViewController.h"

/**
 *  项目概述
 */
@class NewBPProjectAbsModel;

@interface ProjectManagementViewController : BPBaseViewController

@property (nonatomic,strong)NewBPProjectAbsModel *model;

@property (nonatomic,copy)void (^saveSuccessPM)();

@property (nonatomic,strong)NSArray *dataArr;//领域数组

@end
