//
//  CTTeamTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "CTTeamTableViewCell.h"
#define tagTefield 2222
#import "TRZXBusinessPlanHeader.h"

@implementation CTTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = BPbackColor;
    self.firstView.layer.cornerRadius = 4;
    self.secondView.layer.cornerRadius = 4;
    self.threeView.layer.cornerRadius = 4;
    if ([self.nameLable.text hasSuffix:@"*"]) {
        self.nameLable.attributedText = [self setLocationAttributeWithStr:self.nameLable.text];
    }
    if ([self.positionLable.text hasSuffix:@"*"]) {
        self.positionLable.attributedText = [self setLocationAttributeWithStr:self.positionLable.text];
     }
    if ([self.gufenTitle.text hasSuffix:@"*"]) {
        self.gufenTitle.attributedText = [self setLocationAttributeWithStr:self.gufenTitle.text];
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
