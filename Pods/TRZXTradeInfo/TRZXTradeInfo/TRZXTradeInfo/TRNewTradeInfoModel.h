//
//  TRNewTradeInfoModel.h
//  TRZX
//
//  Created by Rhino on 16/8/29.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class TRNewChildrenModel;

@interface TRNewTradeInfoModel : NSObject

@property(nonatomic,copy)NSString *mid;

@property(nonatomic,copy)NSString *trade;

@property(nonatomic,copy)NSString *flag;

@property(nonatomic,copy)NSString *userId;

@property(nonatomic,copy)NSString *parentId;

@property(nonatomic,strong)NSArray *children;

@end
