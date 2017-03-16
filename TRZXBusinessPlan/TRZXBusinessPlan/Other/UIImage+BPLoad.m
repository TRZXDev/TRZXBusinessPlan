//
//  UIImage+BPLoad.m
//  TRZXBusinessPlan
//
//  Created by Rhino on 2017/3/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "UIImage+BPLoad.h"

@implementation UIImage (BPLoad)


+ (UIImage *)bp_loadImage:(NSString *)string class:(Class)className{
    
    NSBundle *myBundle = [NSBundle bundleForClass:className];
    NSString *path = [[myBundle resourcePath]stringByAppendingPathComponent:string];
    return [UIImage imageWithContentsOfFile:path];
}


@end
