//
//  BPAddNewThinkViewController.m
//
//
//  Created by Alen on 16/5/7.
//
//

#import "BPAddNewThinkViewController.h"
#import "ProjectMsgCell2.h"
#import "BPProjectMsgCell.h"
#import "NewMyProjectModel.h"
#import "BusinessMemoryCacheTool.h"

#import "TRZXBusinessPlanHeader.h"


@interface BPAddNewThinkViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    NSString *DateStr;//时间
    ProjectMsgCell2 *cellTime;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIView *datePickerView;

@end

@implementation BPAddNewThinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self addUI];
    //    [self addNotifi];
}


- (void)setNaviBar
{
    
    self.mainTitle.text = @"添加新事件";
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
    return 2;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ProjectMsgCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProjectMsgCell2" owner:self options:nil] firstObject];
        }
        cellTime = cell;
        cell.stratDateStr = self.model.dynamicDate;
        [cell.dateButton addTarget:self action:@selector(presentDatePicker) forControlEvents:UIControlEventTouchUpInside];
        cell.titleLabel.text = @"发生时间";
        cell.stratDateStr = self.model.dynamicDate;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        BPProjectMsgCell *cell = [[BPProjectMsgCell alloc]initWithTitle:@"事件详情" PlaceHoder:@"例:2013年联合央视少儿频道召开7场、共计4000人参加的儿童情商讲座." CountCharacter:@"20字" TextViewMsg:self.model.abstractz];
        cell.textViewMsg.delegate = self;
        cell.textViewMsg.textColor = heizideColor;
//        cell.textViewMsg.returnKeyType = UIReturnKeyDone;
        cell.contentView.backgroundColor = backColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    return [UITableViewCell new];
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        [self presentDatePicker];
    }else
    {
        [self hideDatePicker];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }else if (indexPath.row == 1)
    {
        return 120;
    }
    return 0;
}

#pragma mark -textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    BPProjectMsgCell *cell = [self cellForRow];
    cell.placeHoderLable.hidden = YES;
}

- (BPProjectMsgCell *)cellForRow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    BPProjectMsgCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    if (string.length > 20) {
//        return NO;
//        // string = [string substringToIndex:20];
//    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.model.abstractz = textView.text;
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    BPProjectMsgCell *cell = [self cellForRow];
    if ([textView.text length] == 0) {
        [cell.placeHoderLable setHidden:NO];
    }else{
        [cell.placeHoderLable setHidden:YES];
    }

    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 20) {
                textView.text = [toBeString substringToIndex:20];
            }
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > 20) {
            textView.text = [toBeString substringToIndex:20];
        }
    }
//    cell.textViewMsg.text = toBeString;
    if (toBeString.length <= 20) {
        cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",20-toBeString.length];
    }else{
        cell.countCharacter.text = @"0字";
    }
    if(cell.textViewMsg.text.length >= 20){
        [cell.textViewMsg scrollRangeToVisible:[cell.textViewMsg.text rangeOfString:toBeString]];
    }
    
    self.model.abstractz = textView.text;
}
//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:RGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}
#pragma mark - 时间选择器相关
/**
 *  显示 pickerView
 */
-(void)presentDatePicker{
    [self.view endEditing:YES];
    
    [self.datePicker setDate:[NSDate date] animated:YES];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    DateStr = [outputFormatter stringForObjectValue:self.datePicker.date];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.datePickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 180, SCREEN_WIDTH, 180);
    }];
}

/**
 *  selectDate 选择时间
 */
-(void)selectDate{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str = [outputFormatter stringFromDate:self.datePicker.date];
    DateStr = str;
   
    
}
/**
 *  确定按钮
 *
 */
-(void)selectClick:(UIButton *)button{
    
    [self hideDatePicker];
    if (DateStr == nil) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
        [outputFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *date = [NSDate date];
        NSString *str = [outputFormatter stringFromDate:date];
        DateStr = str;
    }
    cellTime.stratDateStr = DateStr;
    self.model.dynamicDate = DateStr;
}
/**
 *  取消按钮
 *
 */
-(void)cancelClick:(UIButton *)button{
    [self hideDatePicker];
}

/**
 *  隐藏 pickerView
 */
-(void)hideDatePicker{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.datePickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    }];
    
}
#pragma mark -懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = backColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIView *)datePickerView{
    if (!_datePickerView) {
        
        _datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 160)];
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        datePicker.date = [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
        
        [datePicker setDate:[NSDate date] animated:NO];
        
        [datePicker addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventValueChanged];
        
        //        datePicker.maximumDate = [NSDate date];
        
//        NSDateComponents *dc = [[NSDateComponents alloc]init];
//        
//        
//        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//        
//        NSDate *currentDate = [NSDate date];
//        
//        NSDateComponents *comps = [[NSDateComponents alloc]init];
//        
//        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:NSCalendarWrapComponents];
//        
//        [comps setDay:7];
//        
//        
//        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        //        [_datePicker setMaximumDate:maxDate];
        
        //        [_datePicker setMinimumDate:minDate];
        
        self.datePicker = datePicker;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 0, 40, 40)];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button setTitleColor:TRZXMainColor forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *buttonCancle = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 40, 40)];
        
        [buttonCancle setTitle:@"取消" forState:UIControlStateNormal];
        
        buttonCancle.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [buttonCancle setTitleColor:TRZXMainColor forState:UIControlStateNormal];
        
        [buttonCancle addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_datePickerView addSubview:datePicker];
        [_datePickerView addSubview:buttonCancle];
        [_datePickerView addSubview:button];
        
        [self.view addSubview:self.datePickerView];
    }
    return _datePickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{

}

#pragma mark - 记忆添加
- (void)backAction{
    
    [self.view endEditing:YES];
    
    if(!self.isUpdate){
        //编辑修改不进行保存
        //模型转字典
        NSDictionary *dict = [self.model mj_keyValues];
        //本地化存储
        [BusinessMemoryCacheTool memoryCacheProjectProgressEventWithDict:dict];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (DynamicList *)model
{
    if (!_model) {
        
        
        NSDictionary *dict = [BusinessMemoryCacheTool ProjectProgressEvent];
        
        if ([DynamicList mj_objectWithKeyValues:dict]) {
            _model = [DynamicList mj_objectWithKeyValues:dict];
        }else{
            _model = [[DynamicList alloc]init];
        }
    }
    return _model;
}
#pragma makr  保存````````````````````````
- (void)saveAction
{
    NSString *messageAlert =nil;
    NSString *time =  self.model.dynamicDate;
    if (time.length<1) {
        messageAlert = @"请填写发生时间";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.abstractz.length <1) {
        messageAlert = @"请填写事件详情";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    if (self.textModleBlock) {
        self.textModleBlock(self.model);
    }
    
    [BusinessMemoryCacheTool cleanProjectProgressEventCache];
    
    [self.navigationController popViewControllerAnimated:YES];
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
