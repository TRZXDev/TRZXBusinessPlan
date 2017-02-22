//
//  BPTradeInfoCollectionViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/6.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPTradeInfoCollectionViewCell.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BPTradeInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)buttonClick:(id)sender {
    self.button.selected = !self.button.selected;
    if (self.button.selected) {
        self.button.backgroundColor = RGBA(209, 187, 104, 1);
    }else
    {
        self.button.backgroundColor = [UIColor whiteColor];
    }
}

@end
