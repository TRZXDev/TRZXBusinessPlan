//
//  BPCoreTeamMessageCellTableViewCell.m
//  TRZX
//
//  Created by Rhino on 2016/10/23.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "BPCoreTeamMessageCellTableViewCell.h"
#import "TRZXBusinessPlanHeader.h"

@implementation BPCoreTeamMessageCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(instancetype)initWithName:(NSString *)name Position:(NSString *)position Detail:(NSString *)detail HeadImage:(UIImage *)headImage{
    
    self = [[[NSBundle mainBundle]loadNibNamed:@"BPCoreTeamMessageCellTableViewCell" owner:nil options:nil]lastObject];
    
    self.headImageView.image = headImage;
    self.headImageView.bp_cornerRadius = 6;
    self.nameLabel.text = name;
//    self.positionLabel.text = position;
    self.detailLabel.text = detail;
    self.lineView.hidden = YES;
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(NSData *)GetHeadImageData{
    return [self dataCompress:self.headImageView.image];//[self imageData:self.headImageView.image];
}

//压缩图片至500k以下
-(NSData *)dataCompress:(UIImage *)image
{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 1.0);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 1.0);
        }
    }
    
    
    return data;
}

- (void)setChangeLength:(NSInteger)changeLength{
    _changeLength = changeLength;
    if (self.nameLabel.text.length > changeLength) {
        
        NSRange ranges = NSMakeRange(changeLength, self.nameLabel.text.length-changeLength);
        
        NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:self.nameLabel.text];
        [attributeText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:ranges];
        self.nameLabel.attributedText = attributeText;
    }
}

@end
