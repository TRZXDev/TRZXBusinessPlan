//
//  CTMediator+TradeInfo.m
//  TRZXTradeInfo
//
//  Created by Rhino on 2017/2/27.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CTMediator+TradeInfo.h"

NSString * const kTradeInfoA = @"TradeInfo";

NSString * const kTradeInfoViewController              = @"TradeInfo_TradeInfoViewController";


@implementation CTMediator (TradeInfo)

- (UIViewController *)selectTradeWithType:(NSInteger)type mid:(NSString *)mid selectedTrade:(NSArray *)selected Complete:(TradeCallBack)complete{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"type"] = [NSString stringWithFormat:@"%ld",type];
    params[@"mid"] = mid.length>1?mid:@"22";
    params[@"selected"] = selected;
    params[@"callBack"] = complete;
    return [self performTarget:kTradeInfoA action:kTradeInfoViewController params:params shouldCacheTarget:NO];
}

@end
