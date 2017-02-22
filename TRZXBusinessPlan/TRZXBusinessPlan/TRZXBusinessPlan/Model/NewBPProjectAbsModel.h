//
//  NewBPProjectAbsModel.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/9.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewBPTradesModel;

@interface NewBPProjectAbsModel : NSObject

@property (nonatomic,copy)NSString * titleStr;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *mustComplete;

@property (nonatomic, strong) NSArray<NewBPTradesModel *> *trades;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *user;

@end

@interface NewBPTradesModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *trade;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *abstractz;

@end

