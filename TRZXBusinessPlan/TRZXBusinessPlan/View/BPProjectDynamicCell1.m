//
//  ProjectDynamicCell1.m
//  tourongzhuanjia
//
//  Created by 移动微 on 16/4/21.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProjectDynamicCell1.h"

@implementation BPProjectDynamicCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
