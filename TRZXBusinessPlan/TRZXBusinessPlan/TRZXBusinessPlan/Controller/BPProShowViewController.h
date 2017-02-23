//
//  BPProShowViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//


#import "BPBaseViewController.h"
/**
 *  项目里程碑
 */
@interface BPProShowViewController : BPBaseViewController

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,copy)void (^saveModleBlock)(NSMutableArray *);

@end
