//
//  BusinessSimulationViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//


#import "BPBaseViewController.h"

/**
 *  商业模式 已添加记忆功能 图片未添加
 */

@class NewBPBusinessModel;

@interface BusinessSimulationViewController : BPBaseViewController


@property (nonatomic,strong)NewBPBusinessModel *model;

@property (nonatomic,copy)void (^saveBMBlock)(NSString *);

@property (nonatomic,strong)NSMutableArray *photoArray;

@property (nonatomic,strong)NSArray *photoUrlArray;

@end
