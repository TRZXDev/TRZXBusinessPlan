//
//  ProjectAlertView.m
//  tourongzhuanjia
//
//  Created by 投融在线 on 16/3/2.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProjectAlertView.h"
#import "UIView+BPAlertViewProject.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BPProjectAlertView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    self.contentView.layer.cornerRadius = 5;
    self.bgView.backgroundColor=BPRGBA(0, 0, 0, 0.4);
    self.backgroundColor = [UIColor clearColor];

    self.cancleButton.layer.cornerRadius = 5;
    self.cancleButton.layer.masksToBounds = YES;

    self.cancleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cancleButton.layer.borderWidth = 1;
    

    self.SureButton.layer.cornerRadius = 5;
    self.SureButton.layer.masksToBounds = YES;
}

- (IBAction)cancleClick:(id)sender {
    
    [self dimiss];
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(AlertView:cancelBtnTapped:)]) {
        [self.delegate AlertView:self cancelBtnTapped:sender];
    }
}

- (IBAction)sureClick:(id)sender {

    [self dimiss];
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(AlertView:okBtnTapped:)]) {
        [self.delegate AlertView:self okBtnTapped:sender];
    }
}

-(void)show
{
    UIWindow *rtView = [[UIApplication sharedApplication] keyWindow];
    //    UIView *rtView  = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    
//    CGRect rect= [self.contenlabel.text boundingRectWithSize:CGSizeMake(205, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
//    self.heightlaycontraint.constant=rect.size.height+130;
//    [rtView addSubview:self];

    NSDictionary *dic = @{@"alert":self};
    
    [rtView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[alert]|" options:0 metrics:0 views:dic]];
    [rtView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[alert]|" options:0 metrics:0 views:dic]];
    [rtView layoutIfNeeded];
    //弹出的动画效果
    [self.contentView bp_reboundEffectAnimationDuration:0.5];
}

-(void)dimiss
{
    [self removeFromSuperview];
}



@end
