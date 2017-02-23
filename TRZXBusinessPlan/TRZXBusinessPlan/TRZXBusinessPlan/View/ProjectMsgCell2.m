//
//  ProjectMsgCell2.m
//  tourongzhuanjia
//
//  Created by 移动微 on 16/4/18.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "ProjectMsgCell2.h"

@interface ProjectMsgCell2 ()




@end

@implementation ProjectMsgCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStratDateStr:(NSString *)stratDateStr{
    _stratDateStr = stratDateStr;
    
    if (stratDateStr != nil) {
        
        NSArray *dateArr = [stratDateStr componentsSeparatedByString:@"-"];
        
        _yearLabel.text = dateArr[0];
        _monthLabel.text = dateArr[1];
        _dayLabel.text = dateArr[2];
    }
    
    
}

- (IBAction)dateButtonClick:(id)sender {
    
    
    if (self.dateButtonClick){
        self.dateButtonClick();
    }
    
}


@end
