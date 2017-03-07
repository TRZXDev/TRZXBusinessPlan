//
//  CoreTeamViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "CoreTeamViewController.h"
#import "BSAddNewTeamViewController.h"

#import "BPProjectMsgCell.h"
#import "BPAddMemberCell2.h"
#import "BPButtonTableViewCell.h"
#import "BPCoreTeamMessageCellTableViewCell.h"

#import "NewBPCoreTeamModel.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "NewBPTeamMemberModel.h"
#import "BusinessMemoryCacheTool.h"

#import "TRZXBusinessPlanHeader.h"

@interface CoreTeamViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    BPAddMemberCell2 *firstCell;
}

@property (nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)NSArray *heightArr;

@property (nonatomic,strong)UIImage *selectedImage;

@end

@implementation CoreTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviBar];
    [self addUI];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

#pragma mark -刷新数据-~~~~~~~~~~~~~~~
- (void)loadData
{
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    [KipoMyBusinessPlanViewModel getListTeamerDataMID:nil success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            
            [self.dataSource addObjectsFromArray:[NewBPTeamMemberModel mj_objectArrayWithKeyValuesArray:dict[@"teamMembers"]]];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)setNaviBar
{
    self.title = @"核心团队";
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.saveBtn.hidden = NO;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
}

- (void)addUI
{
    [self.view addSubview:self.tableView];
    _heightArr = @[@"250",@"120",@"176",@"49",@"170"];
}
#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count +4;
}

//改变字体颜色
- (NSAttributedString *)setLocationAttributeWithStr:(NSString *)str
{
    NSRange ranges = [str rangeOfString:@"*"];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeText setAttributes:@{NSForegroundColorAttributeName:BPRGBA(227, 75, 87, 1.0)} range:NSMakeRange(ranges.location, 1)];
    return attributeText;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BPAddMemberCell2 *cell = [[[NSBundle mainBundle]loadNibNamed:@"BPAddMemberCell2" owner:self options:nil] firstObject];
        cell.titleLabel.text = @"* 上传团队合影";
        
        if ([cell.titleLabel.text hasPrefix:@"*"]) {
            cell.titleLabel.attributedText = [self setLocationAttributeWithStr:cell.titleLabel.text];
        }
        if (self.selectedImage != nil) {
            cell.headImageView.image = self.selectedImage;
        }else
        {
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.groupPic] placeholderImage:[UIImage imageNamed:@"bp_addPhoto"]];
        }
        __weak  CoreTeamViewController *weakSelf = self;
        cell.selectImage = ^(UIImage *image)
        {
            weakSelf.selectedImage = image;
        };
        cell.MsgTitleLable.hidden = YES;
        
        cell.referenceVC = weakSelf;
        cell.contentView.backgroundColor = BPbackColor;
        firstCell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        BPProjectMsgCell *cell = [[BPProjectMsgCell alloc]initWithTitle:@"团队口号 *" PlaceHoder:@"例:用我们的专业知识和真挚的爱心，帮助学员进行全方位的素质提升" CountCharacter:@"20字" TextViewMsg:self.model.slogan];
        cell.textViewMsg.delegate = self;
        cell.contentView.backgroundColor = BPbackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == self.dataSource.count + 2)
    {
        BPButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"BPButtonTableViewCell" owner:self options:nil] firstObject];
        }
        cell.contentView.backgroundColor = BPbackColor;
        cell.bgView.backgroundColor = BPbackColor;
        cell.titleLable.text = @"添加团队成员";
        cell.titleLable.backgroundColor = BPmoneyColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row < self.dataSource.count + 2)
    {
        BPCoreTeamMessageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"team"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"BPCoreTeamMessageCellTableViewCell" owner:self options:nil] firstObject];
        }
        cell.lineView.hidden = YES;
        NewBPTeamMemberModel *model = self.dataSource[indexPath.row -2];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.memberPic] placeholderImage:[UIImage imageNamed:@"bp_addPhoto"]];
        //        if (![cell.headImageView.image isEqual:[UIImage imageNamed:@"bp_addPhoto"]]) {
        //            self.selectedImage = cell.headImageView.image;
        //        }
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,model.position];
//        cell.positionLabel.text = model.position;
        cell.changeLength = model.name.length;
        cell.detailLabel.text = model.work;
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


#pragma mark - 编辑相关
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count >0) {
        if (indexPath.row >1 && indexPath.row < self.dataSource.count + 3) {
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
        
        NewBPTeamMemberModel *model = self.dataSource[indexPath.row-2];
        
        [KipoMyBusinessPlanViewModel deleteTeamMemberDataMID:model.mid success:^(id json) {

            [self.dataSource removeObjectAtIndex:indexPath.row-2];
            
            NSArray *indexPaths = @[indexPath]; // 构建 索引处的行数 的数组
            // 删除 索引的方法 后面是动画样式
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationLeft)];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            

        }];
        
    }
}

#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak CoreTeamViewController *weakSelf = self;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.row == self.dataSource.count + 2) {
        //添加
        if (self.dataSource.count >= 6) {
//            [LCProgressHUD showInfoMsg:@"最多添加6名核心成员"];
            return;
        }
        BSAddNewTeamViewController *vc = [[BSAddNewTeamViewController alloc]init];
        vc.saveNewTeamerModelBlock = ^(NewBPTeamMemberModel *model)
        {
            [weakSelf.dataSource addObject:model];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row<self.dataSource.count +2 && indexPath.row >1)
    {//编辑修改
        BSAddNewTeamViewController *vc = [[BSAddNewTeamViewController alloc]init];
        
        vc.model = self.dataSource[indexPath.row-2];
        vc.isUpdate = YES;
        vc.saveNewTeamerModelBlock = ^(NewBPTeamMemberModel *model)
        {
            [weakSelf.dataSource replaceObjectAtIndex:indexPath.row- 2 withObject:model];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <2) {
        return [self.heightArr[indexPath.row] floatValue];
    }
    if (self.dataSource.count == 0) {
        if (indexPath.row == 2) {
            return 49;
        }
    }else
    {
        if (indexPath.row == self.dataSource.count +2) {
            return 49;
        }else if (indexPath.row == self.dataSource.count +3)
        {
            return 200;
        }else
        {
            return 130;
        }
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
//    NSString * string = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    if (string.length > 20) {
//        string = [string substringToIndex:20];
//        return NO;
//    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.model.slogan = textView.text;
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
    
    NSInteger count = 20;
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
    
    if(textView.text.length >= count){
        [textView scrollRangeToVisible:[textView.text rangeOfString:toBeString]];
    }
    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(count-textView.text.length)];

//    if (textView.text.length > 20) {
//        cell.textViewMsg.text = [textView.text substringToIndex:20];
//    }
//    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",20-textView.text.length];
    self.model.slogan = textView.text;
}

- (void)saveAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    NSString *messageAlert =nil;
    
    if (![firstCell.headImageView.image isEqual:[UIImage imageNamed:@"bp_addPhoto"]]) {
        self.selectedImage = firstCell.headImageView.image;
    }
    
    if (self.selectedImage == nil && ![self.model.groupPic hasSuffix:@"http"]) {
        messageAlert = @"请上传团队合影";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.model.slogan.length < 1) {
        messageAlert = @"请填写团队口号";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if (self.dataSource.count == 0) {
        messageAlert = @"请至少添加一名核心成员";
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
#pragma mark - 上传数据
- (void)postData
{
    self.saveBtn.enabled = NO;
    [KipoMyBusinessPlanViewModel addCoreTeamDataMID:nil modelData:self.model image:self.selectedImage
                                            success:^(id json) {
                                                NSDictionary *dict = json;
                                                if ([dict[@"status_code"] isEqualToString:@"200"]) {
                                                    if (self.saveCTBlock) {
                                                        self.saveCTBlock();
                                                    }
                                                    self.saveBtn.enabled = YES;
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                    return;
                                                }
                                                
                                                self.saveBtn.enabled = YES;
                                                
                                                
                                            } failure:^(NSError *error) {
//                                                [LCProgressHUD showInfoMsg:@"网络异常"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{

}

#pragma mark - 记忆添加
- (void)backAction{
    
    //模型转字典
    NSDictionary *dict = [self.model mj_keyValues];
    //本地化存储
    [BusinessMemoryCacheTool memoryCacheCoreTeamWithDict:dict];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPCoreTeamModel *)model
{
    if (!_model) {
        
        NSDictionary *dict = [BusinessMemoryCacheTool CoreTeam];
        
        if ([NewBPCoreTeamModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPCoreTeamModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPCoreTeamModel alloc]init];
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
