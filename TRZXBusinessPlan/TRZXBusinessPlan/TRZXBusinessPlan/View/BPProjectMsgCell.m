//
//  ProjectMsgCell.m
//  tourongzhuanjia
//
//  Created by 投融在线 on 16/2/29.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProjectMsgCell.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BPProjectMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLable.textColor = BPRGBA(179, 179, 179, 1.0);
    self.placeHoderLable.textColor = BPRGBA(218, 218, 218, 1.0);
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    self.countCharacter.textColor = BPRGBA(179, 179, 179, 1.0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithTitle:(NSString *)title PlaceHoder:(NSString *)placeHoder CountCharacter:(NSString *)countCharacter TextViewMsg:(NSString *)textViewStr{
    self = [[[NSBundle mainBundle]loadNibNamed:@"BPProjectMsgCell" owner:nil options:nil]lastObject];
    
    if ([title hasSuffix:@"*"]) {
        self.titleLable.attributedText = [self setLocationAttributeWithStr:title];
    }else{
        self.titleLable.text = title;
    }
    
    self.placeHoderLable.text = placeHoder;
    if (textViewStr.length) {
        self.placeHoderLable.hidden = YES;
    }
    self.countCharacter.text = countCharacter;
    self.textViewMsg.text = textViewStr;
//    self.textViewMsg.scrollEnabled = NO;
    if (textViewStr.length >0) {
        self.placeHoderLable.hidden = YES;
        if ([countCharacter integerValue] >= textViewStr.length) {
            self.countCharacter.text = [NSString stringWithFormat:@"%lu字",(long)([countCharacter integerValue]-textViewStr.length)];
       }
    }
    return self;
}

//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:BPRGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}


//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//
//    
////    if (action == @selector(cut:) ||
////        action == @selector(copy:)||
////        action == @selector(delete:)||
////        action == @selector(_promptForReplace:)) {
//        return NO;
////    }
//    
////    return [super canPerformAction:action withSender:sender];
//}

@end
