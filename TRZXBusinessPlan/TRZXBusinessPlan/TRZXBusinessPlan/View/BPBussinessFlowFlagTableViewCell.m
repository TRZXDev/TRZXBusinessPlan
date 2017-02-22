//
//  BPBussinessFlowFlagTableViewCell.m
//  tourongzhuanjia
//
//  Created by Rhino on 16/5/21.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPBussinessFlowFlagTableViewCell.h"
#import "TRZXBusinessPlanHeader.h"


@implementation BPBussinessFlowFlagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = backColor;
    self.bgView.layer.cornerRadius = 8;

    
    if ([self.titles1.text hasSuffix:@"*:"]) {
        self.titles1.attributedText = [self setLocationAttributeWithStr:self.titles1.text];
    }
    if ([self.titles2.text hasSuffix:@"*:"]) {
        self.titles2.attributedText = [self setLocationAttributeWithStr:self.titles2.text];
    }
    if ([self.titles3.text hasSuffix:@"*:"]) {
        self.titles3.attributedText = [self setLocationAttributeWithStr:self.titles3.text];
    }
    self.titles3.hidden = YES;
    self.danwei.hidden = YES;
    self.glowMoneyTF.hidden = YES;
    self.no.cornerRadius = 13.5;
    self.yes.cornerRadius = 13.5;
    self.no.layer.borderColor = xiandeColor.CGColor;
    self.yes.layer.borderColor = xiandeColor.CGColor;
    
    self.no.layer.borderWidth = 1;
    self.yes.layer.borderWidth = 1;
}

//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:RGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}

- (IBAction)btn:(id)sender {
    
    self.titles3.hidden = YES;
    self.danwei.hidden = YES;
    self.glowMoneyTF.hidden = YES;
    
    self.no.selected = YES;
    self.no.backgroundColor = TRZXMainColor;
    self.yes.backgroundColor = backColor;
    self.no.cornerRadius = 13.5;
    self.yes.cornerRadius = 13.5;
    
    self.no.layer.borderColor = xiandeColor.CGColor;
    self.yes.layer.borderColor = xiandeColor.CGColor;
    
    self.no.layer.borderWidth = 1;
    self.yes.layer.borderWidth = 1;
    
    self.yes.selected = NO;
    if (self.flowStatusBlock) {
        self.flowStatusBlock(@"0");
    }
}
- (IBAction)yes:(id)sender {
    self.titles3.hidden = NO;
    self.danwei.hidden = NO;
    self.glowMoneyTF.hidden = NO;
    self.no.selected = NO;
    self.yes.selected = YES;
    self.no.backgroundColor = backColor;
    self.yes.backgroundColor = TRZXMainColor;
    self.no.cornerRadius = 13.5;
    self.yes.cornerRadius = 13.5;
    
    if (self.flowStatusBlock) {
        self.flowStatusBlock(@"1");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
