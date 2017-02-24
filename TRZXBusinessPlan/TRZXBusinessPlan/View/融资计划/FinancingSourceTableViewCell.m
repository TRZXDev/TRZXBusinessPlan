//
//  FinancingSourceTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "FinancingSourceTableViewCell.h"

#import "TRZXBusinessPlanHeader.h"

@implementation FinancingSourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.firstView.layer.cornerRadius = 4;
    self.secondView.layer.cornerRadius = 4;
    self.third.layer.cornerRadius = 4;
    self.FourView.layer.cornerRadius = 4;
    if ([self.title1.text hasPrefix:@"*"]) {
        self.title1.attributedText = [self setLocationAttributeWithStr:self.title1.text];
    }
    if ([self.title2.text hasPrefix:@"*"]) {
        self.title2.attributedText = [self setLocationAttributeWithStr:self.title2.text];
    }
    if ([self.title3.text hasPrefix:@"*"]) {
        self.title3.attributedText = [self setLocationAttributeWithStr:self.title3.text];
    }
    if ([self.title4.text hasPrefix:@"*"]) {
        self.title4.attributedText = [self setLocationAttributeWithStr:self.title4 .text];
    }
    
    
}
//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:BPRGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
