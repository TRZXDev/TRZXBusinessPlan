//
//  CTMediator+TradeInfo.h
//  TRZXTradeInfo
//
//  Created by Rhino on 2017/2/27.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CTMediator.h"
#import <UIKit/UIKit.h>


typedef void (^TradeCallBack) (NSArray *,NSString *);

@interface CTMediator (TradeInfo)

- (UIViewController *)selectTradeWithType:(NSInteger)type mid:(NSString *)mid selectedTrade:(NSArray *)selected Complete:(TradeCallBack)complete;

@end
