
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
#import "UIView+WalletFrame.h"
#import "UIImageView+WebCache.h"



#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define kScreen_Bounds [UIScreen mainScreen].bounds
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define  kBadgeTipStr @"badgeTip"


/** 主题颜色 */
#define TRZXMainColor [UIColor colorWithRed:215.0/255.0 green:0/255.0 blue:15.0/255.0 alpha:1]
/** 主要的背景颜色 */
#define TRZXMainBgColor [UIColor groupTableViewBackgroundColor]
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]


#define UserInfoImagePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"userInfo.png"]
#define UserNamePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"Name.txt"]
#define UserBJImagePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"BeiJing.png"]
//定义宏（限制输入内容）
#define kAlphaNum  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kAlpha     @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define kNumbers   @"0123456789."
#define kXNumbers   @"0123456789x"
#define kMail  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@"
#define kNumbersBlock   @"0123456789\b"
#define NSNotificationBackInfo @"BackInfo"
#define NSNotificationTheme @"ThemeRevise"
#define NSNotificationNewTheme @"NewThemeRevise"
#define NSNotificationMeet @"meet"
#define NSNotificationBeiJing @"Beijing"
#define ProjectRegex @"^.{%ld,%ld}$"
#define xiandeColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
#define zideColor [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1]
#define heizideColor [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1]
#define kBlackColor         [UIColor blackColor]
#define moneyColor [UIColor colorWithRed:209.0/255.0 green:187.0/255.0 blue:114.0/255.0 alpha:1]
#define backColor [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]
#define textBackCole [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1]
#define bluebjColor [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:254.0/255.0 alpha:1]
#define bluebkColor [UIColor colorWithRed:75/255.0 green:185/255.0 blue:220/255.0 alpha:1]
#define xinxiColor [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1];
#define grayKColor [UIColor colorWithRed:90 /255.0 green:90 /255.0 blue:90 /255.0 alpha:1]
#define darkgrayKColor [UIColor colorWithRed:115 /255.0 green:115 /255.0 blue:115 /255.0 alpha:1]
#define daihuidaColor [UIColor colorWithRed:32 /255.0 green:193 /255.0 blue:130 /255.0 alpha:1]
#define HEIGTH(view) view.frame.size.height
#define WIDTH(view) view.frame.size.width
#define POINTY(view) view.frame.origin.y
#define POINTX(view) view.frame.origin.x
#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define kBlackColor         [UIColor blackColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRandomFlatColor    [UIColor randomFlatColor]


#define kColorDDD [UIColor colorWithHexString:@"0xDDDDDD"]
#define kColorBrandGreen [UIColor colorWithHexString:@"0x3BBD79"]



// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]










#define  zjself __weak __typeof(self) sfself = self

/**
 *  该标识用于判断首次登录认证提交完成后,返回进入主页面.,中途杀死程序进行清空
 */
#define TRAUTHISFTRST @"TRAUTHISFTRST" //判读是否是第一次认证

#pragma mark - Tag

#define mobleNumber 30000
#define passworldNumber 30001
#define testNumber 30002
#define nickNameNumber 30003
#define nameNumber 30004
#define companyNumber 30005
#define emailNumber 30006
#define areaNumber 30007
#define themeNumber 30008
#define abstractsNumber 30009
#define priceNumber 30010
#define individualNumber 30011
#define aleartSubmit 20000
#define aleartJudge 20001
#define playMVTag 20002
#define commentTag 20003
#define playLBTag 20003.1
#define idCardBackTag 20004
#define idCardFaceTag 20005
#define identificationLicenceTag 20006
#define businessLicenceTag 20007
#define companyLicenceTag 20008
#define purseTag 20009
#define weiXinTag 20010
#define unionpayTag 20011
#define removeChongZhiVC @"removeChongZhiVC"



#endif /* TRZXBusinessPlanHeader_h */
