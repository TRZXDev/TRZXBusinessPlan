//
//  BPProFirstTableViewCell.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProFirstTableViewCell.h"
#define tagButton 3627
#import "TRZXBusinessPlanHeader.h"

@interface BPProFirstTableViewCell ()

@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)NSMutableArray *dataSource;


@end
@implementation BPProFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = backColor;
//        [self addUI];
    }
    return  self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    UILabel *lable = [[UILabel alloc]init];
    lable.frame = CGRectMake(13, 10, 120, 30);
//    lable.text = @"项目进度 *";
    lable.text = title;
    lable.textColor = zideColor;
    lable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lable];
    self.titleLable = lable;
    if ([lable.text hasSuffix:@"*"]) {
        lable.attributedText = [self setLocationAttributeWithStr:lable.text];
    }
    
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    NSInteger count = titleArray.count;
    
    CGFloat width = 80;
    CGFloat gap;
    if (count == 1) {
        gap = 20;
    }else
    {
       gap = (SCREEN_WIDTH - count*80)/(count+1);
    }
    
    for (int i =0; i <count; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = backColor;
        
        btn.frame = CGRectMake(gap +(gap +width) *i, CGRectGetMaxY(self.titleLable.frame)+10, width, 30);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:heizideColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        btn.tag = tagButton +i;
        btn.layer.cornerRadius = btn.frame.size.height/2;
        btn.layer.borderColor = xiandeColor.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.masksToBounds = YES;
        [self.contentView addSubview:btn];
        [self.dataSource addObject:btn];
    }

}

- (void)buttonClick:(UIButton *)btn
{
    if ([self.title isEqualToString:@"项目进度 *"]) {
        
        for (UIButton *button in self.dataSource) {
            button.selected = NO;
            button.backgroundColor = backColor;
        }
        btn.backgroundColor = TRZXMainColor;
        btn.selected = YES;
        NSInteger index = btn.tag -tagButton;
        if (self.clickBlock) {
            self.clickBlock(index);
        }
    }
    else if(self.titleArray.count == 1)
    {
        //一个值 返回字符串 0 1
        btn.selected = !btn.selected;
        if (btn.selected == YES) {
            btn.backgroundColor = TRZXMainColor;
        }else
        {
            btn.backgroundColor = backColor;
        }
        
    
        if (self.selectedClick) {
            self.selectedClick([NSString stringWithFormat:@"%d",btn.selected]);
        }
        
    }else
    {
        //多选
        btn.selected = !btn.selected;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i <self.dataSource.count; i ++) {
            UIButton *button = self.dataSource[i];
            if (button.selected == YES) {
                [array addObject:@"1"];
                button.backgroundColor = TRZXMainColor;
            }else
            {
                [array addObject:@"0"];
                 button.backgroundColor = backColor;
            }
        }

        
        if (self.mutlicpSeleBlock) {
            self.mutlicpSeleBlock(array);
        }
        
    }
    
    
    
}
- (void)setSelecteIndex:(NSInteger)selecteIndex
{
    _selecteIndex = selecteIndex;
    for (UIButton *button in self.dataSource) {
        button.selected = NO;
        button.backgroundColor = backColor;
    }
    UIButton *btn = (UIButton *)[self.dataSource objectAtIndex:selecteIndex];
    btn.backgroundColor = TRZXMainColor;
    btn.selected = YES;
    
}

//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:RGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}


- (void)setFlag:(NSString *)flag
{
    if ([flag isEqualToString:@"1"]) {

        for (int i = 0; i <self.dataSource.count; i ++) {
            UIButton *button = self.dataSource[i];
            button.selected = YES;
            button.backgroundColor = TRZXMainColor;
        }
    }
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
