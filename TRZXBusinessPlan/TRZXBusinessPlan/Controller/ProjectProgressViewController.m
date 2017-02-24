//
//  ProjectProgressViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#define TagText 64637
#define tagTextField 344

#import "ProjectProgressViewController.h"
#import "BPProjectMsgCell.h"
#import "BPProFirstTableViewCell.h"
#import "BPProSecondsTableViewCell.h"
#import "BPSelectInfoTableViewCell.h"

#import "KipoMyBusinessPlanViewModel.h"
#import "NewBPProjectProgressModel.h"

#import "BPProShowViewController.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "BusinessMemoryCacheTool.h"
#import "TRZXBusinessPlanHeader.h"

@interface ProjectProgressViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *attributeDataSource;
@property (nonatomic,strong)NSArray *heightArr;
@property (nonatomic,strong)NSArray *progressType;

@property (nonatomic,strong)NSMutableArray *textArray;

@property (nonatomic,assign)NSInteger selectedCount;//选填个数
@property (nonatomic,assign)NSInteger selectedIndex;//项目进度

@property (nonatomic,assign)CGFloat keyboardHeight;
@property (nonatomic,assign)BOOL keyboardIsDown;


@property (nonatomic,strong)NSMutableArray *secondText;


@end

@implementation ProjectProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self initData];
    [self createUI];
    
}


- (void)setNaviBar
{
    self.mainTitle.text = @"项目进展";
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.saveBtn.hidden = NO;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
    
}
- (void)createUI
{
    _progressType = @[@"planning",@"development",@"finalize",@"havecustomer"];
    [self.view addSubview:self.tableView];
}

#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count+1;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3) {
        BPProjectMsgCell *cell = [[BPProjectMsgCell alloc]initWithTitle:_dataSource[indexPath.row] PlaceHoder:_attributeDataSource[indexPath.row] CountCharacter:@"90字" TextViewMsg:self.textArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textViewMsg.delegate = self;
        cell.textViewMsg.textColor = BPheizideColor;
        cell.textViewMsg.tag = TagText+indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 0)
    {
        BPProFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ssss"];
        if (cell == nil) {
            cell = [[BPProFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ssss"];
            cell.title = @"项目进度 *";
            cell.titleArray = @[@"产品规划中",@"产品开发中",@"产品已定型",@"已经有客户"];
        }
        
        NSInteger index = [self.progressType indexOfObject:self.model.progress];
        if (index<self.progressType.count && index >= 0) {
            cell.selecteIndex = [self.progressType indexOfObject:self.model.progress];
            self.selectedIndex = cell.selecteIndex;
        }
        
        cell.clickBlock = ^(NSInteger index)
        {
            self.selectedIndex = index;
            self.model.progress = self.progressType[index];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        BPProSecondsTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BPProSecondsTableViewCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userConut.delegate = self;
        cell.richangHuoYue.delegate = self;
        cell.xiaoshouLiang.delegate = self;
        cell.yingyeE.delegate = self;
        cell.monthLiRun.delegate = self;
        cell.shopCount.delegate = self;
        
        [cell.userConut addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.richangHuoYue addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.xiaoshouLiang addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.yingyeE addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.monthLiRun addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.shopCount addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        
        cell.userConut.text = [self.secondText objectAtIndex:0];
        cell.richangHuoYue.text = [self.secondText objectAtIndex:1];
        cell.xiaoshouLiang.text = [self.secondText objectAtIndex:2];
        cell.yingyeE.text = [self.secondText objectAtIndex:3];
        cell.monthLiRun.text = [self.secondText objectAtIndex:4];
        cell.shopCount.text =[self.secondText objectAtIndex:5];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4)
    {
        BPSelectInfoTableViewCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"BPSelectInfoTableViewCell" owner:self options:nil] firstObject];
        cell.titleLable.text = @"项目里程碑 *";
        cell.title =  @"ss";
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
    return [self.heightArr[indexPath.row] floatValue];
}



#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textChanged:(UITextField *)textField
{
    
//    if (textfield.text.length <= 30) {
//    } else {
//        NSString *subText = [textfield.text substringToIndex:30];
//        textfield.text = subText;
//    }
//    
//    if ([textField isEqual:self.nameTF])
//    {
//        count = 10;
//    }else if ([textField isEqual:self.positionTF])
//    {
//        count = 20;
//    }
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    NSInteger count = 20;
    
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
//    textField.text = toBeString;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger index = textField.tag - tagTextField;
    [self saveTextWithIndex:index string:textField.text];
}
- (void)saveTextWithIndex:(NSInteger)index string:(NSString *)string
{
    [self.secondText replaceObjectAtIndex:index withObject:string];
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
//    
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
//    if (textView.text.length > 90) {
//        cell.textViewMsg.text = [textView.text substringToIndex:90];
//    }
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

- (void)saveAction
{
    [self.view endEditing:YES];
    self.selectedCount = 0;
    NSString *messageAlert =nil;
    
    if (self.selectedIndex < 0) {
        messageAlert = @"请填写项目进度";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    NSInteger count = 0;
    for (NSString *string in self.secondText) {
        if (string.length > 1) {
            count++;
        }
    }
    if (count < 3) {
        messageAlert = @"请至少填写三项数据";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    if ([self returnTextStringWithIndex:2].length > 1) {
        self.selectedCount ++;
    }
    if ([self returnTextStringWithIndex:3].length > 1) {
        self.selectedCount ++;
    }
    
    if (self.projectMsg.count < 1) {
        messageAlert = @"请填写项目里程碑";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    //    [self alertWithTitle:[NSString stringWithFormat:@"选填项填写了%ld项",(long)self.selectedCount] message:@"可以保存啦~~~~~"];
    [self postData];
}
- (void)changeModelValue{
    
    if (self.selectedIndex < self.progressType.count && self.selectedIndex >= 0) {
        self.model.progress = self.progressType[self.selectedIndex];
    }
    self.model.total = [self.secondText objectAtIndex:0];
    self.model.active = [self.secondText objectAtIndex:1];
    self.model.monthlynumber = [self.secondText objectAtIndex:2];
    self.model.monthlTotal = [self.secondText objectAtIndex:3];
    self.model.monthlySales = [self.secondText objectAtIndex:4];
    self.model.numberOfStores = [self.secondText objectAtIndex:5];
    
    self.model.marketShare = [self.textArray objectAtIndex:2];
    self.model.businessDevelopment = [self.textArray objectAtIndex:3];
    
}


- (NSString *)returnTextStringWithIndex:(NSInteger)index
{
    if (index < self.textArray.count) {
        return self.textArray[index];
    }
    return @"";
}
- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}

- (void)initData
{
    self.selectedIndex = -9;
    _dataSource = @[@"项目进度 *",
                    @"",
                    @"市场份额",
                    @"业务拓展",
                    @"项目里程碑"
                    ];
    
    _attributeDataSource = @[@"",
                             @"",
                             @"例:我们2015年均培训学员共计约600名，在仅有望京、广渠门两家店的情况下，已占北京市总体情商培训市场份额约15%",
                             @"例:与我们联合开展儿童情商讲座活动的北京市区初中6家、小学9家、少年宫两家、读书中心2家。",
                             @""
                             ];
    _heightArr = @[@"86",@"170",@"150",@"150",@"49",@"170"];
}
//填写信息
- (NSMutableArray *)textArray
{
    if (!_textArray) {
        
        NSString *progress = self.model.progress?self.model.progress:@"";
        
        NSString *marketShare = self.model.marketShare?self.model.marketShare:@"";
        NSString *businessDevelopment = self.model.businessDevelopment?self.model.businessDevelopment:@"";
        
        _textArray = [NSMutableArray arrayWithArray:@[progress,@"",marketShare,businessDevelopment,@""]];
    }
    return _textArray;
}
- (NSMutableArray *)secondText
{
    if (!_secondText) {
        
        NSString *total = self.model.total?self.model.total:@"";
        NSString *active = self.model.active?self.model.active:@"";
        NSString *monthlynumber = self.model.monthlynumber?self.model.monthlynumber:@"";
        NSString *monthlTotal = self.model.monthlTotal?self.model.monthlTotal:@"";
        NSString *monthlySales = self.model.monthlySales?self.model.monthlySales:@"";
        NSString *numberOfStores= self.model.numberOfStores?self.model.numberOfStores:@"";
        
        _secondText = [NSMutableArray arrayWithArray:@[total,active,monthlynumber,monthlTotal,monthlySales,numberOfStores]];
    }
    return _secondText;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = BPbackColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView.backgroundColor = BPRGBA(235, 235, 241, 1);
    }
    return _tableView;
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
    [BusinessMemoryCacheTool memoryCacheProjectProgressWithDict:dict];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPProjectProgressModel *)model
{
    if (!_model) {
        
        
        NSDictionary *dict = [BusinessMemoryCacheTool ProjectProgress];
        
        if ([NewBPProjectProgressModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPProjectProgressModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPProjectProgressModel alloc]init];
        }
    }
    return _model;
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 4) {
        BPProShowViewController *vc = [[BPProShowViewController alloc]init];
        
        //        if (self.projectMsg.count == 0) {
        //            // 读取本地数据
        //            vc.dataSource = [[BusinessMemoryCacheTool ProjectProgressAllEvent] mutableCopy];
        //        }else{
        
        vc.dataSource = self.projectMsg;
        //        }
        __weak ProjectProgressViewController *weakself = self;
        vc.saveModleBlock = ^(NSMutableArray *array)
        {
            weakself.projectMsg = array;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 上传数据---------~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)postData
{
    [self changeModelValue];
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel addProgressModelDataMID:nil modelData:self.model success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showInfoMsg:@"保存成功"]; // 显示提示
            if (self.saveSuccessPP) {
                NSString *str = [NSString stringWithFormat:@"%ld/3",(long)self.selectedCount];
                self.saveSuccessPP(str);
            }
            self.saveBtn.enabled = YES;
            [BusinessMemoryCacheTool cleanProjectProgressEventAllCache];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        self.saveBtn.enabled = YES;
        
        
    } failure:^(NSError *error) {
//        [LCProgressHUD showInfoMsg:@"网络异常"];
        self.saveBtn.enabled = YES;
    }];
    
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
