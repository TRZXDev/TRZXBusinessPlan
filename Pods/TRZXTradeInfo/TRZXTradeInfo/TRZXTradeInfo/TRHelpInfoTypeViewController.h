//
//  TRHelpInfoTypeViewController.h
//  TRZX
//
//  Created by Rhino on 16/8/29.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRHelpBaseViewController.h"


typedef NS_ENUM(NSInteger, HelpInfoType) {
    HelpInfoType_Expert,//专家
    HelpInfoType_Shareholder,//企业股东
    HelpInfoType_Invertost,//投资人
    HelpInfoType_Business//商业计划书
};

@protocol TRHelpInfoDelegate <NSObject>

- (void)TRHelpInfoChooseTradeInfo:(NSString *)trade andArray:(NSArray *)tradeArray;

@end

/**
 *  服务行业
 */
@interface TRHelpInfoTypeViewController : TRHelpBaseViewController

@property (nonatomic,weak)id <TRHelpInfoDelegate> delegate;

@property (nonatomic,assign)HelpInfoType type;

@property (nonatomic,strong)NSMutableArray *seletedTrade;

@property (nonatomic,copy)void (^enterButtonClickBlock)(NSArray *array,NSString *string);

@property (nonatomic,copy)NSString *mid;

@end
