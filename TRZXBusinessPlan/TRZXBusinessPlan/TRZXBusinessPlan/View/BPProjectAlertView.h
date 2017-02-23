//
//  ProjectAlertView.h
//  tourongzhuanjia
//
//  Created by 投融在线 on 16/3/2.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BPProjectAlertViewDelegate;

/**
 *  提示框
 */
@interface BPProjectAlertView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *SureButton;
@property (weak, nonatomic) IBOutlet UILabel *topLable;
@property (weak, nonatomic) IBOutlet UILabel *leftLable;
@property (weak, nonatomic) IBOutlet UILabel *bottomLable;


@property (nonatomic, assign) id<BPProjectAlertViewDelegate>delegate;


-(void)show;
-(void)dimiss;

@end

@protocol BPProjectAlertViewDelegate <NSObject>

@optional

- (void)AlertView:(BPProjectAlertView *)AlertView cancelBtnTapped:(id)sender;
- (void)AlertView:(BPProjectAlertView *)AlertView okBtnTapped:(id)sender;

@end
