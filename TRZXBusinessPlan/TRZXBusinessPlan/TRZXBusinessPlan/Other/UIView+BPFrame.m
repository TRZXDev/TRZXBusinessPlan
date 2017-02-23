//
//  UIView+WalletFrame.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/2/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "UIView+BPFrame.h"

@implementation UIView (BPFrame)

-(void)setBp_cornerRadius:(CGFloat)bp_cornerRadius{
    [self.layer setCornerRadius:bp_cornerRadius];
}

-(void)setBusiness_cornerRadius:(CGFloat)business_cornerRadius{
    self.layer.cornerRadius = business_cornerRadius;
    self.layer.masksToBounds = YES;
    
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

-(CGFloat)business_cornerRadius{
    return self.layer.cornerRadius;
}

@end
