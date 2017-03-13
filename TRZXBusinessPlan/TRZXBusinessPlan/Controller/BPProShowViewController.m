//
//  BPProShowViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/7.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BPProShowViewController.h"

#import "BPProjectDynamicCell1.h"
#import "BPProjectDynamicCell2.h"
#import "BPButtonTableViewCell.h"
#import "BPAddNewThinkViewController.h"

#import "BPNewMyProjectModel.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "BusinessMemoryCacheTool.h"
#import "TRZXBusinessPlanHeader.h"

@interface BPProShowViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)BPDynamicList *model;

@end

@implementation BPProShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
    [self addUI];
}


- (void)setNaviBar
{
    self.title = @"项目里程碑";
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
    if (self.dataSource.count ==0) {
        return 2;
    }
    return self.dataSource.count + 3;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cells"];
        }
        cell.contentView.backgroundColor = BPbackColor;
        cell.textLabel.text = @"至少添加一条事件";
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.textColor = [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (self.dataSource.count >0) {
        
        if (indexPath.row == 1)
        {
            BPProjectDynamicCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"team"];
            if (!cell) {
                cell = [[TRZXBPBundle loadNibNamed:@"BPProjectDynamicCell1" owner:self options:nil] firstObject];
            }
            cell.contentView.backgroundColor = BPbackColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else if (indexPath.row == self.dataSource.count +2)
            //添加新事件
        {
            BPButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
            if (!cell) {
                cell = [[TRZXBPBundle loadNibNamed:@"BPButtonTableViewCell" owner:self options:nil] firstObject];
            }
            cell.contentView.backgroundColor = BPbackColor;
            cell.bgView.backgroundColor = BPbackColor;
            cell.titleLable.text = @"添加新事件";
            cell.titleLable.backgroundColor = BPmoneyColor;
            cell.contentView.backgroundColor = BPbackColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            BPDynamicList *model = self.dataSource[indexPath.row - 2];
            BPProjectDynamicCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"team"];
            if (!cell) {
                cell = [[TRZXBPBundle loadNibNamed:@"BPProjectDynamicCell2" owner:self options:nil] firstObject];
            }
            cell.titleLabel.text = model.dynamicDate;
            cell.detailLabel.text = model.abstractz;
            cell.detailLabel.textColor = BPheizideColor;
            cell.contentView.backgroundColor = BPbackColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else
    {
        if (indexPath.row == 1)
            //添加新事件
        {
            BPButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
            if (!cell) {
                cell = [[TRZXBPBundle loadNibNamed:@"BPButtonTableViewCell" owner:self options:nil] firstObject];
            }
            cell.contentView.backgroundColor = BPbackColor;
            cell.bgView.backgroundColor = BPbackColor;
            cell.titleLable.text = @"添加新事件";
            cell.titleLable.backgroundColor = BPmoneyColor;
            cell.contentView.backgroundColor = BPbackColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    return [UITableViewCell new];
}

#pragma mark - 编辑相关
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count >0) {
        if (indexPath.row >1 && indexPath.row < self.dataSource.count + 2) {
            return YES;
        }
    }
    return NO;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataSource removeObjectAtIndex:indexPath.row-2];
        
        //        NSArray *indexPaths = @[indexPath]; // 构建 索引处的行数 的数组
        ////         删除 索引的方法 后面是动画样式
        //        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationLeft)];
        [self.tableView reloadData];
    }
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataSource.count == 0) {
        if (indexPath.row == 1) {
            //添加新事件
            BPAddNewThinkViewController *vc = [[BPAddNewThinkViewController alloc]init];
            vc.textModleBlock = ^(BPDynamicList *model)
            {
                if (model != nil) {
                    [self.dataSource addObject:model];
                    [self.tableView reloadData];
                }
            };
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    if (indexPath.row == self.dataSource.count +2) {
        
        if (self.dataSource.count >= 6) {
            NSString *messageAlert = @"最多添加六条事件";
            [self alertWithTitle:@"" message:messageAlert];
            return;
        }
        //添加新事件
        BPAddNewThinkViewController *vc = [[BPAddNewThinkViewController alloc]init];
        vc.textModleBlock = ^(BPDynamicList *model)
        {
            if (model != nil) {
                [self.dataSource addObject:model];
                [self.tableView reloadData];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else if (indexPath.row !=0 && indexPath.row !=1)
    {
        //添加新事件
        BPAddNewThinkViewController *vc = [[BPAddNewThinkViewController alloc]init];
        BPDynamicList *model = self.dataSource[indexPath.row - 2];
        vc.model = model;
        vc.isUpdate = YES;
        vc.textModleBlock = ^(BPDynamicList *newmodel)
        {
            if (model != nil) {
                [self.dataSource removeObject:model];
                [self.dataSource addObject:newmodel];
                [self.tableView reloadData];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }else if (indexPath.row == 1)
    {
        return 44;
    }
    
    if (self.dataSource.count != 0) {
        if (indexPath.row == self.dataSource.count +2)
            //添加新事件
        {
            return 44;
        }else
        {
            return 120;
        }
    }
    return 0;
}

//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:BPRGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}

- (void)saveAction:(UIButton *)btn
{
    
    NSString *messageAlert = nil;
    if (self.dataSource.count < 1) {
        messageAlert = @"请至少添加一条事件";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    
    [self postData];
}

#pragma mark - 保存数据------~~~~~~~~~~~~~~~~~~~~~
- (void)postData
{
    
    NSArray *dictArray = [BPDynamicList mj_keyValuesArrayWithObjectArray:self.dataSource];
    NSError *error;
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:dictArray
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&error];
    NSString *string = [[NSString alloc]initWithData:JSONData encoding:NSUTF8StringEncoding];
    
    
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel saveDynamicData:string success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showInfoMsg:@"保存成功"]; // 显示提示
            if (self.saveModleBlock) {
                self.saveModleBlock(self.dataSource);
            }
            [self.navigationController popViewControllerAnimated:YES];
            self.saveBtn.enabled = YES;
            return;
        }
        
        self.saveBtn.enabled = YES;
    } failure:^(NSError *error) {
//        [LCProgressHUD showInfoMsg:@"网络异常"];
        self.saveBtn.enabled = YES;
    }];
    
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
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 记忆添加
- (void)backAction{
    
    [self.view endEditing:YES];
    
    //本地化存储
    //    [BusinessMemoryCacheTool memoryCacheProjectProgressALLEventArray:_dataSource];
    
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
