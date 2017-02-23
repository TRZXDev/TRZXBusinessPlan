//
//  AddMemberCell.m
//  tourongzhuanjia
//
//  Created by 移动微 on 16/4/22.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "AddMemberCell.h"
#import "TRZXBusinessPlanHeader.h"

@interface AddMemberCell()<UITextFieldDelegate>

@end

@implementation AddMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.firstView.layer.cornerRadius = 6;
    self.firstView.layer.masksToBounds = YES;
    
    self.seconView.layer.cornerRadius = 6;
    self.seconView.layer.masksToBounds = YES;
    
    self.firstTextField.placeholder = @"最少2个字";
    self.seconTextField.placeholder = @"最少2个字";
    
    self.firstLabel.attributedText = [self setLocationAttributeWithStr:@"姓名 *"];
    self.seconLabel.attributedText = [self setLocationAttributeWithStr:@"职位 *"];
    
    
    self.firstTextField.delegate = self;
    [self.firstTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.seconTextField.delegate = self;
    [self.seconTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.contentView.backgroundColor = BPbackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -textViewDelegate
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    textField.placeholder = @"";
//}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [self resignFirstResponder];
        return NO;
    }

    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 20) {
                textField.text = [toBeString substringToIndex:20];
            }
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > 20) {
            textField.text = [toBeString substringToIndex:20];
        }
    }
//    textField.text = toBeString;
//    if (self.firstTextField.isFirstResponder) {
//        self.firstTextField.text = toBeString;
//    }else if(self.seconTextField.isFirstResponder){
//        self.seconTextField.text = toBeString;
//    }
}


//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:BPRGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}

@end
