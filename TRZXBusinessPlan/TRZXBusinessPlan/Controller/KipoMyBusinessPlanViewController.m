//
//  KipoMyBusinessPlanViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "KipoMyBusinessPlanViewController.h"
#import "ProjectManagementViewController.h" //项目概述
#import "MarketAnalysisViewController.h"  //市场分析
#import "BusinessSimulationViewController.h" //商业模式
#import "ProjectProgressViewController.h" //项目进展
#import "CoreTeamViewController.h" //核心团队
#import "FinancialPlansViewController.h" //融资计划
#import "MyBussinessFinalViewController.h" //我的商业计划书

#import "KipoMyBusinessPlanViewModel.h"
#import "NewBPProjectAbsModel.h"
#import "BPLableMonle.h"
#import "NewBPMarketAnalysisModel.h"
#import "NewBPBusinessModel.h"
#import "NewBPMoneyPlanModel.h"
#import "NewBPProjectProgressModel.h"
#import "BPNewMyProjectModel.h"
#import "NewBPCoreTeamModel.h"
#import "BPNewMyProjectModel.h"
#import "NewBPTeamMemberModel.h"

#import "MyBusinessListTableViewCell.h"

#import "BusinessMemoryCacheTool.h"
#import "TRZXBusinessPlanHeader.h"

static CGFloat cellHeight = 83;

@interface KipoMyBusinessPlanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *showStatus;//是否显示选填标识
@property (nonatomic,strong)NSArray *viewNameSource;//控制器名字
@property (nonatomic,strong)UIButton *putButton;//提交审核按钮

@property (nonatomic,strong)NSArray *bitianArr;//必填标识
@property (nonatomic,strong)NSArray *xuantianArr;//选填标识

@property (nonatomic,strong)NewBPProjectAbsModel *planAbsModel;//项目概述
@property (nonatomic,strong)NSArray *tradesArray;//领域
@property (nonatomic,strong)NewBPMarketAnalysisModel *marketAnalysisModel;//市场分析
@property (nonatomic,strong)NewBPBusinessModel *businessModel;//商业模式
@property (nonatomic,strong)NSArray *photoArray;//商业模式产品图片
@property (nonatomic,strong)NewBPProjectProgressModel *progressModel;//项目进展
@property (nonatomic,strong)NSMutableArray *dynamicArray;//项目里程碑
@property (nonatomic,strong)NewBPCoreTeamModel *teamModel;//核心团队
@property (nonatomic,strong)NSMutableArray *teamMembersArr;//团队成员
@property (nonatomic,strong)NewBPMoneyPlanModel *financePlanModel;//融资计划

@property (nonatomic,copy)NSString *haveBusinessPlan;

@property (nonatomic,copy)NSString *url;//商业企划书
@property (nonatomic,strong)UIImage *imageShare;



@end

@implementation KipoMyBusinessPlanViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [IQKeyboardManager sharedManager].enable = YES;
    self.viewNameSource = @[@"ProjectManagementViewController",@"MarketAnalysisViewController",@"BusinessSimulationViewController",@"ProjectProgressViewController",@"CoreTeamViewController",@"FinancialPlansViewController"];
}

#pragma mark - createUI
- (void)createUI
{
    self.title = _titleStr;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.putButton];
}

- (void)setRightNavigation:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame= CGRectMake(0, 0, 100, 44);
    [btn setTitle:@"一键重置"  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    self.saveBtn = btn;
    [btn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
    [self.saveBtn setTitleColor:BPmoneyColor forState:UIControlStateNormal];
    self.saveBtn.hidden = NO;
}

- (void)saveAction:(UIButton *)btn
{
    [self alertViewStr:@"" and:@"将清空商业计划书的所有内容,是否确定重置?"];
}

//警告框
- (void)alertViewStr:(NSString *)_str1 and:(NSString *)_str2 {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_str1 message:_str2 delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //如果有多个alertView，需要通过tag值区分
    
    //一个警告框里通过buttonIndex来区分点击的是哪个按钮
    if (buttonIndex == 0) {
//        TRZXLog(@"取消按钮被点击");
    } else
    {
        [BusinessMemoryCacheTool cleanAllCache];
        [KipoMyBusinessPlanViewModel clearBusinessSuccess:^(id json) {
            
            NSDictionary *dict = json;
            if ([dict[@"status_code"] isEqualToString:@"200"]) {
//                [LCProgressHUD showInfoMsg:@"清除成功"];
                [self loadData];
                return;
            }
        } failure:^(NSError *error) {
        }];
        
        
    }
}
#pragma mark - 请求数据
- (void)loadData
{
     
    [KipoMyBusinessPlanViewModel getBusinessPlanApiDetailDataMID:nil success:^(id json) {
        
        
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            [self anilysiDataWithDict:dict];
            return;
        }
        
    } failure:^(NSError *error) {
    }];
    
}
#pragma mark - 解析数据--------------------
- (void)anilysiDataWithDict:(NSDictionary *)dict
{
    //项目概述
    NSDictionary *planAbsDict = dict[@"planAbs"];
    self.planAbsModel = [NewBPProjectAbsModel mj_objectWithKeyValues:planAbsDict];
    self.tradesArray = [BPLableMonle mj_objectArrayWithKeyValuesArray:planAbsDict[@"trades"]];
    
    //市场分析
    self.marketAnalysisModel = [NewBPMarketAnalysisModel mj_objectWithKeyValues:dict[@"marketAnalysis"]];
    
    //商业模式
    self.businessModel = [NewBPBusinessModel mj_objectWithKeyValues:dict[@"businessModel"]];
    
    self.photoArray = self.businessModel.pics;
    
    
    //    项目进展
    self.progressModel = [NewBPProjectProgressModel mj_objectWithKeyValues:dict[@"progress"]];
    //项目里程碑
    self.dynamicArray = [[NSMutableArray alloc]initWithArray:[BPDynamicList mj_objectArrayWithKeyValuesArray:dict[@"projectDynamic"]]];
    
    //    核心团队
    self.teamModel = [NewBPCoreTeamModel mj_objectWithKeyValues:dict[@"team"]];
    //团队成员
    self.teamMembersArr = [[NSMutableArray alloc]initWithArray:[NewBPTeamMemberModel mj_objectArrayWithKeyValuesArray:dict[@"teamMembers"]]];
    //    融资计划
    self.financePlanModel = [NewBPMoneyPlanModel mj_objectWithKeyValues:dict[@"financePlan"]];
    
    //当前商业计划书的状态
    //    self.haveBusinessPlan = dict[@"haveBusinessPlan"];
    //
    //    if ([self.haveBusinessPlan isEqualToString:@"0"]) {
    //    [_putButton setTitle:@"预览商业计划书" forState:UIControlStateNormal];
    //    }else if ([self.haveBusinessPlan isEqualToString:@"1"])
    //    {
    //     [_putButton setTitle:@"生成商业计划书" forState:UIControlStateNormal];
    //    }
    self.url = dict[@"url"];
    
    //设置状态数据
    [self initStatus];
    [self.tableView reloadData];
    
}

- (void)initStatus
{
    NSString *PM = self.planAbsModel.mustComplete?self.planAbsModel.mustComplete:@"0";
    NSString *MA = self.marketAnalysisModel.mustComplete?self.marketAnalysisModel.mustComplete:@"0";
    NSString *BM = self.businessModel.mustComplete?self.businessModel.mustComplete:@"0";
    NSString *PP = self.progressModel.mustComplete?self.progressModel.mustComplete:@"0";
    NSString *CT = self.teamModel.mustComplete?self.teamModel.mustComplete:@"0";
    NSString *FP = self.financePlanModel.mustComplete?self.financePlanModel.mustComplete:@"0";
    self.bitianArr = @[PM,MA,BM,PP,CT,FP];
    
    NSString *PMs = @"";
    NSString *MAs = self.marketAnalysisModel.complete?self.marketAnalysisModel.complete:@"0/3";
    NSString *BMs = self.businessModel.complete?self.businessModel.complete:@"0/4";
    NSString *PPs = self.progressModel.complete?self.progressModel.complete:@"0/3";
    NSString *CTs = @"";
    NSString *FPs = @"";
    
    self.xuantianArr = @[PMs,MAs,BMs,PPs,CTs,FPs];
}
#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBusinessListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyBusinessListTableViewCell" owner:self options:nil] firstObject];
    }
    cell.titleLable.text = self.dataSource[indexPath.row];
    //是否显示选填的状态
    NSString *string = self.showStatus[indexPath.row];
    if ([string isEqualToString:@"0"]) {
        cell.xuanTianStatus.hidden = YES;
        cell.xuanTianLable.hidden = YES;
    }else
    {
        cell.xuanTianStatus.hidden = NO;
        cell.xuanTianLable.hidden = NO;
    }
    //必填状态
    NSString *BTStaus = self.bitianArr[indexPath.row];
    if ([BTStaus  isEqualToString:@"0"]) {
        cell.statusButton.selected = NO;
    }else
    {
        cell.statusButton.selected = YES;
    }
    //选填状态
    NSString *XTStaus = self.xuantianArr[indexPath.row];
    cell.xuanTianStatus.text = XTStaus;
    if ([XTStaus isEqualToString:@"已完成"]) {
        cell.xuanTianStatus.textColor = [UIColor greenColor];
    }else
    {
        cell.xuanTianStatus.textColor = [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - cell 点击事件------
//是否太臃肿了呢?
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self goDetailViewControllerWithTableView:tableView atIndexPath:indexPath];
    

}

- (void)goDetailViewControllerWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    __weak KipoMyBusinessPlanViewController *weakSelf = self;
    //必填状态
    NSString *BTStaus = self.bitianArr[indexPath.row];
    
    NSString *string = self.viewNameSource[indexPath.row];
    Class className =  NSClassFromString(string);
    UIViewController *vc = [[className alloc]init];
    if (indexPath.row == 0) {
        //项目概述
        ProjectManagementViewController *PMVC = (ProjectManagementViewController *)vc;
        
        if ([BTStaus  isEqualToString:@"0"]) {
            
        }else
        {
            PMVC.model = self.planAbsModel;
            PMVC.dataArr = self.tradesArray;
        }
        
        PMVC.saveSuccessPM = ^(NewBPProjectAbsModel *model)
        {
            MyBusinessListTableViewCell *cell = [weakSelf cellForRow:0];
            cell.statusButton.selected = YES;
            self.planAbsModel = model;
        };
    } else if (indexPath.row == 1)
    {
        //市场分析
        MarketAnalysisViewController *MAVC = (MarketAnalysisViewController *)vc;
        
        if ([BTStaus  isEqualToString:@"0"]) {
            
        }else
        {
            MAVC.model = self.marketAnalysisModel;
        }
        
        
        MAVC.saveSuccessMA = ^(NSString *str)
        {
            MyBusinessListTableViewCell *cell = [weakSelf cellForRow:1];
            cell.xuanTianStatus.text = str;
            cell.statusButton.selected = YES;
        };
    }else if (indexPath.row == 2)
    {//商业模式
        BusinessSimulationViewController *BSVC = (BusinessSimulationViewController *)vc;
        
        
        if ([BTStaus  isEqualToString:@"0"]) {
            
        }else
        {
            BSVC.model = self.businessModel;
            BSVC.photoUrlArray = self.photoArray;
        }
        
        BSVC.saveBMBlock = ^(NSString *str)
        {
            MyBusinessListTableViewCell *cell = [weakSelf cellForRow:2];
            cell.xuanTianStatus.text = str;
            cell.statusButton.selected = YES;
        };
    } else if (indexPath.row == 3)
    {//项目进度
        ProjectProgressViewController *PPVC = (ProjectProgressViewController *)vc;
        
        if ([BTStaus  isEqualToString:@"0"]) {
            
        }else
        {
            PPVC.model = self.progressModel;
            PPVC.projectMsg = self.dynamicArray;
        }
        
        PPVC.saveSuccessPP = ^(NSString *str)
        {
            MyBusinessListTableViewCell *cell = [weakSelf cellForRow:3];
            cell.xuanTianStatus.text = str;
            cell.statusButton.selected = YES;
        };
    }else if (indexPath.row == 4)
    {//核心团队
        CoreTeamViewController *CTVC = (CoreTeamViewController *)vc;
        
        
        if ([BTStaus  isEqualToString:@"0"]) {
            
        }else
        {
            CTVC.model = self.teamModel;
        }
        
        CTVC.dataSource = self.teamMembersArr;
        CTVC.saveCTBlock = ^()
        {
            MyBusinessListTableViewCell *cell = [weakSelf cellForRow:4];
            cell.statusButton.selected = YES;
        };
    } else if (indexPath.row == 5)
    {//融资计划
        FinancialPlansViewController *FPVC = (FinancialPlansViewController *)vc;
        
        
        if ([BTStaus  isEqualToString:@"0"]) {
            
        }else
        {
            FPVC.model = self.financePlanModel;
        }
        
        FPVC.saveFPBlock = ^()
        {
            MyBusinessListTableViewCell *cell = [weakSelf cellForRow:5];
            cell.statusButton.selected = YES;
        };
    }
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (MyBusinessListTableViewCell *)cellForRow:(NSInteger)index
{
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index inSection:0];
    MyBusinessListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - 提交项目审核
- (void)putButtonClick:(UIButton *)button
{
    NSString *messageAlert =nil;
    for (int i = 0; i < self.bitianArr.count; i ++) {
        NSString *string = self.bitianArr[i];
        if ([string isEqualToString:@"0"]) {
            messageAlert = [NSString stringWithFormat:@"请填写%@",self.dataSource[i]];
            [self alertWithTitle:@"" message:messageAlert];
            return;
        }
    }
//    [KipoMyBusinessPlanViewModel lookBusinessPlanSuccess:^(id json) {
//        
//        NSDictionary *dict = json;
//        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            
//            NSString *url = dict[@"url"];
//            //预览商业企划书
//            MyBussinessFinalViewController *myBPVC = [[MyBussinessFinalViewController alloc]init];
//            myBPVC.myBussinessUrl = url;
//            myBPVC.bpName = self.planAbsModel.name;
//            myBPVC.image = self.imageShare;
//            myBPVC.type = 1;
//            myBPVC.isPush = YES;
//            [self.navigationController pushViewController:myBPVC animated:YES];
//            return;
//        }else
//        {
//            NSString *str = json[@"status_dec"]?json[@"status_dec"]:@"加载失败";
//            [LCProgressHUD showInfoMsg:str];
//        }
//        
//    } failure:^(NSError *error) {
//    }];
//    

}



- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}

- (void)postData
{
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel createBusinessPlanMID:nil success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showSuccess:@"生成成功"];
            self.url = dict[@"url"];
            [_putButton setTitle:@"预览商业计划书" forState:UIControlStateNormal];
            MyBussinessFinalViewController *myBPVC = [[MyBussinessFinalViewController alloc]init];
            myBPVC.myBussinessUrl = self.url;
            myBPVC.image = self.imageShare;
            [self.navigationController pushViewController:myBPVC animated:YES];
            self.saveBtn.enabled = YES;
            return;
        }
        self.saveBtn.enabled = YES;
//        [LCProgressHUD showInfoMsg:@"生成失败"];
    } failure:^(NSError *error) {
//        [LCProgressHUD showInfoMsg:@"网络异常"];
        self.saveBtn.enabled = YES;
    }];
    
}



#pragma mark -懒加载

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"项目概述",@"市场分析",@"商业模式",@"项目进展",@"核心团队",@"融资计划"];
        _showStatus = @[@"0",@"1",@"1",@"1",@"0",@"0"];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT - 50-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = BPbackColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = cellHeight;
        //        _tableView.tableHeaderView.backgroundColor = BPRGBA(235, 235, 241, 1);
    }
    return _tableView;
}
- (UIButton *)putButton
{
    if (!_putButton) {
        _putButton = [[UIButton alloc]initWithFrame:CGRectMake(0, BPSCREEN_HEIGHT - 50, BPSCREEN_WIDTH, 50)];
        [_putButton setTitle:@"预览商业计划书" forState:UIControlStateNormal];
        _putButton.backgroundColor = BPRGBA(215, 0, 15, 1.0);
        [_putButton addTarget:self action:@selector(putButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _putButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
