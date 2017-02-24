//
//  BPPhotoShowMsgTableViewCell.m
//  tourongzhuanjia
//
//  Created by Rhino on 16/5/19.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPPhotoShowMsgTableViewCell.h"
#import "TRZXBusinessPlanHeader.h"


@implementation BPPhotoShowMsgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if ([self.titleLable.text hasPrefix:@"*"]) {
       self.titleLable.attributedText = [self setLocationAttributeWithStr:self.titleLable.text];
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
