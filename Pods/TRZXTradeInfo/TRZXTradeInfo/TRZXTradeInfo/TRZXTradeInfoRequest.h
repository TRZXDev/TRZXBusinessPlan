//
//  TRZXTradeInfoRequest.h
//  TRZXTradeInfo
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZXTradeInfoRequest : NSObject


//服务行业
+(void)getTradeInfo:(NSString *)str  Success:(void (^)(id ))success  failure:(void (^)(NSError *))failure;

+(void)getTZRguanzhubaocunDataTradeIds:(NSMutableString*)TradeIds TypeStr:(NSString *)typeStr
                              AuthType:(NSString *)authTypeStr OrgId:(NSString *)orgId Success:(void (^)(id ))success  failure:(void (^)(NSError *))failure;

@end
