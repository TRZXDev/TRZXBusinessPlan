//
//  Target_BusinessPlan.h
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/3/3.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_BusinessPlan : NSObject



/**
 ..

 @param params ..
 @return ..
 */
- (UIViewController *)Action_TRZXBusinessPlan_TRZXFinalBusinessViewController:(NSDictionary *)params;



/**
 我得商业计划书

 @param params ..
 @return ..
 */
- (UIViewController *)Action_TRZXBusinessPlan_KipoMyBusinessPlanViewController:(NSDictionary *)params;


/**
 生成商业计划书

 @param params ..
 @return ..
 */
- (UIViewController *)Action_TRZXComplaint_TRZXBusinessPlan_TRZXHaveBusinessPlanController:(NSDictionary *)params;


@end
