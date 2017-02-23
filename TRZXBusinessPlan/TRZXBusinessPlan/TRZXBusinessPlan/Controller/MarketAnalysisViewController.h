//
//  MarketAnalysisViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//


#import "BPBaseViewController.h"
/**
 *  市场分析
 */

@class NewBPMarketAnalysisModel;
@interface MarketAnalysisViewController :BPBaseViewController


@property (nonatomic,strong)NewBPMarketAnalysisModel *model;

@property (nonatomic,copy)void (^saveSuccessMA)(NSString *);


@end
