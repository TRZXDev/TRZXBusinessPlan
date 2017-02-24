//
//  BusinessMemoryCacheTool.h
//  TRZX
//
//  Created by Rhino on 2016/9/27.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessMemoryCacheTool : NSObject

//======***********************************读取数据***************************************===========

+(NSDictionary *) ProjectAbs;//项目概述
+(NSDictionary *) MarketAnalysis;//市场分析
+(NSDictionary *) Business;//商业模式
+(NSDictionary *) ProjectProgress;//项目进展
+(NSDictionary *) CoreTeam;//核心团队
+(NSDictionary *) FinancialPlans;//融资计划

+(NSMutableArray *) PicPlans;//商业模式图片

+(NSArray *)tradeinfos;//行业领域
+(NSDictionary *) teamMembers;//团队成员
+(NSDictionary *) ProjectProgressEvent;//项目里程碑一条新事件
+(NSMutableArray *) ProjectProgressAllEvent;//项目里程碑

//======***********************************缓存数据***************************************===========

//项目概述
+(void)memoryCacheProjectAbsWithDict:(NSDictionary *)dict;
//市场分析
+(void)memoryCacheMarketAnalysisWithDict:(NSDictionary *)dict;
//商业模式
+(void)memoryCacheBusinessWithDict:(NSDictionary *)dict;
//项目进展
+(void)memoryCacheProjectProgressWithDict:(NSDictionary *)dict;
//核心团队
+(void)memoryCacheCoreTeamWithDict:(NSDictionary *)dict;
//融资计划
+(void)memoryCacheFinancialPlansWithDict:(NSDictionary *)dict;

//行业领域
+(void)memoryCacheProjectAbsTradeinfos:(NSArray *)array;

//团队成员
+(void)memoryCacheTeamMembersWithDict:(NSDictionary *)dict;

//项目里程碑单条事件
+(void)memoryCacheProjectProgressEventWithDict:(NSDictionary *)dict;

//项目里程碑所有事件
+(void)memoryCacheProjectProgressALLEventArray:(NSArray *)array;

//商业模式图片
+(void)memoryPicWithDict:(NSArray *)Arr;

//======***********************************清除数据***************************************===========

//清除所有缓存
+(void)cleanAllCache;

//清除本地成员数据 保存成功时调用
+ (void)cleanTeamMembersCache;

//清除项目里程碑单条事件
+ (void)cleanProjectProgressEventCache;

//清除项目里程碑
+ (void)cleanProjectProgressEventAllCache;

@end
