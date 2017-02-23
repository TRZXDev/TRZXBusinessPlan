//
//  MarketAnalysisViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "MarketAnalysisViewController.h"
#import "BPProjectMsgCell.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "NewBPMarketAnalysisModel.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "BusinessMemoryCacheTool.h"

#import "TRZXBusinessPlanHeader.h"

#define TagText 644766
@interface MarketAnalysisViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *attributeSource;

@property (nonatomic,strong)NSMutableArray *textArray;

@property (nonatomic,assign)BOOL isUp;
@property (nonatomic,assign)NSInteger selectedCount;//选填个数

@end

@implementation MarketAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self initData];
    [self addUI];

    
}
- (void)setNaviBar
{
    self.mainTitle.text = @"市场分析";
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
    return self.dataSource.count +1;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPProjectMsgCell *cell       = nil;
    if (indexPath.row == 0) {
        cell                       = [[BPProjectMsgCell alloc]initWithTitle:self.dataSource[indexPath.row] PlaceHoder:self.attributeSource[indexPath.row] CountCharacter:@"30字" TextViewMsg:self.textArray[indexPath.row]];
        cell.textViewMsg.tag       = TagText + indexPath.row;
        cell.textViewMsg.delegate  = self;
        cell.textViewMsg.textColor = heizideColor;
        cell.selectionStyle        = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row < self.dataSource.count)
    {
        cell                       = [[BPProjectMsgCell alloc]initWithTitle:self.dataSource[indexPath.row] PlaceHoder:self.attributeSource[indexPath.row] CountCharacter:@"90字" TextViewMsg:self.textArray[indexPath.row]];
        cell.textViewMsg.tag       = TagText + indexPath.row;
        cell.textViewMsg.delegate  = self;
        cell.textViewMsg.textColor = heizideColor;
        cell.selectionStyle        = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cells     = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cells) {
        cells                      = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cells.selectionStyle       = UITableViewCellSelectionStyleNone;
    cells.backgroundColor      = backColor;
    return cells;
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
    
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    
//    if (indexTag == 0) {
//        
//        if (string.length > 30) {
//            string = [string substringToIndex:30];
//            return NO;
//        }
//        return YES;
//    }
//    
//    if (string.length > 90) {
//        string = [string substringToIndex:90];
//        return NO;
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
    if (indexTag == 0) {
        count  = 30;
    }else
    {
        count = 90;
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
        [textView scrollRangeToVisible:[textView.text rangeOfString:toBeString]];
    }
    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(count-textView.text.length)];
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
    self.selectedCount     = 0;
    NSString *messageAlert = nil;
    
    if ([self returnTextStringWithIndex:0].length < 1) {
        messageAlert           = @"请填写目标用户";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:1].length < 1) {
        messageAlert           = @"请填写用户痛点";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:2].length < 1) {
        messageAlert           = @"请填写用户数量";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:3].length < 1) {
        messageAlert           = @"请填写消费总额";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:4].length < 1) {
        messageAlert           = @"请填写发展前景";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    if ([self returnTextStringWithIndex:5].length > 1) {
        self.selectedCount ++;
    }
    if ([self returnTextStringWithIndex:6].length > 1) {
        self.selectedCount ++;
    }
    if ([self returnTextStringWithIndex:7].length > 1) {
        self.selectedCount ++;
    }
    
    [self postData];
}

- (void)changeModelValue{
    
    self.model.targetUser       = [self.textArray objectAtIndex:0];
    self.model.badpoint         = [self.textArray objectAtIndex:1];
    self.model.totalPeople      = [self.textArray objectAtIndex:2];
    self.model.totalConsumption = [self.textArray objectAtIndex:3];
    self.model.development      = [self.textArray objectAtIndex:4];
    self.model.competeOne       = [self.textArray objectAtIndex:5];
    self.model.competeTwo       = [self.textArray objectAtIndex:6];
    self.model.advantage        = [self.textArray objectAtIndex:7];
}
#pragma mark - 上传数据
- (void)postData
{
    [self changeModelValue];
    
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel addMarketAnalysisDataMID:@"" modelData:self.model success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showInfoMsg:@"保存成功"]; // 显示提示
            if (self.saveSuccessMA) {
                NSString *str = [NSString stringWithFormat:@"%ld/3",(long)self.selectedCount];
                self.saveSuccessMA(str);
            }
            
            self.saveBtn.enabled = YES;
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        self.saveBtn.enabled = YES;
        
        
    } failure:^(NSError *error) {
        self.saveBtn.enabled = YES;
//   [LCProgressHUD showInfoMsg:@"网络异常"];
        
    }];
    
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
#pragma mark -懒加载

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = backColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 175;
        //        _tableView.tableHeaderView.backgroundColor = RGBA(235, 235, 241, 1);
    }
    return _tableView;
}

- (void)initData
{
    _dataSource = @[
                    @"目标用户 *",
                    @"用户痛点 *",
                    @"用户总量 *",
                    @"消费总额 *",
                    @"发展前景 *",
                    @"竞争同行1",
                    @"竞争同行2",
                    @"我们的优势"];
    _attributeSource = @[
                         @"例如:3~14岁的儿童",
                         @"例如:一些儿童较为自闭、情商不高、沟通能力差，影响家庭关系和课业成绩，家长束手无策",
                         @"例如:据第五次人口普查发布的统计公告，中国大陆4～16岁的少年儿童共计1亿八千万，其中北京市区数量为900万。",
                         @"例如:《2014年中国城市儿童生活形态报告》发布，报告中显示，在4-6岁、7-9岁、10-12岁、13-16岁的儿童中，沟通能力障碍及情商较低的比例分别达到22.6%、38.6%、37.1%，43.2%。 根据FrostSullivan调研公司的数据显示，2016年国内情商教育消费市场规模将达到3111亿元",
                         @"例如:我国或将在2015-2025年迎来人口出生的新一轮小高峰，年新生儿人数预计在2000万人以上，情商教育做为素质教育的基础，将越来越受到重视",
                         @"例如:金宝贝 市场份额占据30%左右，但年龄主要集中在4~9岁，有一定的知名度和口碑，收费较低廉，但多数门店地理位置交通不便，同时对中小学低年级情商培训学员没有进行覆盖。",
                         @"例如:美吉姆 美国知名早教品牌，收费昂贵，门店环境好，地理位置优越，主要年龄层集中在9~12岁，主要课为儿童情商教育，同时也开展财商、国学文化教育。",
                         @"例如:读书郎情商教育依托北师大心理学系，定价合理，有健全的儿童情商测试和培训体系，门店集中在居民小区内部，并有儿童托管服务，更适合中国大陆城市儿童。"];
}

- (NSMutableArray *)textArray
{
    if (!_textArray) {
        NSString *targetUser       = self.model.targetUser?self.model.targetUser:@"";
        NSString *badpoint         = self.model.badpoint?self.model.badpoint:@"";
        NSString *totalPeople      = self.model.totalPeople?self.model.totalPeople:@"";
        NSString *totalConsumption = self.model.totalConsumption?self.model.totalConsumption:@"";
        NSString *development      = self.model.development?self.model.development:@"";
        NSString *competeOne       = self.model.competeOne?self.model.competeOne:@"";
        NSString *competeTwo       = self.model.competeTwo?self.model.competeTwo:@"";
        NSString *advantage        = self.model.advantage?self.model.advantage:@"";
        
        _textArray = [NSMutableArray arrayWithArray:@[targetUser,badpoint,totalPeople,totalConsumption,development,competeOne,competeTwo,advantage]];
    }
    return _textArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 记忆添加
- (void)backAction{
    
    [self changeModelValue];
    //模型转字典
    NSDictionary *dict = [self.model mj_keyValues];
    //本地化存储
    [BusinessMemoryCacheTool memoryCacheMarketAnalysisWithDict:dict];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPMarketAnalysisModel *)model
{
    if (!_model) {
        
        NSDictionary *dict = [BusinessMemoryCacheTool MarketAnalysis];
        
        if ([NewBPMarketAnalysisModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPMarketAnalysisModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPMarketAnalysisModel alloc]init];
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
