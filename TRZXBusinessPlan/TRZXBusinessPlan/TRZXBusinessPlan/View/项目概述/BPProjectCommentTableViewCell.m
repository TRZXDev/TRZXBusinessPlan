//
//  BPProjectCommentTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/6.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProjectCommentTableViewCell.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BPProjectCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topBgView.layer.cornerRadius = 8;
    self.topBgView.layer.masksToBounds = YES;
    if ([self.topTitle.text hasSuffix:@"*"]) {
        self.topTitle.attributedText = [self setLocationAttributeWithStr:self.topTitle.text];
    }
    self.bottomView.layer.cornerRadius = 8;
    self.bottomView.layer.masksToBounds = YES;
    if ([self.bottomTitle.text hasSuffix:@"*"]) {
        self.bottomTitle.attributedText = [self setLocationAttributeWithStr:self.bottomTitle.text];
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


-(void)setStratDateStr:(NSString *)stratDateStr{
    _stratDateStr = stratDateStr;
    
    if (stratDateStr != nil && stratDateStr.length>0) {
        
        NSArray *dateArr = [stratDateStr componentsSeparatedByString:@"-"];
        
        _year.text = dateArr[0];
        _month.text = dateArr[1];
        NSString *string = dateArr[2];
        if (string.length > 2) {
            _day.text = [string substringToIndex:2];
        }else
        {
            _day.text = string;
        }
        
    }
    
    
}

- (IBAction)dateButtonClick:(id)sender {
    
    
    if (self.dateButtonClick){
        self.dateButtonClick();
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
