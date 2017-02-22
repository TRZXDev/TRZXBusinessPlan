//
//  BusinessMemoryCacheTool.m
//  TRZX
//
//  Created by Rhino on 2016/9/27.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "BusinessMemoryCacheTool.h"
#import "lableMonle.h"
#import "NewMyProjectModel.h"
#import "TRZXBusinessPlanHeader.h"

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

@interface BusinessMemoryCacheTool()


@end

@implementation BusinessMemoryCacheTool

#pragma mark --- key
//项目概述
static NSString* projectAbsKey = @"ProjectAbs";
//市场分析
static NSString* marketAnalysisKey = @"MarketAnalysis";
//商业模式
static NSString* businessKey = @"Business";
//商业模式图片
static NSString* businessPicKey = @"BusinessPics";
//项目进展
static NSString* projectProgressKey = @"ProjectProgress";
//核心团队
static NSString* coreTeamKey = @"CoreTeam";
//融资计划
static NSString* financialPlansKey = @"FinancialPlans";
//行业领域
static NSString* tradesKey = @"tradesInfo";
//团队成员
static NSString* teamMembersKey = @"teamMembers";
//项目里程碑一条新事件
static NSString* projectProgressEventKey = @"projectProgressEvent";
//项目里程碑
static NSString* projectProgressAllEventKey = @"projectProgressAllEvent";

#pragma mark - 获取本地存储数据
//项目概述
+(NSDictionary *)ProjectAbs{
    return [USER_DEFAULT objectForKey:projectAbsKey];
}

//市场分析
+(NSDictionary *) MarketAnalysis{
    return [USER_DEFAULT objectForKey:marketAnalysisKey];
}
//商业模式
+(NSDictionary *) Business{
    return [USER_DEFAULT objectForKey:businessKey];
}

//商业模式图片
+(NSArray *) PicPlans{
    return [USER_DEFAULT objectForKey:businessPicKey];
}
//项目进展

+(NSDictionary *) ProjectProgress{
    return [USER_DEFAULT objectForKey:projectProgressKey];
}
//核心团队
+(NSDictionary *) CoreTeam{
    return [USER_DEFAULT objectForKey:coreTeamKey];
}

//融资计划
+(NSDictionary *) FinancialPlans{
    return [USER_DEFAULT objectForKey:financialPlansKey];
}

//行业领域
+(NSArray *)tradeinfos{
    NSArray *array = [USER_DEFAULT objectForKey:tradesKey];
    NSArray *arrayModle = [lableMonle mj_objectArrayWithKeyValuesArray:array];
    return arrayModle;
}
//团队成员
+(NSDictionary *) teamMembers{
    return [USER_DEFAULT objectForKey:teamMembersKey];
}

//项目里程碑一条新事件
+(NSDictionary *) ProjectProgressEvent{
    return [USER_DEFAULT objectForKey:projectProgressEventKey];
}
//项目里程碑
+(NSMutableArray *) ProjectProgressAllEvent{
    NSArray *array = [USER_DEFAULT objectForKey:projectProgressAllEventKey];
    NSArray *arrayModle = [DynamicList mj_objectArrayWithKeyValuesArray:array];
    NSMutableArray *arrayMutable = [[NSMutableArray alloc]init];
    [arrayMutable addObjectsFromArray:arrayModle];
    return arrayMutable;
}

#pragma mark - 写入本地数据
///////存储
//项目概述
+(void)memoryCacheProjectAbsWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:projectAbsKey];
}
//市场分析
+(void)memoryCacheMarketAnalysisWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:marketAnalysisKey];
}
//商业模式
+(void)memoryCacheBusinessWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:businessKey];
}

//商业模式图片
+(void)memoryPicWithDict:(NSMutableArray *)Arr{
 
    NSMutableArray *tempLikes = [NSMutableArray new];
    NSData *data;
    for (UIImage *image in Arr) {
        data = UIImagePNGRepresentation(image);
        [tempLikes addObject:data];
    }

    [USER_DEFAULT setObject:tempLikes forKey:businessPicKey];
}
//项目进展
+(void)memoryCacheProjectProgressWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:projectProgressKey];
}
//核心团队
+(void)memoryCacheCoreTeamWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:coreTeamKey];
}

//融资计划
+(void)memoryCacheFinancialPlansWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:financialPlansKey];
}

//行业领域
+(void)memoryCacheProjectAbsTradeinfos:(NSArray *)array{
    //数组里面装的是对象,需转化为字典
    NSArray *arrayDict = [lableMonle mj_keyValuesArrayWithObjectArray:array];
    [USER_DEFAULT setObject:arrayDict forKey:tradesKey];
}

//团队成员
+(void)memoryCacheTeamMembersWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:teamMembersKey];
}

//项目里程碑单条事件
+(void)memoryCacheProjectProgressEventWithDict:(NSDictionary *)dict{
    [USER_DEFAULT setObject:dict forKey:projectProgressEventKey];
}

//项目里程碑所有事件
+(void)memoryCacheProjectProgressALLEventArray:(NSArray *)array{
    //数组里面装的是对象,需转化为字典
    NSArray *arrayDict = [DynamicList mj_keyValuesArrayWithObjectArray:array];
    [USER_DEFAULT setObject:arrayDict forKey:projectProgressAllEventKey];
}

#pragma mark - cleanMemory
//清除所有缓存
+(void)cleanAllCache{
    
    [USER_DEFAULT setObject:nil forKey:projectAbsKey];
    [USER_DEFAULT setObject:nil forKey:marketAnalysisKey];
    [USER_DEFAULT setObject:nil forKey:businessKey];
    [USER_DEFAULT setObject:nil forKey:projectProgressKey];
    [USER_DEFAULT setObject:nil forKey:businessPicKey];
    [USER_DEFAULT setObject:nil forKey:coreTeamKey];
    [USER_DEFAULT setObject:nil forKey:financialPlansKey];
    [USER_DEFAULT setObject:nil forKey:tradesKey];
    [USER_DEFAULT setObject:nil forKey:teamMembersKey];
    [USER_DEFAULT setObject:nil forKey:projectProgressEventKey];
    [USER_DEFAULT setObject:nil forKey:projectProgressAllEventKey];
}

//用于保存成功清除本地成员数据
+ (void)cleanTeamMembersCache{
    [USER_DEFAULT setObject:nil forKey:teamMembersKey];
}

//清除项目里程碑单条事件
+ (void)cleanProjectProgressEventCache{
    [USER_DEFAULT setObject:nil forKey:projectProgressEventKey];
}

//清除项目里程碑
+ (void)cleanProjectProgressEventAllCache{
    [USER_DEFAULT setObject:nil forKey:projectProgressAllEventKey];
}


@end
