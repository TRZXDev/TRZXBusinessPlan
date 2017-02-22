//
//  NewBPProjectProgressModel.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/9.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  项目进展 模型
 */
@interface NewBPProjectProgressModel : NSObject


@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *businessDevelopment;

@property (nonatomic, copy) NSString *active;

@property (nonatomic, copy) NSString *total;

@property (nonatomic, copy) NSString *mustComplete;

@property (nonatomic, copy) NSString *progress;

@property (nonatomic, copy) NSString *monthlySales;

@property (nonatomic, copy) NSString *monthlynumber;

@property (nonatomic, copy) NSString *marketShare;

@property (nonatomic, copy) NSString *complete;

@property (nonatomic, copy) NSString *user;

@property (nonatomic, copy) NSString *numberOfStores;
@property (nonatomic, copy) NSString *monthlTotal;

@end
