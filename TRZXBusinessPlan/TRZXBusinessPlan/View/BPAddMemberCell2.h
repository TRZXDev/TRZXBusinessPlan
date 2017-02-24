//
//  AddMemberCell2.h
//  tourongzhuanjia
//
//  Created by 移动微 on 16/4/22.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPAddMemberCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *MsgTitleLable;
@property(nonatomic,weak)UIViewController *referenceVC;

@property (nonatomic,assign)BOOL isUpImage;

@property (nonatomic,copy)void (^selectImage)(UIImage *image);

@end
