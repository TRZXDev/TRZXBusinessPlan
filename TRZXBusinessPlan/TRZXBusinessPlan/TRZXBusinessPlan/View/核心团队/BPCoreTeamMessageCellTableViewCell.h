//
//  BPCoreTeamMessageCellTableViewCell.h
//  TRZX
//
//  Created by Rhino on 2016/10/23.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPCoreTeamMessageCellTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic,copy)NSString *mid;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (assign,nonatomic)NSInteger changeLength;

/**
 *  初始化方法
 *
 *  @param name      名字
 *  @param position  职位
 *  @param detail    介绍
 *  @param headImage 头像
 *
 *  @return 实例对象
 */
-(instancetype)initWithName:(NSString *)name Position:(NSString *)position Detail:(NSString *)detail HeadImage:(UIImage *)headImage;

-(NSData *)GetHeadImageData;

@end
