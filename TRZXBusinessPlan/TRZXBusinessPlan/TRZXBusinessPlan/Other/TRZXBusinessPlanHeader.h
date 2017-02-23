
//
//  TRZXBusinessPlanHeader.h
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef TRZXBusinessPlanHeader_h
#define TRZXBusinessPlanHeader_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "Masonry.h"
#import "IQKeyboardManager.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "UIView+BPFrame.h"
#import "UIImageView+WebCache.h"




#define BPSCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define BPSCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


/** 主题颜色 */
#define BPTRZXMainColor [UIColor colorWithRed:215.0/255.0 green:0/255.0 blue:15.0/255.0 alpha:1]

#define BPRGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]


#define BPxiandeColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
#define BPheizideColor [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1]

#define BPmoneyColor [UIColor colorWithRed:209.0/255.0 green:187.0/255.0 blue:114.0/255.0 alpha:1]
#define BPbackColor [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]


#endif /* TRZXBusinessPlanHeader_h */
