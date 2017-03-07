//
//  FinancialPlansViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "FinancialPlansViewController.h"
#import "BPProjectMsgCell.h"
#import "FinancingSourceTableViewCell.h"
#import "FinancingSourceTwoTableViewCell.h"

#import "NewBPMoneyPlanModel.h"

#import "KipoMyBusinessPlanViewModel.h"
//#import ""
#import "BPCityMode.h"
#import "TRZXBusinessPlanHeader.h"
#import "BusinessMemoryCacheTool.h"


#define TagText 1231343
#define SecondTagTextField 320
#define HEIGTH(view) view.frame.size.height
#define WIDTH(view) view.frame.size.width



@interface FinancialPlansViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UIPickerView *sexPickerView;
    UIView *bigView;
    UIView *topActionView;
    UIView *actionView;
    UIButton *queRenBtn;
    UIButton *quXiaoBtn;
}

@property (nonatomic,strong)NSArray *finalType;//融资阶段
@property (nonatomic,copy)NSString *stageMid;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *attributeDataSource;
@property (nonatomic,strong)NSArray *heightArr;
@property (nonatomic,strong)NSMutableArray *textArray;
@property (nonatomic,strong)NSMutableArray *firstText;
@property (nonatomic,strong)NSMutableArray *secondText;


@property (nonatomic,assign)BOOL isScroll;

@end

@implementation FinancialPlansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self creataData];
    [self initData];
    [self createUI];
    [self createSexView];
    

}

- (void)setNaviBar
{
    self.title = @"融资计划";
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.saveBtn.hidden = NO;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
}
- (void)createUI
{
    [self.view addSubview:self.tableView];
}

#pragma mark - 请求融资阶段数据--------------
- (void)creataData{
    
//    [TZRAllModel  getTZRjieduanDataType:@"7" Success:^(id object) {
//        
//        if ([object[@"status_code"] isEqualToString:@"200"]) {
//            
//            self.finalType = [BPCityMode mj_objectArrayWithKeyValuesArray:object[@"data"]];
//            [sexPickerView reloadAllComponents];
//            [self.tableView reloadData];
//        }
//    } failure:^(NSError *error) {
//        
//        
//    }];
}

#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count +2;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        FinancingSourceTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"FinancingSourceTableViewCell" owner:self options:nil] firstObject];
        cell.firstView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPickerView)];
        [cell.firstView addGestureRecognizer:tap];
        
        BPCityMode *seleModle;
        if (self.finalType.count >0 ) {
            for (BPCityMode *model in self.finalType) {
                if ([model.mid isEqualToString:self.model.areaStage]) {
                    seleModle = model;
                }
            }
        }
        cell.stageLable.text = seleModle.name?seleModle.name:@"";
        
        cell.userCount.delegate = self;
        cell.userCount.text = self.model.num?self.model.num:@"";
        cell.guQuan.delegate = self;
        if ([self.model.stockPercentage isKindOfClass:[NSString class]]) {
            cell.guQuan.text = self.model.stockPercentage?self.model.stockPercentage:@"";////////
        }
        cell.timeLable.delegate = self;
        cell.timeLable.text = self.model.lifeCycle?self.model.lifeCycle:@"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        FinancingSourceTwoTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"FinancingSourceTwoTableViewCell" owner:self options:nil] firstObject];
        cell.textfield1.delegate = self;
        cell.textfield2.delegate = self;
        cell.textfield3.delegate = self;
        cell.textfield4.delegate = self;
        cell.textfield5.delegate = self;
        cell.textfield6.delegate = self;
        
        cell.textfield1.text = self.secondText[0];
        cell.textfield2.text = self.secondText[1];
        cell.textfield3.text = self.secondText[2];
        cell.textfield4.text = self.secondText[3];
        cell.textfield5.text = self.secondText[4];
        cell.textfield6.text = self.secondText[5];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        BPProjectMsgCell *cell = [[BPProjectMsgCell alloc]initWithTitle:self.dataSource[indexPath.row-2] PlaceHoder:self.attributeDataSource[indexPath.row-2] CountCharacter:@"90字" TextViewMsg:self.textArray[indexPath.row]];
        cell.textViewMsg.tag = TagText + indexPath.row;
        cell.textViewMsg.delegate = self;
        cell.textViewMsg.textColor = BPheizideColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heightArr[indexPath.row] floatValue];
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}
#pragma mark - textViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    NSInteger indexTag = textView.tag - TagText;
//    
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    if (string.length > 90) {
//        string = [string substringToIndex:90];
//    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger indexTag = textView.tag - TagText;
    
    BPProjectMsgCell *cell = [self cellForRow:indexTag];
    if ([textView.text length] == 0) {
        [cell.placeHoderLable setHidden:NO];
    }else{
        [cell.placeHoderLable setHidden:YES];
    }
//    if (textView.text.length > 90) {
//        cell.textViewMsg.text = [textView.text substringToIndex:90];
//    }
    
    NSInteger count = 90;

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
    if(textView.text.length >= count){
        [textView scrollRangeToVisible:[textView.text rangeOfString:toBeString]];
    }
//    cell.textViewMsg.text = string;
    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(count-textView.text.length)];
//
//    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(90-textView.text.length)];
//    
//    NSString *string = textView.text;
    [self.textArray replaceObjectAtIndex:indexTag withObject:textView.text];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSInteger indexTag = textView.tag - TagText;
    NSString *string = textView.text;
    [self.textArray replaceObjectAtIndex:indexTag withObject:string];
}

- (BPProjectMsgCell *)cellForRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    BPProjectMsgCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //   NSInteger index = textField.tag  - SecondTagTextField;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger index = textField.tag  - SecondTagTextField;
    NSString *string = textField.text;
    if (index < 3) {
        //第一个cell
        [self.firstText replaceObjectAtIndex:index withObject:string];
    }else
    {
        [self.secondText replaceObjectAtIndex:index-3 withObject:string];
    }
}
//设置输入的范围只能是数字 ，考虑粘贴的情况
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger index = textField.tag  - SecondTagTextField;
    if (index < 3) {
        NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        if (index == 1) {
            
            CGFloat a = [str floatValue];
            if (a > 100) {
                return NO;
            }
            if(str.length > 5){
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
        }else
        {
            if (str.length > 10) {
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
        }
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        CGFloat a = [str floatValue];
        if (a > 100) {
            return NO;
        }
        if(str.length > 5){
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
    }
    return YES;
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


- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


#pragma makr- pickView  相关---------------
- (void)createSexView
{
    bigView = [[UIView alloc] initWithFrame:self.view.frame];
    bigView.backgroundColor =[UIColor clearColor];
    bigView.userInteractionEnabled = NO;
    [self.view addSubview:bigView];
    actionView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGTH(self.view), WIDTH(self.view), 200)];
    actionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:actionView];
    sexPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 200)];
    sexPickerView.delegate = self;
    sexPickerView.dataSource = self;
    sexPickerView.showsSelectionIndicator = YES;
    [sexPickerView selectRow:0 inComponent:0 animated:YES];
    //    [sexPickerView selectRow:0 inComponent:1 animated:YES];
    [actionView addSubview:sexPickerView];
    quXiaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    quXiaoBtn.frame = CGRectMake(5, 7, 50, 25);
    [quXiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    [quXiaoBtn addTarget:self action:@selector(quxiaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [quXiaoBtn setTitleColor:BPTRZXMainColor forState:UIControlStateNormal];
    [actionView addSubview:quXiaoBtn];
    queRenBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [queRenBtn setTitle:@"完成" forState:UIControlStateNormal];
    [queRenBtn setTitleColor:BPTRZXMainColor forState:UIControlStateNormal];
    [queRenBtn addTarget:self action:@selector(queRenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    queRenBtn.frame = CGRectMake(WIDTH(self.view)-55, 7, 50, 25);
    [actionView addSubview:queRenBtn];
    
}

- (void)quxiaoBtnClick:(UIButton *)sender
{
    [self hidePickerView];
    
}

- (void)queRenBtnClick:(UIButton *)sender
{
    [sexPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    if (!self.isScroll) {
        BPCityMode *cityModel  = [self.finalType firstObject];
        self.model.areaStage = cityModel.mid;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        FinancingSourceTableViewCell *cell  = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.stageLable.text = cityModel.name;
    }
    
    [self hidePickerView];
    
}

-(void)showPickerView
{
    [self.view endEditing:YES];
    bigView.userInteractionEnabled = YES;
    self.isScroll = NO;
    [sexPickerView selectRow:0 inComponent:0 animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        bigView.backgroundColor = [UIColor blackColor];
        bigView.alpha = 0.6;
        actionView.frame = CGRectMake(0, HEIGTH(self.view)-HEIGTH(actionView), WIDTH(actionView), HEIGTH(actionView));
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hidePickerView
{
    bigView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        bigView.backgroundColor = [UIColor clearColor];
        actionView.frame = CGRectMake(0, HEIGTH(self.view), WIDTH(actionView), HEIGTH(actionView));
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - pikerView;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  self.finalType.count;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    BPCityMode *model = self.finalType[row];
    return model.name;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    pickerLabel = [[UILabel alloc] init];
    pickerLabel.font = [UIFont systemFontOfSize:17];
    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.isScroll = YES;
    BPCityMode *cityModel  = self.finalType[row];
    self.model.areaStage = cityModel.mid;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    FinancingSourceTableViewCell *cell  = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.stageLable.text = cityModel.name;
}
- (void)saveAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    NSString *messageAlert =nil;
    
    if (self.model.areaStage.length<1) {
        messageAlert = @"请选择融资轮次";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnFirstTextStringWithIndex:0].length < 1) {
        messageAlert = @"请填写用户数量";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnFirstTextStringWithIndex:1].length < 1) {
        messageAlert = @"请填写出让股权";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnFirstTextStringWithIndex:2].length < 1) {
        messageAlert = @"请填写使用周期";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    NSInteger count = 0;
    for (NSString *string in self.secondText) {
        if (string.length >0) {
            count ++;
        }
    }
    
    if (count < 3) {
        messageAlert = @"请填写至少三项数据";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    if ([self returnTextStringWithIndex:2].length <1) {
        messageAlert = @"请填写战略目标";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:3].length <1) {
        messageAlert = @"请填写达成策略";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:4].length <1) {
        messageAlert = @"请填写财务预测";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    [self postData];
}

- (NSString *)returnTextStringWithIndex:(NSInteger)index
{
    if (index < self.textArray.count) {
        return self.textArray[index];
    }
    return @"";
}

- (NSString *)returnFirstTextStringWithIndex:(NSInteger)index
{
    if (index < self.firstText.count) {
        return self.firstText[index];
    }
    return @"";
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}

- (void)changeModelValue{
    self.model.num = [self.firstText objectAtIndex:0];
    self.model.stockPercentage = [self.firstText objectAtIndex:1];
    self.model.lifeCycle = [self.firstText objectAtIndex:2];
    
    
    self.model.expansion = [self.secondText objectAtIndex:0];
    self.model.rent = [self.secondText objectAtIndex:1];
    self.model.office = [self.secondText objectAtIndex:2];
    self.model.extension = [self.secondText objectAtIndex:3];
    self.model.product = [self.secondText objectAtIndex:4];
    self.model.market = [self.secondText objectAtIndex:5];
    
    
    self.model.target = [self.textArray objectAtIndex:2];
    self.model.strategy = [self.textArray objectAtIndex:3];
    self.model.financialForecast = [self.textArray objectAtIndex:4];
}
#pragma mark - 上传数据---------~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)postData
{
    [self changeModelValue];
    
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel addMoneyPlanDataMID:nil modelData:self.model success:^(id json) {
        
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showInfoMsg:@"保存成功"]; // 显示提示

            if (self.saveFPBlock) {
                self.saveFPBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        self.saveBtn.enabled = YES;
    } failure:^(NSError *error) {
        self.saveBtn.enabled = YES;
    }];
    
    
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
        _tableView.estimatedRowHeight = 170;
        //        _tableView.tableHeaderView.backgroundColor = RGBA(235, 235, 241, 1);
    }
    return _tableView;
}

- (void)initData
{
    _dataSource = @[
                    @"战略目标 *",
                    @"达成策略 *",
                    @"财务预测 *",
                    ];
    _attributeDataSource = @[
                             @"例:3年内在北京市海淀区、朝阳区、丰台区新开设情商培训分校5家，单体店使用面积200平米左右、教职人员5人~7人。",
                             @"例:结合开设望京分校已有的经验，进行市场调研，根据各区的招生摸牌情况，合理选定校址。",
                             @"例:未来一年内将在崇文门国瑞城新设一家店，参照广渠门总校和望京分校的数据，以及市场调研情况，招生情况约300~400名，人均消费7500~10000元，营收250~300万左右，其他两家门店年均保持12%的营收增长率，由此推算，三家门店总计营收将达到800~850万。",
                             ];
    _heightArr = @[@"194",@"162",@"175",@"175",@"175"];
}
//填写信息
//填写信息
- (NSMutableArray *)textArray
{
    if (!_textArray) {
        NSString *target = self.model.target?self.model.target:@""; //战略目标
        NSString *strategy = self.model.strategy?self.model.strategy:@"";//达成策略
        NSString *financialForecast = self.model.financialForecast?self.model.financialForecast:@"";//财务预测
        _textArray = [NSMutableArray arrayWithArray:@[@"",@"",target,strategy,financialForecast]];
    }
    return _textArray;
}

- (NSMutableArray *)firstText
{
    if (!_firstText) {
        
        //        NSString *areaStage = self.model.areaStage?self.model.areaStage:@"";
        NSString *num = self.model.num?self.model.num:@"";
        NSString *stockPercentage = self.model.stockPercentage?self.model.stockPercentage:@"";
        NSString *lifeCycle = self.model.lifeCycle?self.model.lifeCycle:@"";
        
        _firstText = [NSMutableArray arrayWithArray:@[num,stockPercentage,lifeCycle]];
    }
    return _firstText;
}

- (NSMutableArray *)secondText
{
    if (!_secondText) {
        
        NSString *expansion = self.model.expansion?self.model.expansion:@"";
        NSString *rent = self.model.rent?self.model.rent:@"";
        NSString *office = self.model.office?self.model.office:@"";
        NSString *extension = self.model.extension?self.model.extension:@"";
        NSString *product = self.model.product?self.model.product:@"";
        NSString *market= self.model.market?self.model.market:@"";
        
        _secondText = [NSMutableArray arrayWithArray:@[expansion,rent,office,extension,product,market]];
    }
    return _secondText;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 记忆添加
- (void)backAction{
    
    [self.view endEditing:YES];
    
    [self changeModelValue];
    //模型转字典
    NSDictionary *dict = [self.model mj_keyValues];
    //本地化存储
    [BusinessMemoryCacheTool memoryCacheFinancialPlansWithDict:dict];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPMoneyPlanModel *)model
{
    if (!_model) {
        
        NSDictionary *dict = [BusinessMemoryCacheTool FinancialPlans];
        
        if ([NewBPMoneyPlanModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPMoneyPlanModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPMoneyPlanModel alloc]init];
        }
    }
    return _model;
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
