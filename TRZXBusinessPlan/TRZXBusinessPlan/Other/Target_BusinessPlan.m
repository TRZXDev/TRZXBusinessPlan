//
//  Target_BusinessPlan.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/3/3.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "Target_BusinessPlan.h"
#import "MyBussinessFinalViewController.h"
#import "KipoMyBusinessPlanViewController.h"

@implementation Target_BusinessPlan



- (UIViewController *)Action_TRZXBusinessPlan_TRZXFinalBusinessViewController:(NSDictionary *)params{
    MyBussinessFinalViewController *myBPVC = [[MyBussinessFinalViewController alloc]init];
    myBPVC.myBussinessUrl = params[@"pdfUrl"];
    myBPVC.titleStr = params[@"title"];
    myBPVC.type = [params[@"type"] integerValue];
    myBPVC.isPush = [params[@"isPush"] boolValue];
    myBPVC.isPDF = [params[@"isPDF"] boolValue];
    myBPVC.bpName = params[@"bpName"];
    return myBPVC;
}

- (UIViewController *)Action_TRZXBusinessPlan_KipoMyBusinessPlanViewController:(NSDictionary *)params{
    KipoMyBusinessPlanViewController *myBussines = [[KipoMyBusinessPlanViewController alloc] init];
    myBussines.titleStr = params[@"title"];
    return myBussines;
}

- (UIViewController *)Action_TRZXComplaint_TRZXBusinessPlan_TRZXHaveBusinessPlanController:(NSDictionary *)params{
    MyBussinessFinalViewController *myBPVC = [[MyBussinessFinalViewController alloc]init];
    myBPVC.titleStr = params[@"title"];
    myBPVC.myBussinessUrl = params[@"url"];;
    myBPVC.type = [params[@"type"] integerValue];
    myBPVC.isPush = [params[@"isPush"] boolValue];
    myBPVC.bpName = params[@"bpName"];
    return myBPVC;
}


@end
