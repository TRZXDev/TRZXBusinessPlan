//
//  TRHelpInfoTypeViewController.m
//  TRZX
//
//  Created by Rhino on 16/8/29.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#define ButtonTag 4564
#import "TRHelpInfoTypeViewController.h"
#import "SCPopCollectionCell.h"
#import "TRNewChildrenModel.h"
#import "TRNewTradeInfoModel.h"
#import "TRZXTradeInfoRequest.h"
#import "MJExtension.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define backColor [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]
#define moneyColor [UIColor colorWithRed:209.0/255.0 green:187.0/255.0 blue:114.0/255.0 alpha:1]
#define kWhiteColor         [UIColor whiteColor]

@interface CollectionHeaderView : UICollectionReusableView

@property (nonatomic,strong)UILabel *label;
@end

@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = ({
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 35)];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
            label;
        });
        [self addSubview:label];
        self.label = label;
    }
    return self;
}
@end

@interface TRHelpInfoTypeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)CollectionHeaderView *headerView;

@property (nonatomic,assign)NSInteger maxSelect;//最大选择数
@property (nonatomic,copy)NSString *typeStr;
@property (nonatomic,copy)NSString *authTypeStr;

@end

@implementation TRHelpInfoTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviBar];
    [self addTopView];
    [self loadData];
}

- (void)setNaviBar
{
        self.saveBtn.hidden = NO;
    if (self.type == HelpInfoType_Expert) {
        self.maxSelect  = 5;
        self.typeStr = @"1";
        self.mainTitle.text = [NSString stringWithFormat:@"选择服务行业\n最多选%ld个",(long)self.maxSelect];
    }else if (self.type == HelpInfoType_Shareholder){
         self.maxSelect = 1;
         self.typeStr = @"1";
        self.saveBtn.hidden = YES;
         self.mainTitle.text = [NSString stringWithFormat:@"选择所属行业\n最多选%ld个",(long)self.maxSelect];
    }else if (self.type == HelpInfoType_Invertost){
         self.maxSelect = 5;
         self.typeStr = @"2";
         self.authTypeStr = @"1";
         self.mainTitle.text = [NSString stringWithFormat:@"选择关注领域\n最多选%ld个",(long)self.maxSelect];
    }else if (self.type == HelpInfoType_Business){
        self.maxSelect = 5;
        self.mainTitle.text = [NSString stringWithFormat:@"选择行业领域\n最多选%ld个",(long)self.maxSelect];
    }
    
    
    self.mainTitle.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
    NSString *str = @"\n";
    NSRange range = [self.mainTitle.text rangeOfString:str];
    NSInteger startIndex = self.mainTitle.text.length - (range.location + range.length);
    NSRange range2 = NSMakeRange(startIndex+1, self.mainTitle.text.length - (startIndex+1));
    self.mainTitle.adjustsFontSizeToFitWidth = NO;
    self.mainTitle.font = [UIFont systemFontOfSize:14];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.mainTitle.text];
    [attribute addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:range2];
    [attribute addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:215.0/255.0 green:0/255.0 blue:15.0/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(range2.location, 1)];
    
    self.mainTitle.attributedText = attribute;
    
    self.mainTitle.numberOfLines = 2;
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
}

- (void)addTopView{

    [self.view addSubview:self.collectionView];
}

- (void)loadData
{
    [TRZXTradeInfoRequest getTradeInfo:nil Success:^(id object) {
        
        
        if ([object[@"status_code"] isEqualToString:@"200"]) {
            NSArray *dicArr = object[@"trades"];
            self.dataArr = [TRNewTradeInfoModel mj_objectArrayWithKeyValuesArray:dicArr];
            
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - TableviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArr count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    TRNewTradeInfoModel *model = self.dataArr[section];
    return [model.children count];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SCPopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SCPopCollectionCell" forIndexPath:indexPath];
    TRNewTradeInfoModel *model = self.dataArr[indexPath.section];
    TRNewChildrenModel *subModel = model.children[indexPath.item];
    
    cell.titleLabel.text = subModel.trade;
    
    cell.titleLabel.tag = ButtonTag + indexPath.item;
    cell.contentView.layer.cornerRadius = 4;
    cell.contentView.layer.borderColor = kWhiteColor.CGColor;
    cell.contentView.layer.borderWidth = 1;
    cell.contentView.layer.masksToBounds = YES;
    cell.titleLabel.numberOfLines = 2;
    cell.titleLabel.backgroundColor = kWhiteColor;
    cell.titleLabel.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
    
    for (TRNewChildrenModel *sele in self.seletedTrade) {
        if ([sele.mid isEqual:subModel.mid]) {
            
            cell.titleLabel.backgroundColor = RGBA(209, 187, 104, 1);
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.contentView.layer.borderColor = moneyColor.CGColor;
        }
        
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SCPopCollectionCell *cells = (SCPopCollectionCell *)cell;
    TRNewTradeInfoModel *model = self.dataArr[indexPath.section];
    TRNewChildrenModel *subModel = model.children[indexPath.item];
    cell.contentView.layer.borderColor = kWhiteColor.CGColor;
    
    for (TRNewChildrenModel *sele in self.seletedTrade) {
        if ([sele.mid isEqual:subModel.mid]) {
            
            cells.titleLabel.backgroundColor = RGBA(209, 187, 104, 1);
            cells.titleLabel.textColor = [UIColor whiteColor];
            cell.contentView.layer.borderColor = moneyColor.CGColor;
        }
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {       //头视图
         TRNewTradeInfoModel *model = self.dataArr[indexPath.section];
        _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        _headerView.label.text = model.trade;
        reusableView = _headerView;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 35);
}


#pragma mark  ------- FJTagCollectionLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 4*12)/3, 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - Event Action

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SCPopCollectionCell *cell = (SCPopCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    //获取选中的model
    TRNewTradeInfoModel *model = self.dataArr[indexPath.section];
    TRNewChildrenModel *subModel = model.children[indexPath.item];
    
    //股东
    if (self.type == HelpInfoType_Shareholder) {
        NSArray * stringName = @[subModel.trade,subModel.mid];
        [self.delegate TRHelpInfoChooseTradeInfo:@" " andArray:stringName];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    //两个数组里面装的模型并不是同一个 只能通过for循环遍历由mid进行判断
    BOOL isExist = NO;
    TRNewChildrenModel *isExistModel = nil;
    
    for (TRNewChildrenModel *sele in self.seletedTrade) {
        if ([sele.mid isEqual:subModel.mid]) {
            isExist = YES;
            isExistModel = sele;
            break;
        }
    }

    //判断选中的数组里面是否包含此模型
    if (isExist) {
        //存在 则为已选中 设置为未选中状态 删除数据 背景颜色 字体颜色 改变
        [self.seletedTrade removeObject:isExistModel];
        cell.titleLabel.backgroundColor = kWhiteColor;
        cell.titleLabel.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
        cell.contentView.layer.borderColor = kWhiteColor.CGColor;
    }else{
        
        if (self.seletedTrade.count >= self.maxSelect) {
//            [LCProgressHUD showInfoMsg:[NSString stringWithFormat:@"最多选择%ld项",self.maxSelect]];
            return;
        }
        //设置为选中状态
        [self.seletedTrade addObject:subModel];
        cell.titleLabel.backgroundColor = RGBA(209, 187, 104, 1);
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.contentView.layer.borderColor = moneyColor.CGColor;
    }
}
/**
 *  保存
 */
-(void)saveAction
{
 
    if (self.seletedTrade.count == 0) {
//        [LCProgressHUD showInfoMsg:@"至少选择一项"];
        return;
    }
    
    if (self.type == HelpInfoType_Business) {
        //商业计划书
        if (self.enterButtonClickBlock) {
            
            NSMutableString *string = [[NSMutableString alloc] init];
            for (int i = 0; i< self.seletedTrade.count; i++) {
                TRNewChildrenModel *model = self.seletedTrade[i];
                if ( i == 0) {
                    [string appendString:model.mid];
                } else {
                    [string appendString:[NSString stringWithFormat:@",%@",model.mid]];
                }
            }
        
        self.enterButtonClickBlock(self.seletedTrade,string);
        [self.navigationController popViewControllerAnimated:YES];
        return;
        }
    }
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i< self.seletedTrade.count; i++) {
        TRNewChildrenModel *model = self.seletedTrade[i];
        if ( i == 0) {
            [str appendString:model.mid];
        } else {
            [str appendString:[NSString stringWithFormat:@",%@",model.mid]];
        }
    }
    
    [TRZXTradeInfoRequest  getTZRguanzhubaocunDataTradeIds:str TypeStr:self.typeStr AuthType:self.authTypeStr OrgId:self.mid Success:^(id object) {
        if ([object[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showInfoMsg:@"保存成功"]; // 显示提示
            
            NSMutableString *str = [[NSMutableString alloc] init];
            for (int i = 0; i< self.seletedTrade.count; i++) {
                TRNewChildrenModel *model = self.seletedTrade[i];
                if ( i == 0) {
                    [str appendString:model.trade];
                } else {
                    [str appendString:[NSString stringWithFormat:@",%@",model.trade]];
                }
            }
             self.enterButtonClickBlock(self.seletedTrade,str);
//            [self.delegate TRHelpInfoChooseTradeInfo:str andArray:self.seletedTrade];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
               
        }
    } failure:^(NSError *error) {
        
//        [LCProgressHUD showInfoMsg:@"服务器错误"];
    }];
    
//    if (self.enterButtonClickBlock) {
//        
//        NSMutableString *string = [[NSMutableString alloc]init];
//        
//        for (TRNewChildrenModel *sele in self.seletedTrade) {
//            
//            [string appendString:[NSString stringWithFormat:@"%@,",sele.mid]];
//        }
//        
//        if (self.seletedTrade.count == 0) {
//            
//            NSString *messageAlert  = @"请选择行业领域";
//            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:nil message:messageAlert delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alertM show];
//            return;
//        }else
//        {
//            self.enterButtonClickBlock(string);
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
    
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - setter/getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
        _collectionView.backgroundColor = backColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SCPopCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SCPopCollectionCell"];
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];//注册头视图
        
    }
    return _collectionView;
}

-(void)dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
