//
//  BSAddNewTeamViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//


#import "BPBaseViewController.h"

@class NewBPTeamMemberModel;
/**
 *  添加新成员
 */
@interface BSAddNewTeamViewController : BPBaseViewController

@property (nonatomic,strong)NewBPTeamMemberModel *model;

@property (nonatomic,copy)void (^saveNewTeamerModelBlock)(NewBPTeamMemberModel *);

@property (nonatomic,assign)BOOL isUpdate;


@end
