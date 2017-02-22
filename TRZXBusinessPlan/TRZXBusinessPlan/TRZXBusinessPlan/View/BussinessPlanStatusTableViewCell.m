//
//  BussinessPlanStatusTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BussinessPlanStatusTableViewCell.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BussinessPlanStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if ([self.titleLable.text hasSuffix:@"*"]) {
        self.titleLable.attributedText = [self setLocationAttributeWithStr:self.titleLable.text];
    }
    
        self.noneWater.layer.borderColor = xiandeColor.CGColor;
        self.yesWater.layer.borderColor = xiandeColor.CGColor;
    
        self.noneWater.layer.borderWidth = 1;
        self.yesWater.layer.borderWidth = 1;

    
    self.noneWater.cornerRadius = 13.5;
    self.yesWater.cornerRadius = 13.5;
}
//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (IBAction)btn:(id)sender {
    
    self.noneWater.backgroundColor = TRZXMainColor;
    self.yesWater.backgroundColor = backColor;
    self.noneWater.selected = YES;
    self.yesWater.selected = NO;
    
    self.noneWater.layer.borderColor = xiandeColor.CGColor;
    self.yesWater.layer.borderColor = xiandeColor.CGColor;
    
    self.noneWater.layer.borderWidth = 1;
    self.yesWater.layer.borderWidth = 1;
    
    self.noneWater.cornerRadius = 13.5;
    self.yesWater.cornerRadius = 13.5;
    
    
    if (self.clickStatusBlock) {
        self.clickStatusBlock(@"0");
    }
}
- (IBAction)yes:(id)sender {
    
    self.noneWater.backgroundColor = backColor;
    self.yesWater.backgroundColor = TRZXMainColor;
    
    self.noneWater.layer.borderColor = xiandeColor.CGColor;
    self.yesWater.layer.borderColor = xiandeColor.CGColor;
    
    self.noneWater.layer.borderWidth = 1;
    self.yesWater.layer.borderWidth = 1;
    
    self.noneWater.cornerRadius = 13.5;
    self.yesWater.cornerRadius = 13.5;
    
    self.noneWater.selected = NO;
    self.yesWater.selected = YES;
    if (self.clickStatusBlock) {
        self.clickStatusBlock(@"1");
    }
}


//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:RGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
