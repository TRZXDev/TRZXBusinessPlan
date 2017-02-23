//
//  BPAddNewThinkViewController.h
//  
//
//  Created by Alen on 16/5/7.
//
//

#import "BPBaseViewController.h"

@class DynamicList;
/**
 *  添加新事件
 */
@interface BPAddNewThinkViewController : BPBaseViewController

@property (nonatomic,copy)void (^textModleBlock)(DynamicList  *);

@property (nonatomic,strong)DynamicList *model;

@property (nonatomic,assign)BOOL isUpdate;

@end
