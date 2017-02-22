//
//  KipoMyBusinessPlanViewModel.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "KipoMyBusinessPlanViewModel.h"

#import "NewBPMarketAnalysisModel.h"
#import "NewBPBusinessModel.h"
#import "NewBPProjectProgressModel.h"
#import "NewBPMoneyPlanModel.h"
#import "NewBPCoreTeamModel.h"
#import "NewBPTeamMemberModel.h"
//#import "LivePreviewModel.h"

@implementation KipoMyBusinessPlanViewModel

//项目概述
+ (void)addProjectManagementDataMID:(NSString*)mid planName:(NSString *)planName num:(NSString *)num creatData:(NSString *)creatData tradeIds:(NSString *)tradeIds success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSDictionary *param = @{
                            @"apiType":@"addAbs",
                            @"requestType":@"Business_Plan_Api",
                            @"planName":planName,
                            @"num":num,
                            @"creatData":creatData,
                            @"tradeIds":tradeIds,
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
    
}
//市场分析
+ (void)addMarketAnalysisDataMID:(NSString*)mid modelData:(NewBPMarketAnalysisModel *)model success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"analyse",
                            @"requestType":@"Business_Plan_Api",
                            @"mid":mid==nil?@"":mid,
                            @"targetUser":model.targetUser,//目标用户  必填
                            @"badpoint":model.badpoint,//用户痛点  必填
                            @"totalPeople":model.totalPeople,//用户总量 必填
                            @"totalConsumption":model.totalConsumption,//消费总额  必填
                            @"development":model.development,//发展前景  必填
                            @"competeOne":model.competeOne,//竞争同行1
                            @"competeTwo":model.competeTwo,//竞争同行2
                            @"advantage":model.advantage, //我们优势
                            };
    
    
//    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
    
}
//商业模式  //最多五张图片
+ (void)addbusinessModelDataMID:(NSString*)mid modelData:(NewBPBusinessModel *)model imageData:(NSArray*)imageData success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
   
    
//    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
//    for (UIImage *img  in imageData) {
//
//        
//        UIImage *image = [img kipo_normalizedImage];
//       [imageArray addObject:[image kipo_dataCompress]];
//        
//    }
//
//    NSDictionary *param = @{
//                            @"apiType":@"businessModel",
//                            @"requestType":@"Business_Plan_Api",
//                            @"productType":model.productType?model.productType:@"",//产品类型
//                            @"function":model.function?model.function:@"",//功能服务
//                            @"market":model.market?model.market:@"",//市场定位
//                            @"gain":model.gain?model.gain:@"",//盈利模式
//                            @"flow":model.flow?model.flow:@"",//是否有流水  1 有 0 没有
//                            @"money":model.money?model.money:@"",//每月流水
//                            @"gainFlag":model.gainFlag?model.gainFlag:@"",//盈利状况  0为盈利  1已盈利
//                            @"gainMoney":model.gainMoney?model.gainMoney:@"",//每月营业
//                            @"channel":model.channel?model.channel:@"",//推广渠道
//                            @"strategy":model.strategy?model.strategy:@"", //推广策略
//                            @"risk":model.risk?model.risk:@"",//风险预测
//                            @"control":model.control?model.control:@"机动"//控制策略
//                            };
//    
//    
//    
//    
//    
//    
//    
//
//    AFHTTPSessionManager *_manager = [AFHTTPSessionManager manager];
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                               @"text/html",
//                                                                               @"text/json",
//                                                                               @"text/plain",
//                                                                               @"text/javascript",
//                                                                               @"text/xml",
//                                                                               @"image/*"]];
//    
//    
//    [_manager POST:[KipoServerConfig serverURL] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        for (int i = 0; i<imageArray.count; i++) {
//            NSData *data = imageArray[i];
//            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"file%d",i+1] fileName:[NSString stringWithFormat:@"image.png"] mimeType:@"image/*"];
//        }
//        
//        
//    } success:^(NSURLSessionTask *operation, id responseObject) {
//
//        success(responseObject);
//        
//        
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//
//        success(error);
//        
//    }];
    
}

//图片处理，图片压缩
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回已变图片
}

//处理直接拍照上传照片 图片翻转的问题
//+ (UIImage *)normalizedImage:(UIImage *)image
//{
//    if (image.imageOrientation == UIImageOrientationUp) return image;
//    
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
//    [image drawInRect:(CGRect){0, 0, image.size}];
//    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return normalizedImage;
//}


//项目进展
+ (void)addProgressModelDataMID:(NSString *)mid modelData:(NewBPProjectProgressModel *)model success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"progress",
                            @"requestType":@"Business_Plan_Api",
                            @"progress":model.progress,// 进度  planning"规划中 "development"开发中 "finalize"/定型 "havecustomer"有客户
                            @"total":model.total, // 用户数量
                            @"active":model.active,// 日活跃量
                            @"monthlynumber":model.monthlynumber,// 月销售量
                            @"monthlTotal":model.monthlTotal,//月营业额
                            @"monthlySales":model.monthlySales,  // 月利润
                            @"numberOfStores":model.numberOfStores,  // 门店数量
                            @"marketShare":model.marketShare, // 市场份额
                            @"businessDevelopment":model.businessDevelopment// 业务拓展
                           
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
    
}

//核心团队
+ (void)addCoreTeamDataMID:(NSString*)mid modelData:(NewBPCoreTeamModel *)model image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"team",
                            @"requestType":@"Business_Plan_Api",
                            @"slogan":model.slogan,//团队口号
                            };
    
//    [LCProgressHUD showLoading:@"正在上传"];   // 显示等待
//    
//    
//    
//    
//    
//    
//    AFHTTPSessionManager *_manager = [AFHTTPSessionManager manager];
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                               @"text/html",
//                                                                               @"text/json",
//                                                                               @"text/plain",
//                                                                               @"text/javascript",
//                                                                               @"text/xml",
//                                                                               @"image/*"]];
//    
//    
//    [_manager POST:[KipoServerConfig serverURL] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        
//        NSData *imageData = UIImagePNGRepresentation(image);
//        
//            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file"] fileName:[NSString stringWithFormat:@"image.png"] mimeType:@"image/*"];
//        
//        
//    } success:^(NSURLSessionTask *operation, id responseObject) {
//        [LCProgressHUD showSuccess:@"上传成功"];   // 显示成功
//
//
//
//        success(responseObject);
//
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        
//        [NSObject showError:error];
//        success(error);
//        
//    }];
    
}


//添加团队成员
+ (void)addTeamMemberDataMID:(NSString*)mid modelData:(NewBPTeamMemberModel *)model image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"teamMemberAdd",
                            @"mid":mid?mid:@"",
                            @"requestType":@"Business_Plan_Api",
                            @"name":model.name,//姓名
                            @"position":model.position,//职位
                            @"holding":model.holding,//所持股份
                            @"school":model.school,//学校
                            @"work":model.work,//工作履历
                            };

//    [LCProgressHUD showLoading:@"正在上传"];   // 显示等待
//
//    
//    AFHTTPSessionManager *_manager = [AFHTTPSessionManager manager];
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                               @"text/html",
//                                                                               @"text/json",
//                                                                               @"text/plain",
//                                                                               @"text/javascript",
//                                                                               @"text/xml",
//                                                                               @"image/*"]];
//    
//    
//    [_manager POST:[KipoServerConfig serverURL] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//         NSData *imageData = UIImagePNGRepresentation(image);
//        [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file"] fileName:[NSString stringWithFormat:@"image.png"] mimeType:@"image/*"];
//        
//    } success:^(NSURLSessionTask *operation, id responseObject) {
//        
//        
//        if ([responseObject[@"status_code"] isEqualToString:@"200"]) {
//            
//            [LCProgressHUD showSuccess:@"上传成功"];   // 显示成功
//
//        } else {
//            [LCProgressHUD showFailure:@"上传失败"];   // 显示失败
//
//        }
//        
//        success(responseObject);
//        
//        
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        [NSObject showError:error];
//
//        success(error);
//        
//    }];
    

    
}

+ (void)deleteTeamMemberDataMID:(NSString*)mid  success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"deleteMember",
                            @"mid":mid?mid:@"",
                            @"requestType":@"Business_Plan_Api"
                            };
    
    
//    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
}

//获取成员列表
+ (void)getListTeamerDataMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"teamMemberAdd",
                            @"requestType":@"Business_Plan_Api"
                            };
        
        
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//                
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
}

//融资计划
+ (void)addMoneyPlanDataMID:(NSString *)mid modelData:(NewBPMoneyPlanModel *)model success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"moneyPlan",
                            @"requestType":@"Business_Plan_Api",
                            @"mid":mid==nil?@"":mid,
                            @"areaStage":model.areaStage,//融资轮次
                            @"num":model.num, // 用户数量
                            @"stockPercentage":model.stockPercentage,//出让股权
                            @"lifeCycle":model.lifeCycle,//使用周期
                            @"expansion":model.expansion,   // 团队扩充
                            @"rent":model.rent,  // 房租水电
                            @"office":model.office, //办公设备
                            @"extension":model.extension, // 运营推广
                            @"product":model.product,//产品研发
                            @"market":model.market, //市场推广
                                @"target":model.target,//战略目标
                                @"strategy":model.strategy, //策略
                            @"financialForecast":model.financialForecast //财务预测
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
    
}

//生成商业企划书
+ (void)createBusinessPlanMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"generate",
                            @"requestType":@"Business_Plan_Api"
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
    
}


//预览商业计划书
+ (void)lookBusinessPlanSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"prive",
                            @"requestType":@"Business_Plan_Api"
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
    
}

//我的商业企划书详情
+ (void)getBusinessPlanApiDetailDataMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    NSDictionary *param = @{
                            @"apiType":@"info",
                            @"requestType":@"Business_Plan_Api"
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
}

// 查询商业计划书
+ (void)getPlanApiDetailDataMID:(NSString*)mid success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    NSDictionary *param = @{
                            @"apiType":@"getPlan",
                            @"requestType":@"Business_Plan_Api",
                            @"planUser":mid,
                            };
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
}

//保存项目里程碑
+ (void)saveDynamicData:(NSString*)data success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{@"requestType":@"Business_Plan_Api",
                             @"apiType":@"saveDynamic",
                             @"data":data
                            };
    
    
    
    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];

}


+ (void)clearBusinessSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    NSDictionary *param = @{@"requestType":@"Business_Plan_Api",
                            @"apiType":@"clearn"
                            };
    
    
    
//    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
}


+ (void)fixBusinessSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{@"requestType":@"Business_Plan_Api",
                            @"apiType":@"fix"
                            };
    
    
    
//    
//    [KipoNetworking post:[KipoServerConfig serverURL] params:param success:^(id json) {
//        
//        
//        
//        success(json);
//        
//    } failure:^(NSError *error) {
//        
//        
//        failure(error);
//        
//    }];
}
@end
