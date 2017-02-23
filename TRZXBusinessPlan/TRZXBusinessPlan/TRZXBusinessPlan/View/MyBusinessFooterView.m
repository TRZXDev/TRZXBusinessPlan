//
//  MyBusinessFooterView.m
//  TRZX
//
//  Created by Rhino on 16/7/26.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "MyBusinessFooterView.h"
#import "TRZXBusinessPlanHeader.h"

#define buttonTag 223

@implementation MyBusinessFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addUI];
    }
    return self;
}

- (void)addUI
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2-1, self.frame.size.height)];
    btn.tag = buttonTag;
    [btn setTitle:@"编辑商业计划书" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = BPTRZXMainColor;
    [btn addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 0, 2, self.frame.size.height)];
    view.backgroundColor = BPbackColor;
    [self addSubview:view];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view.frame), 0, self.frame.size.width/2-1, self.frame.size.height)];
    [btn1 setTitle:@"生成商业计划书" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.backgroundColor = BPTRZXMainColor;
    btn1.tag = buttonTag +1;
    [btn1 addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    
}


- (void)firstClick:(UIButton *)btn
{
    NSInteger index = btn.tag- buttonTag;
    if(self.footClickBlock)
    {
        self.footClickBlock(index);
    }
}

@end
