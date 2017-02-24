//
//  BPAddNewThinkViewController.h
//  
//
//  Created by Alen on 16/5/7.
//
//

#import "BPBaseViewController.h"

@class BPDynamicList;
/**
 *  添加新事件
 */
@interface BPAddNewThinkViewController : BPBaseViewController

@property (nonatomic,copy)void (^textModleBlock)(BPDynamicList  *);

@property (nonatomic,strong)BPDynamicList *model;

@property (nonatomic,assign)BOOL isUpdate;

@end
