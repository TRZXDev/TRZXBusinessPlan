//
//  NewBPBusinessModel.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/9.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  商业模式 模型
 */
@interface NewBPBusinessModel : NSObject

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *market;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *control;

@property (nonatomic, copy) NSString *function;

@property (nonatomic, copy) NSString *strategy;

@property (nonatomic, copy) NSString *mustComplete;

@property (nonatomic, copy) NSString *gain;

@property (nonatomic, copy) NSString *complete;

@property (nonatomic, copy) NSString *flow;

@property (nonatomic, copy) NSString *user;

@property (nonatomic, copy) NSString *risk;

@property (nonatomic, copy) NSString *gainMoney;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *gainFlag;

@property (nonatomic, strong) NSMutableArray *pics;

@end
