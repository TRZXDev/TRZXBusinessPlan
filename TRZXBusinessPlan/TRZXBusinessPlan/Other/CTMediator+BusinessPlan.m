//
//  CTMediator+BusinessPlan.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/3/3.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CTMediator+BusinessPlan.h"

@implementation CTMediator (BusinessPlan)


NSString * const kTRZXBusinessPlanA = @"TRZXBusinessPlan";

NSString * const kTRZXFinalBusinessViewController         = @"TRZXBusinessPlan_TRZXFinalBusinessViewController";
NSString * const kKipoMyBusinessPlanViewController        = @"TRZXBusinessPlan_KipoMyBusinessPlanViewController";
NSString * const kTRZXHaveBusinessPlanController          = @"TRZXBusinessPlan_TRZXHaveBusinessPlanController";


/**
 后台上传
 
 @param parms ..
 @return ..
 */
- (UIViewController *)TRZXBusinessPlan_TRZXFinalBusinessViewController:(NSDictionary *)parms{
    UIViewController *viewController = [self performTarget:kTRZXBusinessPlanA
                                                    action:kTRZXFinalBusinessViewController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

/**
 预览
 
 @param parms ..
 @return ..
 */
- (UIViewController *)TRZXBusinessPlan_KipoMyBusinessPlanViewController:(NSDictionary *)parms{
    UIViewController *viewController = [self performTarget:kTRZXBusinessPlanA
                                                    action:kKipoMyBusinessPlanViewController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (UIViewController *)TRZXBusinessPlan_TRZXHaveBusinessPlanController:(NSDictionary *)parms{
    UIViewController *viewController = [self performTarget:kTRZXBusinessPlanA
                                                    action:kTRZXHaveBusinessPlanController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
