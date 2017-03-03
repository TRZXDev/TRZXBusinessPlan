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



- (UIViewController *)Action_TRZXBusinessPlan_TRZXFinalBusinessViewController:(NSDictionary *)params;

- (UIViewController *)Action_TRZXBusinessPlan_KipoMyBusinessPlanViewController:(NSDictionary *)params;

- (UIViewController *)Action_TRZXComplaint_TRZXBusinessPlan_TRZXHaveBusinessPlanController:(NSDictionary *)params;


@end
