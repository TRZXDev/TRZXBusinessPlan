//
//  BSAddNewTeamViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//
#define tagTefield 2222
#define tagTextView 2256343


#import "BSAddNewTeamViewController.h"
#import "BPProjectMsgCell.h"
#import "BPAddMemberCell2.h"
#import "CTTeamTableViewCell.h"

#import "NewBPTeamMemberModel.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "BusinessMemoryCacheTool.h"

#import "TRZXBusinessPlanHeader.h"

@interface BSAddNewTeamViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)UITextField *positionTF;


@end

@implementation BSAddNewTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self addUI];
}

- (void)setNaviBar
{
    self.mainTitle.text = @"添加团队成员";
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.saveBtn.hidden = NO;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
}

- (void)addUI
{
    [self.view addSubview:self.tableView];
}

#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        CTTeamTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"CTTeamTableViewCell" owner:self options:nil] firstObject];
        cell.nameText.delegate = self;
        cell.positionText.delegate = self;
        cell.gufenText.delegate = self;
        self.nameTF = cell.nameText;
        self.positionTF = cell.positionText;
        [self.nameTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.positionTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        
        cell.nameText.text = self.model.name;
        cell.positionText.text = self.model.position;
        cell.gufenText.text = self.model.holding;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 1)
    {
        BPProjectMsgCell *cell = [[BPProjectMsgCell alloc]initWithTitle:@"毕业学校 *" PlaceHoder:@"例:首都师范大学" CountCharacter:@"20字" TextViewMsg:self.model.school];
        cell.textViewMsg.delegate = self;
        cell.textViewMsg.tag = tagTextView + indexPath.row;
        cell.textViewMsg.textColor = BPheizideColor;
        cell.textViewMsg.returnKeyType = UIReturnKeyDone;
        cell.contentView.backgroundColor = BPbackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else if (indexPath.row == 2)
    {
        BPProjectMsgCell *cell = [[BPProjectMsgCell alloc]initWithTitle:@"工作履历 *" PlaceHoder:@"例:从事儿童情商教育2年。" CountCharacter:@"50字" TextViewMsg:self.model.work];
        cell.textViewMsg.delegate = self;
        cell.textViewMsg.tag = tagTextView + indexPath.row;
        cell.textViewMsg.textColor = BPheizideColor;
        cell.contentView.backgroundColor = BPbackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else if (indexPath.row == 3)
    {
        BPAddMemberCell2 *cell = [[[NSBundle mainBundle]loadNibNamed:@"BPAddMemberCell2" owner:self options:nil] firstObject];
        
        cell.MsgTitleLable.hidden = YES;
        cell.referenceVC = self;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.memberPic] placeholderImage:[UIImage imageNamed:@"bp_addPhoto"]];
        cell.contentView.backgroundColor = BPbackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"block"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"block"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BPbackColor;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 148;
    }else if (indexPath.row == 1)
    {
        return 120;
    }else if (indexPath.row == 2)
    {
        return 120;
        
    }else if (indexPath.row == 3)
    {
        return 260;
    }
    return 200;
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}
- (BOOL)textIsChangeWithTextfield:(UITextField *)textfield textString:(NSString *)string textNumberCount:(NSInteger)count{
    
    return YES;
}

#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    NSInteger count = 10;
    
    if ([textField isEqual:self.nameTF])
    {
        count = 10;
    }else if ([textField isEqual:self.positionTF])
    {
        count = 18;
    }

    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > count) {
                textField.text = [toBeString substringToIndex:count];
            }
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > count) {
            textField.text = [toBeString substringToIndex:count];
        }
    }
}

//设置输入的范围只能是数字 ，考虑粘贴的情况
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    NSInteger index = textField.tag - tagTefield;
    if (index == 2 ) {
        NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        CGFloat a = [str floatValue];
        if (a > 100) {
            return NO;
        }
        NSCharacterSet *cs;
        if (![self authFloatNumberWithRange:range string:string andTefield:textField]) {
            return [self authFloatNumberWithRange:range string:string andTefield:textField];
        }
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
        
        NSString *filtered =
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        return basic;
    }else if ([textField isEqual:self.nameTF])
    {
        //[NSString stringWithFormat:@"%@%@",textField.text,string];
//        if (str.length > 10) {
//            textField.text = [str substringToIndex:10];
//            return NO;
//        }
    }else if ([textField isEqual:self.positionTF])
    {
//        NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
//        
//        if (str.length > 15) {
//            textField.text = [str substringToIndex:15];
//            return NO;
//        }
//        return YES;
    }
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger index = textField.tag - tagTefield;
    switch (index) {
        case 0:
            self.model.name = textField.text;
            break;
        case 1:
            self.model.position = textField.text;
            break;
        case 2:
            //textField.text = [NSString stringWithFormat:@"%f",[textField.text floatValue]];
            self.model.holding = textField.text;
            break;
            
        default:
            break;
    }
}


#pragma mark - textViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSInteger indexTag = textView.tag - tagTextView;
    
    BPProjectMsgCell *cell = [self cellForRow:indexTag];
    [cell.placeHoderLable setHidden:YES];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger index = textView.tag - tagTextView;
    //     BPProjectMsgCell *cell = [self cellForRow:index];
    

//    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (index ==1) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    } //else
//    {
//        if (string.length > 50) {
//            string = [string substringToIndex:50];
//            return NO;
//        }
//    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger indexTag = textView.tag - tagTextView;
    
    BPProjectMsgCell *cell = [self cellForRow:indexTag];
    if (textView.text.length == 0)
    {
        [cell.placeHoderLable setHidden:NO];
    }else
    {
        [cell.placeHoderLable setHidden:YES];
    }
    
    NSInteger count = 20;
    if (indexTag == 1) {
        count  = 20;
    }else
    {
        count = 50;
    }
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > count) {
                textView.text = [toBeString substringToIndex:count];
            }
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > count) {
            textView.text = [toBeString substringToIndex:count];
        }
    }
    
//    NSString *string = toBeString;
//    cell.textViewMsg.text = string;
    if(textView.text.length >= count){
        [cell.textViewMsg scrollRangeToVisible:[cell.textViewMsg.text rangeOfString:toBeString]];
    }
    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(count-textView.text.length)];
    
    if (indexTag == 1)
    {
//        if (textView.text.length > 20) {
//            cell.textViewMsg.text = [textView.text substringToIndex:20];
//            cell.countCharacter.text = [NSString stringWithFormat:@"0字"];
//        }else
//        {
//            cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(20-textView.text.length)];
//        }
//        
//        
//        NSString *string = textView.text;
        self.model.school = textView.text;
    }else
    {
//        if (textView.text.length > 50) {
//            cell.textViewMsg.text = [textView.text substringToIndex:50];
//        }
//        cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(50-textView.text.length)];
//        
//        NSString *string = textView.text;
        self.model.work = textView.text;
        
    }
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [textView setContentOffset:CGPointZero];
    NSInteger indexTag = textView.tag - tagTextView;
    NSString *string = textView.text;
    if (indexTag == 1) {
        self.model.school = string;
    }else
    {
        self.model.work = string;
    }
}

- (BPProjectMsgCell *)cellForRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    BPProjectMsgCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell;
}


/**
 *  验证只有一个小数点,开头不为小数点
 *
 *  @param range  输入框范围
 *  @param string 输入的字符串
 *
 *  @return ~
 */
- (BOOL)authFloatNumberWithRange:(NSRange)range string:(NSString *)string andTefield:(UITextField *)tefield{
    if (range.location == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    if ([tefield.text rangeOfString:@"."].location != NSNotFound &&[string isEqualToString:@"."]) {
        return NO;
    }
    return YES;
}

- (void)dealloc{
    
}

- (void)saveAction
{
    [self.view endEditing:YES];
    
    NSString *messageAlert =nil;
    
    
    if (self.model.name.length < 2) {
        messageAlert = @"新成员姓名不少于两个字";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.position.length < 2) {
        messageAlert = @"新成员职位不少于两个字";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.holding.length < 1) {
        messageAlert = @"请填写所持股份";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.school.length < 1) {
        messageAlert = @"请填写毕业学校";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.work.length < 1) {
        messageAlert = @"请填写工作履历";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    UIImage *imageData = [UIImage imageNamed:@"bp_addPhoto"];
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:3 inSection:0];
    BPAddMemberCell2 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.image = cell.headImageView.image;
    
    if ([imageData isEqual:self.image]) {
        messageAlert = @"请上传新成员头像";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    [self postData];
}


- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}

#pragma mark -懒加载

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = BPbackColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - 记忆添加
- (void)backAction{
    
    [self.view endEditing:YES];
    if(!self.isUpdate){
        //编辑修改不进行保存
        //模型转字典
        NSDictionary *dict = [self.model mj_keyValues];
        //本地化存储
        [BusinessMemoryCacheTool memoryCacheTeamMembersWithDict:dict];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPTeamMemberModel *)model
{
    if (!_model) {
        
        
        NSDictionary *dict = [BusinessMemoryCacheTool teamMembers];
        
        if ([NewBPTeamMemberModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPTeamMemberModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPTeamMemberModel alloc]init];
        }
    }
    return _model;
}

- (void)postData
{
    self.saveBtn.enabled = NO;
    
    [KipoMyBusinessPlanViewModel addTeamMemberDataMID:self.model.mid modelData:self.model image:self.image success:^(id  json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            
            self.model = nil;
            self.model = [NewBPTeamMemberModel mj_objectWithKeyValues:dict[@"teamMember"]];

            if (self.saveNewTeamerModelBlock) {
                self.saveNewTeamerModelBlock(self.model);
            }
            [BusinessMemoryCacheTool cleanTeamMembersCache];
            [self.navigationController popViewControllerAnimated:YES];
            self.saveBtn.enabled = YES;
            return;
        }
        
        self.saveBtn.enabled = YES;
    } failure:^(NSError *error) {
        self.saveBtn.enabled = YES;
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
