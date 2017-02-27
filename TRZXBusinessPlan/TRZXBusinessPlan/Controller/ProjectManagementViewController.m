//
//  ProjectManagementViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "ProjectManagementViewController.h"

#import "MyBusinessListTableViewCell.h"
#import "BPProjectCommentTableViewCell.h"
#import "BPSelectInfoTableViewCell.h"
#import "BPProjectMsgCell.h"

#import "BPTradeInfoCollectionViewCell.h"

#import "KipoMyBusinessPlanViewModel.h"
#import "NewBPProjectAbsModel.h"
#import "BPLableMonle.h"
#import "BPTagCollectionLayout.h"

#import "BusinessMemoryCacheTool.h"
#import "TRZXBusinessPlanHeader.h"

#import "CTMediator+TradeInfo.h"

@interface ProjectManagementViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,BPTagCollectionLayoutDelegate>{
    
    BPProjectCommentTableViewCell *cellTime;
    BPProjectMsgCell *firstCell;
    
    NSString *proName;//项目名称
    NSString *teamCount;//团队人数
    NSString *DateStr;//时间
    NSString *trades;
    BPTagCollectionLayout *tagLayout;
}

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UITableView      *tableView;
@property (nonatomic,strong) UIDatePicker     *datePicker;
@property (nonatomic,strong) UIView           *datePickerView;

@end

@implementation ProjectManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviBar];
    [self createUI];
    
}
- (void)setNaviBar
{
    self.mainTitle.text       = @"项目概述";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.saveBtn.hidden       = NO;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
}
- (void)createUI
{
    [self.view addSubview:self.tableView];
}
#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //项目名称
        BPProjectMsgCell *cell       = [[BPProjectMsgCell alloc]initWithTitle:@"项目名称 *" PlaceHoder:@"例如:读书郎情商教育培训机构" CountCharacter:@"20字" TextViewMsg:self.model.name];
        cell.selectionStyle        = UITableViewCellSelectionStyleNone;
        cell.textViewMsg.delegate  = self;
        cell.textViewMsg.textColor = BPheizideColor;
        cell.textViewMsg.returnKeyType = UIReturnKeyDone;
        firstCell                  = cell;
        return cell;
    }else if (indexPath.row == 1)
    {//团队人数
        BPProjectCommentTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BPProjectCommentTableViewCell" owner:self options:nil] firstObject];
        cell.teamCountLable.delegate        = self;
        cell.teamCountLable.textColor       = BPheizideColor;
        [cell.teamCountLable addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
        cell.teamCountLable.placeholder = @"例:20";
        cell.teamCountLable.text            = self.model.number;
        cell.stratDateStr                   = self.model.startDate;
        cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
        
        __weak __typeof(self)weakSelf = self;
        cell.dateButtonClick                = ^()
        {
            [weakSelf.view endEditing:YES];
            [weakSelf presentDatePicker];
        };
        cellTime                            = cell;
        return cell;
    }else if (indexPath.row == 2)
    { //创建时间
        BPSelectInfoTableViewCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"BPSelectInfoTableViewCell" owner:self options:nil] firstObject];
        cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row == 3)
    { //行业领域
        UITableViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell                                = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"colll"];
        }
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        [cell.contentView addSubview:self.collectionView];
        [self.collectionView reloadData];
        cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        return 115;
    }else if (indexPath.row == 1)
    {
        return 163;
    }else if (indexPath.row == 3)
    {
        if (self.dataArr.count == 0) {
            return 0;
        }else
        {
            return 450;
        }
    }
    return 46;
}
#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    [self hideDatePicker];
    if (indexPath.row == 2 || indexPath.row == 3) {
        
        __weak __typeof(self)weakSelf = self;
        UIViewController *vc = [[CTMediator sharedInstance]selectTradeWithType:3 mid:@"" selectedTrade:self.dataArr Complete:^(NSArray *tradeInfoArr, NSString *trade) {
        weakSelf.dataArr                     = tradeInfoArr;
        trades                               = trade;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];

        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.collectionView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self hideDatePicker];
}

#pragma mark - 编辑框处理相关```````````````````````````
#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hideDatePicker];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    cellTime.teamCountLable.text = textField.text;
    self.model.number = textField.text;
}
//设置输入的范围只能是数字 ，考虑粘贴的情况
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self validateNumber:string];
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res               = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i                  = 0;
    while (i < number.length) {
        NSString * string      = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range          = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res                = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)textFieldChange:(UITextField *)textField{


    if (textField.text.length > 8) {
        textField.text = [textField.text substringToIndex:8];
    }
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}




#pragma mark- collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return self.dataArr.count;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    __weak ProjectManagementViewController *weakSelf = self;
//    TRHelpInfoTypeViewController *tradeInfo = [[TRHelpInfoTypeViewController alloc]init];
//    tradeInfo.type = HelpInfoType_Business;
//    tradeInfo.enterButtonClickBlock = ^(NSArray *tradeInfoArr,NSString *trade)
//    {
//        weakSelf.dataArr = tradeInfoArr;
//        trades = trade;
//        [weakSelf.collectionView reloadData];
//    };
//    if (self.dataArr == nil || self.dataArr.count == 0) {
//        tradeInfo.seletedTrade = [[NSMutableArray alloc]init];
//    }else{
//        tradeInfo.seletedTrade = [[NSMutableArray alloc]initWithArray:self.dataArr];
//    }
//    
//    [self.navigationController pushViewController:tradeInfo animated:YES];
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BPTradeInfoCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPTradeInfoCollectionViewCell" forIndexPath:indexPath];
    cell.button.enabled                  = NO;
    BPLableMonle *model                    = _dataArr[indexPath.item];
    NSString *str                        = model.trade;
    [cell.button setTitle:str forState:UIControlStateNormal];
    //        cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.layer.cornerRadius  = 4;
    cell.contentView.layer.masksToBounds = YES;
    return cell;
    
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//        return UIEdgeInsetsMake(10, 10, 10, 10);
//
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//      lableMonle *model = _dataArr[indexPath.item];
//      NSString *str = model.trade;
//     CGSize detailSize = [self sizeWithString:str fontSize:14];
//     return CGSizeMake(detailSize.width+10, 40);
//
//}
////计算字体大小
//- (CGSize)sizeWithString:(NSString *)str fontSize:(float)fontSize
//{
//    CGSize constraint = CGSizeMake(self.view.width , fontSize + 1);
//
//    CGSize tempSize;
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
//    CGSize retSize = [str boundingRectWithSize:constraint
//                                       options:
//                      NSStringDrawingUsesLineFragmentOrigin
//                                    attributes:attribute
//                                       context:nil].size;
//    tempSize = retSize;
//
//    return tempSize ;
//}

#pragma mark  ------- BPTagCollectionLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(BPTagCollectionLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        BPLableMonle *model = self.dataArr[indexPath.item];
        NSString *itemStr = model.trade;
        
        CGSize size = CGSizeZero;
        size.height = 40;
        //计算字的width 这里主要font 是字体的大小
        CGSize temSize = [self sizeWithString:itemStr fontSize:14];
        size.width = temSize.width + 20 + 1; //20为左右空10
        
        return size.width;
    }else{
        return 90.0f;
    }
}
- (CGSize)sizeWithString:(NSString *)str fontSize:(float)fontSize
{
    CGSize constraint = CGSizeMake(self.view.frame.size.width , fontSize + 1);
    
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize retSize = [str boundingRectWithSize:constraint
                                       options:
                      NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attribute
                                       context:nil].size;
    tempSize = retSize;
    
    return tempSize ;
}


#pragma mark - 时间选择器相关
/**
 *  显示 pickerView
 */
-(void)presentDatePicker{
    
    [self.datePicker setDate:[NSDate date] animated:YES];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    DateStr = [outputFormatter stringForObjectValue:self.datePicker.date];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.datePickerView.frame = CGRectMake(0, BPSCREEN_HEIGHT - 180, BPSCREEN_WIDTH, 180);
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
    self.model.startDate = DateStr;
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
        
        self.datePickerView.frame = CGRectMake(0, BPSCREEN_HEIGHT, BPSCREEN_WIDTH, 0);
    }];
    
}
#pragma mark -textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    firstCell.placeHoderLable.hidden = YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.view endEditing:YES];
    self.model.name =  textView.text;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([textView.text length] == 0) {
        [firstCell.placeHoderLable setHidden:NO];
    }else{
        [firstCell.placeHoderLable setHidden:YES];
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
//    firstCell.textViewMsg.text = toBeString;
    if(textView.text.length >= 20){
        [textView scrollRangeToVisible:[textView.text rangeOfString:toBeString]];
    }
    if (toBeString.length <= 20) {
        firstCell.countCharacter.text = [NSString stringWithFormat:@"%lu字",20-textView.text.length];
    }else{
        firstCell.countCharacter.text = @"0字";
    }
    self.model.name =  textView.text;
}




#pragma mark - 保存按钮点击事件
-(void)saveAction
{
    [self.view endEditing:YES];
    self.model.name =  firstCell.textViewMsg.text;
    self.model.number = cellTime.teamCountLable.text;
    
    NSString *messageAlert =nil;
    if (self.model.name.length  < 2 ) {
        messageAlert = @"项目名称不少于两个字";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.number.length  < 1 ) {
        messageAlert = @"请填写团队人数";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self.model.number integerValue]<1) {
        messageAlert = @"请正确填写团队人数";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.startDate.length  < 1 ) {
        messageAlert = @"请填写创建时间";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.dataArr.count  < 1 ) {
        messageAlert = @"请选择行业领域";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    [self postData];
}


#pragma mark - 上传数据
- (void)postData
{
    NSMutableString *string = [[NSMutableString alloc]init];
    
    for (BPLableMonle *model in self.dataArr) {
        [string appendString:[NSString stringWithFormat:@"%@,",model.mid]];
    }
    trades = string;
    
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel addProjectManagementDataMID:@"" planName:self.model.name num:self.model.number creatData:self.model.startDate tradeIds:trades success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showInfoMsg:@"保存成功"]; // 显示提示
            
            if (self.saveSuccessPM) {
                self.saveSuccessPM();
            }
            self.saveBtn.enabled = YES;
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        self.saveBtn.enabled = YES;
        
    } failure:^(NSError *error) {
//        [LCProgressHUD showInfoMsg:@"网络异常"];
        self.saveBtn.enabled = YES;
    }];
    
}


#pragma mark - setter/getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView.backgroundColor = BPbackColor;
    }
    return _tableView;
}

-(UIView *)datePickerView{
    
    if (!_datePickerView) {
        
        _datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, BPSCREEN_HEIGHT, BPSCREEN_WIDTH, 0)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 20, BPSCREEN_WIDTH, 160)];
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        datePicker.date = [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
        
        [datePicker setDate:[NSDate date] animated:NO];
        
        [datePicker addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventValueChanged];
        
        //        datePicker.maximumDate = [NSDate date];
        
//        NSDateComponents *dc = [[NSDateComponents alloc]init];
        
        
//        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        
//        NSDate *currentDate = [NSDate date];
        
        NSDateComponents *comps = [[NSDateComponents alloc]init];
        
//        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:NSCalendarWrapComponents];
        
        [comps setDay:7];
        
        
//        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        //        [_datePicker setMaximumDate:maxDate];
        
        //        [_datePicker setMinimumDate:minDate];
        
        self.datePicker = datePicker;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(BPSCREEN_WIDTH - 60, 0, 40, 40)];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button setTitleColor:BPTRZXMainColor forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *buttonCancle = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 40, 40)];
        
        [buttonCancle setTitle:@"取消" forState:UIControlStateNormal];
        
        buttonCancle.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [buttonCancle setTitleColor:BPTRZXMainColor forState:UIControlStateNormal];
        
        [buttonCancle addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_datePickerView addSubview:datePicker];
        [_datePickerView addSubview:buttonCancle];
        [_datePickerView addSubview:button];
        
        [self.view addSubview:self.datePickerView];
    }
    return _datePickerView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        tagLayout = [[BPTagCollectionLayout alloc] init];
        tagLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        tagLayout.lineSpacing = 10;
        tagLayout.itemSpacing = 10;
        tagLayout.itemHeigh = 30;
        tagLayout.delegate = self;
        
        // UICollectionViewFlowLayout *flowLay = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, BPSCREEN_WIDTH, 450) collectionViewLayout:tagLayout];
        _collectionView.backgroundColor = BPbackColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"BPTradeInfoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BPTradeInfoCollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark - 记忆添加
- (void)backAction{
    
    [self.view endEditing:YES];
    
    //模型转字典
    NSDictionary *dict = [self.model mj_keyValues];
    //本地化存储
    [BusinessMemoryCacheTool memoryCacheProjectAbsWithDict:dict];
    
    //存储领域数组
    [BusinessMemoryCacheTool memoryCacheProjectAbsTradeinfos:_dataArr];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPProjectAbsModel *)model
{
    if (!_model) {
        
        
        NSDictionary *dict = [BusinessMemoryCacheTool ProjectAbs];
        
        if ([NewBPProjectAbsModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPProjectAbsModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPProjectAbsModel alloc]init];
        }
    }
    return _model;
}

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [BusinessMemoryCacheTool tradeinfos];
    }
    return _dataArr;
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
