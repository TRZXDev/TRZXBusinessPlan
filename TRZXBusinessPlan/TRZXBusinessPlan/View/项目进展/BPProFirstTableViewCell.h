//
//  BPProFirstTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPProFirstTableViewCell : UITableViewCell

@property (nonatomic,copy)void (^clickBlock)(NSInteger index);

@property (nonatomic,copy)void (^mutlicpSeleBlock)(NSArray *);//返回选中的下标

@property (nonatomic,copy)void (^selectedClick)(NSString * );

@property (nonatomic,assign)NSInteger selecteIndex;

@property (nonatomic,copy)NSString *title;

@property (nonatomic,strong)NSArray *titleArray;


@property (nonatomic,copy)NSString *flag;

@end
