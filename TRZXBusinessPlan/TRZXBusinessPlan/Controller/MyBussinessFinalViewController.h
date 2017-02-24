//
//  MyBussinessFinalViewController.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPBaseViewController.h"

/**
 *  生成商业企划书
 */
@interface MyBussinessFinalViewController : BPBaseViewController

@property (nonatomic,copy  ) NSString  *myBussinessUrl;
@property (nonatomic,copy  ) NSString  *bpName;
@property (nonatomic,strong) UIImage   *image;

@property (nonatomic,assign) NSInteger type;//  1为生成  2为修改 3.为编辑

@property (nonatomic,assign) BOOL      isPush;
@property (nonatomic,assign) BOOL isPDF;//是否后台传过

@property (nonatomic,copy)NSString * titleStr;


@end
