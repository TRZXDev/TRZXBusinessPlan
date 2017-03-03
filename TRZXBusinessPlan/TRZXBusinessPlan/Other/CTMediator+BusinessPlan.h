//
//  CTMediator+BusinessPlan.h
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/3/3.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

@interface CTMediator (BusinessPlan)


/**
 后台上传

 @param parms ..
 @return ..
 */
- (UIViewController *)TRZXBusinessPlan_TRZXFinalBusinessViewController:(NSDictionary *)parms;

/**
 预览

 @param parms ..
 @return ..
 */
- (UIViewController *)TRZXBusinessPlan_KipoMyBusinessPlanViewController:(NSDictionary *)parms;

- (UIViewController *)TRZXBusinessPlan_TRZXHaveBusinessPlanController:(NSDictionary *)parms;

@end
