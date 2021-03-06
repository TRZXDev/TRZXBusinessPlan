//
//  BPProSecondsTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProSecondsTableViewCell.h"
#define tagTextField 344
#import "TRZXBusinessPlanHeader.h"

@implementation BPProSecondsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = BPbackColor;
    self.firstView.layer.cornerRadius = 4;
    self.secondView.layer.cornerRadius = 4;
    self.threeView.layer.cornerRadius = 4;
    self.fourView.layer.cornerRadius = 4;
    self.fiveView.layer.cornerRadius = 4;
    self.sixView.layer.cornerRadius = 4;
   
    if ([self.tishiTextLable.text hasPrefix:@"*"]) {
        self.tishiTextLable.attributedText = [self setLocationAttributeWithStr:self.tishiTextLable.text];
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
