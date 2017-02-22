//
//  BPSelectInfoTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/6.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPSelectInfoTableViewCell.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BPSelectInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    if ([self.titleLable.text hasSuffix:@"*"]) {
        self.titleLable.attributedText = [self setLocationAttributeWithStr:self.titleLable.text];
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

- (void)setTitle:(NSString *)title
{
    _title = title;
    if ([self.titleLable.text hasSuffix:@"*"]) {
        self.titleLable.attributedText = [self setLocationAttributeWithStr:self.titleLable.text];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
