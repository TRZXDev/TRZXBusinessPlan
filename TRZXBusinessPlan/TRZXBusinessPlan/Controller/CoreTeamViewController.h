//
//  CoreTeamViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//


#import "BPBaseViewController.h"
/**
 *  核心团队
 */
@class NewBPCoreTeamModel;

@interface CoreTeamViewController : BPBaseViewController

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NewBPCoreTeamModel *model;

@property (nonatomic,copy)void (^saveCTBlock)();


@end
