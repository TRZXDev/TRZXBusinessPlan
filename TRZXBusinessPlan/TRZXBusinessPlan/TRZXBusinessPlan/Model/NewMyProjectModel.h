//
//  NewMyProjectModel.h
//  tourongzhuanjia
//
//  Created by 投融在线 on 16/3/1.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TeamList,DynamicList,ProjectHighlight,BeforeFinancingList;

@interface NewMyProjectModel : NSObject<NSCoding>

//项目名称
@property (nonatomic, copy) NSString *name;
//项目优势
@property (nonatomic, copy) NSString *advantage;

//公司介绍
@property (nonatomic, copy) NSString *companyAbs;
//项目来源
@property (nonatomic, copy) NSString *exchangeName;

//创始人姓名
@property (nonatomic, copy) NSString *authorName;
//创始人简介
@property (nonatomic, copy) NSString *authorAbs;

@property (nonatomic, copy) NSString *praiseFlag;

@property (nonatomic, copy) NSString *collectFlag;

//审核状态
@property (nonatomic, copy) NSString *auditStatus;

@property (nonatomic, copy) NSString *auditOpinion;

@property (nonatomic, copy) NSString * tradeInfo;
/**
 *  公司名字
 */
@property (nonatomic) NSString *companyName;
/**
 *  公司地址
 */
@property (nonatomic, copy) NSString *companyAddress;


//logo
@property (nonatomic, copy) NSString *logo;
///我的商业企划书
@property (nonatomic, copy) NSString *businessPlan;

@property (nonatomic, copy) NSString *mid;

/**
 *  过往融资经历
 */
@property (nonatomic, strong)NSArray<BeforeFinancingList *> *beforeFinancingList;

@property (nonatomic, copy) NSString *projectImg;
@property (nonatomic, copy) NSString *totalAmount;
// 地区名字
@property (nonatomic, copy) NSString *areaName;
// 状态
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *pRoadShowUri;
/**
 *  项目开始时间
 */
@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *pRoadShowUriFlag;

@property (nonatomic, copy) NSString *isRemind;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *auditFinancing;

@property (nonatomic, copy) NSString *dataModelType;

@property (nonatomic, copy) NSString *createById;
/**
 *  一句话简介
 */
@property (nonatomic, copy) NSString *briefIntroduction;
/**
 *  项目亮点
 */
@property (nonatomic, strong) ProjectHighlight *projectHighlight;

/**
 *  融资优势
 */
@property (nonatomic, copy) NSString *financingAdvantage;

/**
 *  团队概况
 */
@property (nonatomic, copy) NSString *teamAdvantage;

/**
 *  未来规划
 */
@property (nonatomic, copy) NSString *futurePlanning;

/**
 *  产品未来
 */
@property (nonatomic, copy) NSString *productsFuture;

/**
 *  项目简介
 */
@property (nonatomic, copy) NSString *projectAbs;

/**
 *  业务数据
 */
@property (nonatomic, copy) NSString *businessData;

/**
 *   市场规模
 */
@property (nonatomic, copy) NSString *marketSize;

/**
 *  团队列表
 */
@property (nonatomic, strong)NSArray <TeamList *> *teamList;

/**
 *  项目动态 list
 */
@property (nonatomic, strong)NSMutableArray <DynamicList *> *dynamicList;


@end


@interface TeamList : NSObject<NSCoding>

/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  职位
 */
@property (nonatomic, copy) NSString *position;
/**
 *  简介
 */
@property (nonatomic, copy) NSString *abstractz;

/**
 *  人物头像
 */
@property (nonatomic ,copy) NSString *photo;

@property (nonatomic ,copy) NSString *maxPhoto;

@property (nonatomic ,copy) NSString *mid;

@property (nonatomic ,copy) NSString *updateDate;

@property (nonatomic ,copy) NSString *remarks;

@property (nonatomic ,copy) NSString *createDate;



@end

/**
 *  项目动态
 */
@interface DynamicList : NSObject<NSCoding>

/**
 * 项目动态时间
 */
@property (nonatomic, copy) NSString *dynamicDate;


@property (nonatomic, copy) NSString *abstractz;

@end

/**
 *  项目亮点
 */
@interface ProjectHighlight : NSObject<NSCoding>


/**
 *  用户痛点
 */
@property (nonatomic, copy) NSString *userPainPoints;

/**
 *  解决方案
 */
@property (nonatomic, copy) NSString *solution;

/**
 *  核心资源
 */
@property (nonatomic, copy) NSString *coreResources;

/**
 *  盈利模式
 */
@property (nonatomic, copy) NSString *profitModel;

/**
 *  市场现状
 */
@property (nonatomic, copy) NSString *marketStatus;

/**
 *  产品分析
 */
@property (nonatomic, copy) NSString *productAnalysis;

/**
 *  市场占比
 */
@property (nonatomic, copy) NSString *marketShare;

/**
 *  优势分析
 */
@property (nonatomic, copy) NSString *advantageAnalysis;

/**
 *  12.31 上一年营业收入
 */
@property (nonatomic, copy) NSString *beforeIncome;

/**
 *  资金用途
 */
@property (nonatomic, copy) NSString *usefunds;

/**
 *  关键技术
 */
@property (nonatomic, copy) NSString *coreTechnology;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *attMainList;

/**
 *  财务服务机构
 */
@property (nonatomic, copy) NSString *financeFacilitatingAgency;

/**
 *  法律服务机构
 */
@property (nonatomic, copy) NSString *lawFacilitatingAgency;
///  服务机构
@property (nonatomic, copy) NSString *facilitatingAgency;

@end


