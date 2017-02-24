//
//  ProjectMsgCell.h
//  tourongzhuanjia
//
//  Created by 投融在线 on 16/2/29.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPProjectMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *textViewMsg;
@property (weak, nonatomic) IBOutlet UILabel *countCharacter;
@property (weak, nonatomic) IBOutlet UILabel *placeHoderLable;
@property (nonatomic,assign)NSUInteger contentOffset;
@property (nonatomic,assign)BOOL isPaste;
/**
 *  初始化构造方法
 *
 *  @param title          标题
 *  @param placeHoder     占位文字
 *  @param countCharacter 剩余文字
 *  @param textViewStr    正文
 *
 *  @return 返回构造实例
 */
-(instancetype)initWithTitle:(NSString *)title PlaceHoder:(NSString *)placeHoder CountCharacter:(NSString *)countCharacter TextViewMsg:(NSString *)textViewStr;
@end
