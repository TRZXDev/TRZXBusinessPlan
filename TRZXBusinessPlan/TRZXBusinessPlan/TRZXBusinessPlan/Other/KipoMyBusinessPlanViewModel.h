//
//  KipoMyBusinessPlanViewModel.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  我的商业计划书
 */
@class NewBPMarketAnalysisModel;
@class NewBPBusinessModel;
@class NewBPProjectProgressModel;
@class NewBPMoneyPlanModel;
@class NewBPCoreTeamModel;
@class NewBPTeamMemberModel;


@interface KipoMyBusinessPlanViewModel : NSObject


/**
 *  添加项目概述
 *
 *  @param mid       mid
 *  @param planName  商业计划书项目名
 *  @param num       团队人数
 *  @param creatData 创建时间
 *  @param tradeIds  行业领域ID 用","分割
 *  @param success ..
 *  @param failure   ..
 */
+ (void)addProjectManagementDataMID:(NSString*)mid planName:(NSString *)planName num:(NSString *)num creatData:(NSString *)creatData tradeIds:(NSString *)tradeIds success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  市场分析
 *
 *  @param mid     mid
 *  @param model  模型
 *  @param success /
 *  @param failure /
 */
+ (void)addMarketAnalysisDataMID:(NSString*)mid modelData:(NewBPMarketAnalysisModel *)model success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  商业模式
 *
 *  @param mid       nil
 *  @param model     model description
 *  @param imageData  数组图片
 *  @param success /
 *  @param failure   failure description
 */
+ (void)addbusinessModelDataMID:(NSString*)mid modelData:(NewBPBusinessModel *)model imageData:(NSArray*)imageData success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  项目进展
 *
 *  @param mid //
 *  @param model ..
 *  @param success ..
 *  @param failure   ..
 */
+ (void)addProgressModelDataMID:(NSString*)mid modelData:(NewBPProjectProgressModel *)model success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  核心团队
 *
 *  @param mid //
 *  @param model //
 *  @param success //
 *  @param failure //
 */
+ (void)addCoreTeamDataMID:(NSString*)mid modelData:(NewBPCoreTeamModel *)model image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  添加团队成员
 *
 *  @param mid //
 *  @param model //
 *  @param success //
 *  @param failure //
 */
+ (void)addTeamMemberDataMID:(NSString*)mid modelData:(NewBPTeamMemberModel *)model image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  删除成员
 *
 *  @param mid //
 *  @param success //
 *  @param failure //
 */
+ (void)deleteTeamMemberDataMID:(NSString*)mid  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  获取成员列表
 *
 *  @param mid //
 *  @param success //
 *  @param failure //
 */
+ (void)getListTeamerDataMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure;



/**
 *  融资计划
 *
 *  @param mid     \
 *  @param model   \
 *  @param success /
 *  @param failure   /
 */
+ (void)addMoneyPlanDataMID:(NSString*)mid modelData:(NewBPMoneyPlanModel *)model success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  生成商业企划书
 *
 *  @param mid /
 *  @param success /
 *  @param failure /
 */
+ (void)createBusinessPlanMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 查询商业计划书
+ (void)getPlanApiDetailDataMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//预览商业计划书
+ (void)lookBusinessPlanSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  商业企划书详情
 *
 *  @param mid /
 *  @param success /
 *  @param failure /
 */
+ (void)getBusinessPlanApiDetailDataMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  项目里程碑
 *
 *  @param data /
 *  @param success /
 *  @param failure /
 */
+ (void)saveDynamicData:(NSString*)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;


+ (void)fixBusinessSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;


+ (void)clearBusinessSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
