//
//  Target_TradeInfo.m
//  TRZXTradeInfo
//
//  Created by Rhino on 2017/2/27.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "Target_TradeInfo.h"
#import "TRHelpInfoTypeViewController.h"

@implementation Target_TradeInfo


- (UIViewController *)Action_TradeInfo_TradeInfoViewController:(NSDictionary *)params{
    TRHelpInfoTypeViewController *info = [[TRHelpInfoTypeViewController alloc]init];
    info.type = [params[@"type"] integerValue];
    info.mid = params[@"mid"];
    info.seletedTrade = [[NSMutableArray alloc]initWithArray:params[@"selected"]];
    info.enterButtonClickBlock = params[@"callBack"];
    return info;
}


@end
