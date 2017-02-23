//
//  ProjectProgressViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//



/**
 *  项目进展
 */
#import "BPBaseViewController.h"

@class NewBPProjectProgressModel;

@interface ProjectProgressViewController : BPBaseViewController


@property (nonatomic,strong)NewBPProjectProgressModel *model;

@property (nonatomic,copy)void (^saveSuccessPP)(NSString *complete);

@property (nonatomic,strong)NSMutableArray *projectMsg;//项目里程碑

@end
