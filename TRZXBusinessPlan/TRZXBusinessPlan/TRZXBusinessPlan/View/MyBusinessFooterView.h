//
//  MyBusinessFooterView.h
//  TRZX
//
//  Created by Rhino on 16/7/26.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBusinessFooterView : UIView


@property (nonatomic,copy)void (^footClickBlock) (NSInteger index);
@end
