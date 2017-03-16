//
//  BusinessSimulationViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "BusinessSimulationViewController.h"
#import "BPProjectMsgCell.h"
#import "BussinessPlanStatusTableViewCell.h"

#import "AJPhotoPickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AJPhotoBrowserViewController.h"

#import "NewBPBusinessModel.h"
#import "BPPhotoShowMsgTableViewCell.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "BPBussinessFlowFlagTableViewCell.h"
#import "BusinessMemoryCacheTool.h"
#import "TRZXBusinessPlanHeader.h"
#import <AVFoundation/AVFoundation.h>

#import <SDWebImage/SDWebImageDownloader.h>


#define TagText 644766222
#define tagTefield 2224
static NSInteger photoCount = 4;

@interface BusinessSimulationViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate,AJPhotoPickerProtocol,AJPhotoBrowserDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (weak, nonatomic) UICollectionView  *collectionview;

@property (nonatomic,strong)NSMutableArray *textArray;


@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *attributeDataSource;
@property (nonatomic,strong)NSArray *heightArr;

@property (nonatomic,assign)BOOL isUploadPhoto;//是否上传了照片
@property (nonatomic,copy)NSString *liushuiStatus;//流水状态
@property (nonatomic,assign)NSInteger selectedCount;//选填个数

@property (nonatomic,strong)BussinessPlanStatusTableViewCell *plan;
@property (nonatomic,strong)BPBussinessFlowFlagTableViewCell *flow;

@end

@implementation BusinessSimulationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviBar];
    [self initData];
    [self createUI];
    [self loadPhoto];
}

- (void)setNaviBar
{
    self.title = @"商业模式";
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.saveBtn.hidden = NO;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateHighlighted];
}
- (void)createUI
{
    [self.view addSubview:self.tableView];
}

- (void)loadPhoto
{


    if (self.photoUrlArray.count >0) {
        
        for (NSString *strImg in self.photoUrlArray) {

            [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:strImg] options:SDWebImageDownloaderIgnoreCachedResponse progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (error) {
                }
                if (image) {
                    //图片下载完成  在这里进行相关操作，如加到数组里 或者显示在imageView上
                    if (self.photoArray.count >= photoCount) {
                        [self.photoArray replaceObjectAtIndex:photoCount-1 withObject:image];
                    }else
                    {
                        [self.photoArray addObject:image];
                    }
                    
                    [self.collectionview reloadData];
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
                    if (self.photoArray.count == self.photoUrlArray.count) {
                        
                    }
                }
            }];
        }
        
    }
    
}
#pragma mark -collectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"midCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *im = [[UIImageView alloc] initWithFrame:cell.bounds];
    im.contentMode = UIViewContentModeScaleAspectFill;
    im.layer.masksToBounds = YES;
    
    im.userInteractionEnabled  = YES;
    if (indexPath.row == self.photoArray.count) {
        im.image = [UIImage imageNamed:@"bp_addPhoto@2x"];
    }else{
        im.image = self.photoArray[indexPath.row];
    }
    
    [cell.contentView addSubview:im];
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.photoArray.count == photoCount) {
        return self.photoArray.count;
    }
    return self.photoArray.count + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((BPSCREEN_WIDTH-16)/3 - 7.5, (BPSCREEN_WIDTH-16)/3 - 7.5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7.5;
}
//最多4张图片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.row == self.photoArray.count) {
        if (self.photoArray.count == photoCount) {
            NSString *string  = [NSString stringWithFormat:@"最多只能选择%ld张照片哦~~",photoCount - self.photoArray.count];
            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertM show];
            return;
        }
        [self presentChoosePhoto];
    }else
    {
        [self showBig:indexPath.row];
    }
}
#pragma mark - BoPhotoPickerProtocol-----------选择照片-------
//取消选中
- (void)photoPickerDidCancel:(AJPhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//选中
- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAssets:(NSArray *)assets {
    
    for (int i = 0; i <assets.count; i ++) {
        ALAsset *asset = assets[i];
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self.photoArray insertObject:tempImg atIndex:0];
        if (self.photoArray.count > photoCount) {
            [self.photoArray removeLastObject];
        }
    }
    
    [self.collectionview reloadData];
    [self reloadCell];
    [picker dismissViewControllerAnimated:NO completion:nil];
}
//超过最大选择项时
- (void)photoPickerDidMaximum:(AJPhotoPickerViewController *)picker {

    NSString *string  = [NSString stringWithFormat:@"最多只能选择%ld张照片哦~~",photoCount - self.photoArray.count];
    UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:picker cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertM show];
}
//点击相册
- (void)photoPickerTapCameraAction:(AJPhotoPickerViewController *)picker {
    [self checkCameraAvailability:^(BOOL auth) {
        if (!auth) {

            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"" message:@"没有访问相机权限~~" delegate:picker cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertM show];
            return;
        }
        
        [picker dismissViewControllerAnimated:NO completion:nil];
        UIImagePickerController *cameraUI = [UIImagePickerController new];
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = self;
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraUI.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        
        [self presentViewController: cameraUI animated: YES completion:nil];
    }];
}
- (void)reloadCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self changeHeight];
}

- (void)checkCameraAvailability:(void (^)(BOOL auth))block {
    BOOL status = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        status = YES;
    } else if (authStatus == AVAuthorizationStatusDenied) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                if (block) {
                    block(granted);
                }
            } else {
                if (block) {
                    block(granted);
                }
            }
        }];
        return;
    }
    if (block) {
        block(status);
    }
}
//使用照片--拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage;
    if (CFStringCompare((CFStringRef) mediaType,kUTTypeImage, 0)== kCFCompareEqualTo) {
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (self.photoArray.count<photoCount) {
        [self.photoArray addObject:originalImage];
    }else
    {   [self.photoArray removeObjectAtIndex:0];
        [self.photoArray addObject:originalImage];
    }
    [self.collectionview reloadData];
    [self reloadCell];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------------------图片浏览器相关----------------------~```````````````````````````````````
#pragma mark --删除按钮被点击
- (void)photoBrowser:(AJPhotoBrowserViewController *)vc deleteWithIndex:(NSInteger)index
{
    [self.photoArray removeObjectAtIndex:index];
    [self.collectionview reloadData];
    [self reloadCell];
}
#pragma mark ---点击完成按钮
- (void)photoBrowser:(AJPhotoBrowserViewController *)vc didDonePhotos:(NSArray *)photos {
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---弹出图片浏览器
- (void)showBig:(NSInteger)index
{
    AJPhotoBrowserViewController *photoBrowserViewController = [[AJPhotoBrowserViewController alloc] initWithPhotos:self.photoArray index:index];
    photoBrowserViewController.delegate = self;
    [self presentViewController:photoBrowserViewController animated:YES completion:nil];
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(7.5/2, 7.5/2, 7.5/2, 7.5/2);
}


#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPProjectMsgCell *cell  = nil;
    if (indexPath.row == 0) {
        //照片
        UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:@"photos"];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"photos"];
        }
        cells.contentView.backgroundColor = BPbackColor;
        for (UIView *view in cells.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        UICollectionView *collec = [[UICollectionView alloc] initWithFrame:CGRectMake(8, 10, BPSCREEN_WIDTH-2*8, (BPSCREEN_WIDTH-2*8)/3 * 1+10) collectionViewLayout:flow];
        collec.backgroundColor = BPbackColor;
        collec.delegate = self;
        collec.dataSource  =self;
        self.collectionview = collec;
        [self changeHeight];
        [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"midCell"];
        [cells.contentView addSubview:self.collectionview];
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        return cells;
    }else if (indexPath.row == 1) {
        //上传照片说明
        BPPhotoShowMsgTableViewCell *cells = [[TRZXBPBundle loadNibNamed:@"BPPhotoShowMsgTableViewCell" owner:self options:nil] firstObject];
        //        cell = [[BPBPProjectMsgCell alloc]initWithTitle:self.dataSource[indexPath.row] PlaceHoder:self.attributeDataSource[indexPath.row] CountCharacter:@"" TextViewMsg:@""];
        //        cell.textViewMsg.editable = NO;
        //        cell.textViewMsg.scrollEnabled = NO;
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        cells.contentView.backgroundColor = BPbackColor;
        return cells;
    } else if (indexPath.row == 6) {
        //流水状态
        if (self.plan != nil) {
            return self.plan;
        }
        BussinessPlanStatusTableViewCell *cells = [[TRZXBPBundle loadNibNamed:@"BussinessPlanStatusTableViewCell" owner:self options:nil] firstObject];
        self.plan = cells;
        self.liushuiStatus = self.model.flow;
        if ([self.model.flow isEqualToString:@"0"]) {
            cells.noneWater.selected = YES;
            cells.yesWater.selected = NO;
            cells.noneWater.backgroundColor = BPTRZXMainColor;
            cells.yesWater.backgroundColor = BPbackColor;
        }else if ([self.model.flow isEqualToString:@"1"])
        {
            cells.noneWater.backgroundColor = BPbackColor;
            cells.yesWater.backgroundColor = BPTRZXMainColor;
            cells.yesWater.selected = YES;
            cells.noneWater.selected = NO;
        }
        //流水状态点击事件
        cells.clickStatusBlock = ^(NSString *str)
        {
            self.model.flow = str;
            self.liushuiStatus = str;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            BPBussinessFlowFlagTableViewCell *cells = [tableView cellForRowAtIndexPath:indexPath];
            cells.no.business_cornerRadius = 13.5;
            cells.yes.business_cornerRadius = 13.5;
        };
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        return cells;
    }else if (indexPath.row == 7){
        //盈利状况
        
        BPBussinessFlowFlagTableViewCell *cells = [[TRZXBPBundle loadNibNamed:@"BPBussinessFlowFlagTableViewCell" owner:self options:nil] firstObject];
        [self initPlanStatus:cells];
        return cells;
    }
    else
    {
        cell = [[BPProjectMsgCell alloc]initWithTitle:self.dataSource[indexPath.row] PlaceHoder:self.attributeDataSource[indexPath.row] CountCharacter:@"90字" TextViewMsg:self.textArray[indexPath.row]];
        cell.textViewMsg.delegate = self;
        cell.textViewMsg.textColor = BPheizideColor;
        cell.textViewMsg.tag = TagText + indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)initPlanStatus:(BPBussinessFlowFlagTableViewCell *)cells{
    [cells.flowMoneyText addTarget:self action:@selector(flowMoneyTextChange:) forControlEvents:UIControlEventEditingChanged];
    [cells.glowMoneyTF addTarget:self action:@selector(flowMoneyTextChange:) forControlEvents:UIControlEventEditingChanged];
    cells.flowMoneyText.text = self.model.money;
    cells.glowMoneyTF.text = self.model.gainMoney;
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.model.gainFlag isEqualToString:@"0"]) {
        cells.no.selected = YES;
        cells.yes.selected = NO;
        cells.no.backgroundColor = BPTRZXMainColor;
        cells.yes.backgroundColor = BPbackColor;
        
        cells.titles3.hidden = YES;
        cells.danwei.hidden = YES;
        cells.glowMoneyTF.hidden = YES;
        
    }else if ([self.model.gainFlag isEqualToString:@"1"])
    {
        cells.no.backgroundColor = BPbackColor;
        cells.yes.backgroundColor = BPTRZXMainColor;
        cells.yes.selected = YES;
        cells.no.selected = NO;
        cells.titles3.hidden = NO;
        cells.danwei.hidden = NO;
        cells.glowMoneyTF.hidden = NO;
    }
    
    if ([self.liushuiStatus isEqualToString:@"1"]) {
        cells.hidden = NO;
    }else
    {
        cells.hidden = YES;
    }
    cells.flowStatusBlock = ^(NSString *string)
    {
        self.model.gainFlag = string;
    };
    
}

- (void)changeHeight
{
    CGFloat frame;
    if (self.photoArray.count < 3)
    {
        frame= (BPSCREEN_WIDTH-16)/3 * 1+10;
    }else
    {
        frame = (BPSCREEN_WIDTH-16)/3 * 2+7.5+10;
    }
    self.collectionview.frame =CGRectMake(8, 10, BPSCREEN_WIDTH-2*8, frame);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        if (self.photoArray.count < 3)
        {
            return (BPSCREEN_WIDTH-16)/3 * 1+10;
        }else
        {
            return (BPSCREEN_WIDTH-16)/3 * 2+7.5+10;
        }
        
    }else if (indexPath.row <3) {
        return [self.heightArr[indexPath.row] floatValue];
    }else if (indexPath.row == 6)
    {
        return 65;
    }else if (indexPath.row == 7)
    {
        
        if ([self.liushuiStatus isEqualToString:@"1"]) {
            return 161;
        }
        return 0;
    }
    return [[self.heightArr lastObject] floatValue];
}
#pragma mark - cell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 照片选择
- (void)presentChoosePhoto
{
    AJPhotoPickerViewController *picker = [[AJPhotoPickerViewController alloc] init];
    picker.maximumNumberOfSelection = photoCount - self.photoArray.count;
    picker.multipleSelection = YES;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = YES;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return YES;
    }];
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - textViewDelegate

- (void)flowMoneyTextChange:(UITextField *)textField
{
    NSString *string = textField.text;
    
    if (string.length >=8) {
        string = [string substringToIndex:8];
    }
     string = [NSString stringWithFormat:@"%ld",[string integerValue]];
    textField.text = string;
    NSInteger index = textField.tag - tagTefield;
    if (index == 0) {
        self.model.money = textField.text;
    }else
    {
        self.model.gainMoney = textField.text;
    }
}
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
    if(cell.textViewMsg.text.length >= count){
        [cell.textViewMsg scrollRangeToVisible:[cell.textViewMsg.text rangeOfString:toBeString]];
    }
    
    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(count-textView.text.length)];
    
//
//    if (textView.text.length > 90) {
//        cell.textViewMsg.text = [textView.text substringToIndex:90];
//    }
//    cell.countCharacter.text = [NSString stringWithFormat:@"%lu字",(90-textView.text.length)];
    
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


- (void)saveAction:(UIButton *)btn
{
    self.selectedCount = 0;
    NSString *messageAlert =nil;
    if (self.photoArray.count == 0) {
        messageAlert = @"上传产品图片";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:2].length < 1) {
        messageAlert = @"请填写产品类型";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:3].length < 1) {
        messageAlert = @"请填写功能服务";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:4].length < 1) {
        messageAlert = @"请填写市场定位";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self returnTextStringWithIndex:5].length < 1) {
        messageAlert = @"请填写盈利模式";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ((![self.liushuiStatus isEqualToString:@"0"])&&(![self.liushuiStatus isEqualToString:@"1"])) {
        messageAlert = @"请填写流水状态";
        [self alertWithTitle:@"" message:messageAlert];
        return;
    }
    if ([self.liushuiStatus isEqualToString:@"1"]) {
        if ([self.model.money integerValue] < 1 || self.model.money.length < 1) {
            messageAlert = @"请填写每月流水";
            [self alertWithTitle:@"" message:messageAlert];
            return;
        }
        if ((![self.model.gainFlag isEqualToString:@"0"])&&(![self.model.gainFlag isEqualToString:@"1"])) {
            messageAlert = @"请填写盈利状况";
            [self alertWithTitle:@"" message:messageAlert];
            return;
        }
        if ([self.model.gainFlag isEqualToString:@"1"]) {
            if ([self.model.gainMoney integerValue] < 1 || self.model.gainMoney.length < 1) {
                messageAlert = @"请填写每月营业";
                [self alertWithTitle:@"" message:messageAlert];
                return;
            }
        }
    }
    //    if ([self returnTextStringWithIndex:5].length < 1) {
    //        messageAlert = @"请填写盈利模式";
    //        [self alertWithTitle:@"" message:messageAlert];
    //        return;
    //    }
    if ([self returnTextStringWithIndex:8].length > 1) {
        self.selectedCount ++;
    }
    if ([self returnTextStringWithIndex:9].length > 1) {
        self.selectedCount ++;
    }
    if ([self returnTextStringWithIndex:10].length > 1) {
        self.selectedCount ++;
    }
    if ([self returnTextStringWithIndex:11].length > 1) {
        self.selectedCount ++;
    }
    
    //    [self alertWithTitle:[NSString stringWithFormat:@"选填项填写了%ld项",(long)self.selectedCount] message:@"可以保存啦~~~~~"];
    [self postData];
}

- (void)changeModleValue{
    self.photoArray = self.photoArray;
    self.model.productType = [self.textArray objectAtIndex:2];
    self.model.function = [self.textArray objectAtIndex:3];
    self.model.market = [self.textArray objectAtIndex:4];
    self.model.gain = [self.textArray objectAtIndex:5];
    self.model.flow = self.liushuiStatus;
    self.model.channel = [self.textArray objectAtIndex:8];
    self.model.strategy = [self.textArray objectAtIndex:9];
    self.model.risk = [self.textArray objectAtIndex:10];
    self.model.control = [self.textArray objectAtIndex:11];
}

#pragma mark - 上传数据---------~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)postData
{
    [self changeModleValue];
    
    self.saveBtn.enabled = NO;
    
//    [LCProgressHUD showLoading:@"正在上传"];

    [KipoMyBusinessPlanViewModel addbusinessModelDataMID:nil modelData:self.model imageData:self.photoArray success:^(id json) {
        
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            if (self.saveBMBlock) {
                NSString *str = [NSString stringWithFormat:@"%ld/4",(long)self.selectedCount];
                self.saveBMBlock(str);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            self.saveBtn.enabled = YES;
            self.flow = nil;
            self.plan = nil;
            
            return;
        }
        
        self.saveBtn.enabled = YES;
//        [LCProgressHUD showFailure:@"保存失败"];

    } failure:^(NSError *error) {
//        [NSObject showError:error];
        self.saveBtn.enabled = YES;
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = BPbackColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 120;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView.backgroundColor = BPbackColor;
    }
    return _tableView;
}
- (void)initData
{
    _dataSource = @[@"",
                    @"上传产品图片 *",
                    @"产品类型 *",
                    @"功能服务 *",
                    @"市场定位 *",
                    @"盈利模式 *",
                    @"流水状态 *",
                    @"",
                    @"推广渠道",
                    @"推广策略",
                    @"风险预测",
                    @"控制策略"
                    ];
    _attributeDataSource = @[@"",
                             @"如有产品图片、店铺照片、或软件截图请点 击“浏览”上传，最多4张（建议图片大小不超过500kb）",
                             @"例如:提供情商咨询、测试，培训为一体的培训机构，教学点主要集中在居民小区内。",
                             @"例如:我们为儿童提供情商测试，自闭症治疗，沟通能力提升、情绪疏导等咨询和培训服务。有效帮助儿童提升情商指数，帮助儿童获取更好的沟通能力，从而帮助更好的提升综合素质，提升未来走向社会的竞争力。",
                             @"例如:我们定位为工薪阶层消费的起的儿童情商教育，在北京市朝阳区及望京地区同类机构中占据领先地位",
                             @"例如:我们通过收取儿童情商教育的培训费获取盈利",
                             @"",
                             @"",
                             @"例如:我们通过联合少年宫、中小学举办儿童情商讲座；商超、居民区内散发广告传单；与大型企业联合举办亲子夏令营等方式进行推广；",
                             @"例如:我们通过联合中小学、少年宫等机构举办儿童情商讲座直接获取用户，单场活动转化率约15~20%",
                             @"例如:关于《民办教育法》的政策风险，我机构暂时未取得教委颁发的教育资质",
                             @"例如:我们可以挂靠到北师大附中或者北京市少年宫的儿童培训中心，支付一定的挂靠费用。"
                             ];
    _heightArr = @[@"212",@"76",@"175"];
    self.liushuiStatus = self.model.flow;
}
//填写信息
- (NSMutableArray *)textArray
{
    if (!_textArray) {
        
        NSString *productType = self.model.productType?self.model.productType:@"";
        NSString *function = self.model.function?self.model.function:@"";
        NSString *market = self.model.market?self.model.market:@"";
        NSString *gain = self.model.gain?self.model.gain:@"";
        NSString *flow = self.model.flow?self.model.flow:@"";
        NSString *channel = self.model.channel?self.model.channel:@"";
        NSString *strategy = self.model.strategy?self.model.strategy:@"";
        NSString *risk = self.model.risk?self.model.risk:@"";
        NSString *control = self.model.control?self.model.control:@"";
        
        _textArray = [NSMutableArray arrayWithArray:@[@"",@"",productType,function,market,gain,flow,@"",channel,strategy,risk,control,@"",@""]];
    }
    return _textArray;
}
//照片
- (NSMutableArray *)photoArray
{
    if (!_photoArray) {
        if ([BusinessMemoryCacheTool PicPlans]) {
            NSMutableArray * muArr = [[NSMutableArray alloc]init];
            for (NSData *data in [BusinessMemoryCacheTool PicPlans]) {
                UIImage *ima = [UIImage imageWithData:data];
                [muArr addObject:ima];
            }
            _photoArray = [muArr mutableCopy];
        }else{
            _photoArray = [NSMutableArray array];
        }
    }
    return _photoArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 记忆添加
- (void)backAction{
    
    [self changeModleValue];
    //模型转字典
    NSDictionary *dict = [self.model mj_keyValues];
    //本地化存储
    [BusinessMemoryCacheTool memoryCacheBusinessWithDict:dict];
    
    [BusinessMemoryCacheTool memoryPicWithDict:self.photoArray];
    
    self.flow = nil;
    self.plan = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NewBPBusinessModel *)model
{
    if (!_model) {
        
        
        NSDictionary *dict = [BusinessMemoryCacheTool Business];
        
        if ([NewBPBusinessModel mj_objectWithKeyValues:dict]) {
            _model = [NewBPBusinessModel mj_objectWithKeyValues:dict];
        }else{
            _model = [[NewBPBusinessModel alloc]init];
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
