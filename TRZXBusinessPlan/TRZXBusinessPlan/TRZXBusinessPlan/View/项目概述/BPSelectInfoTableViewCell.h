//
//  BPSelectInfoTableViewCell.h
//  tourongzhuanjia
//
//  Created by Alen on 16/5/6.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPSelectInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (nonatomic,copy)NSString *title;

@end
