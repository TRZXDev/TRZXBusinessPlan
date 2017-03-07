//
//  MyBussinessFinalViewController.m
//  tourongzhuanjia
//
//  Created by Alen on 16/5/5.
//  Copyright © 2016年 JWZhang. All rights reserved.
//

#import "MyBussinessFinalViewController.h"
#import "BPProjectAlertView.h"
#import "KipoMyBusinessPlanViewModel.h"
#import "KipoMyBusinessPlanViewController.h"
#import "MyBusinessFooterView.h"
#import "TRZXBusinessPlanHeader.h"


@interface MyBussinessFinalViewController ()<BPProjectAlertViewDelegate>{
    UIButton *shareBtn;
    MyBusinessFooterView *footerView;
}

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIButton *putButton;
@property (nonatomic,strong)NSString *bpUserId;

@end

@implementation MyBussinessFinalViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];





    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT - 64-50)];
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:self.webView];
    [self loadString:self.myBussinessUrl];


    _putButton = [[UIButton alloc]initWithFrame:CGRectMake(0, BPSCREEN_HEIGHT - 50, BPSCREEN_WIDTH, 50)];


    if(self.type == 0){
        _putButton.hidden = YES;
        _putButton.frame = CGRectMake(0, 0, 0, 0);
        _webView.frame = CGRectMake(0, 64, BPSCREEN_WIDTH, BPSCREEN_HEIGHT - 64);
    }else if (self.type == 1)
    {
        [_putButton setTitle:@"生成商业计划书" forState:UIControlStateNormal];
    }else if (self.type == 2)
    {
        [_putButton setTitle:@"修改商业计划书" forState:UIControlStateNormal];
    }else
    {
        [_putButton setTitle:@"撰写商业计划书" forState:UIControlStateNormal];
    }
    //
    _putButton.backgroundColor = BPRGBA(215, 0, 15, 1.0);
    [_putButton addTarget:self action:@selector(putButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.putButton];

}
- (void)setNaviBar
{
    self.title = _titleStr;
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];

    NSArray *array = [self.myBussinessUrl componentsSeparatedByString:@"userId="]; //从字符A中分隔成2个元素的数组
    _bpUserId= [array lastObject];



//    if ([[KPOUserDefaults userId] isEqualToString:_bpUserId]) {
//        shareBtn = [[UIButton alloc]init];
//        [self.view addSubview:shareBtn];
//
//        [shareBtn setImage:[UIImage imageNamed:@"28.png"] forState:UIControlStateNormal];
//        [shareBtn setImage:[UIImage imageNamed:@"Insvert分享.png"] forState:UIControlStateSelected];
//        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.trailing.equalTo(self.view.mas_trailing).offset(-20);
//            make.top.equalTo(self.view.mas_top).offset(35);
//            make.height.equalTo(@(18));
//            make.width.equalTo(@(18));
//        }];
//
//        [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.navigationView addSubview:shareBtn];
//
//    }


}




// 让浏览器加载指定的字符串
- (void)loadString:(NSString *)str
{
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = str;
    if (![str hasPrefix:@"http:"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", str];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request]; 
}

- (void)backAction
{
    if (self.type == 2) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self publishBussiness];
        
    }
}

#pragma mark - 生成商业计划书-------
- (void)publishBussiness
{
    //生成
    [KipoMyBusinessPlanViewModel createBusinessPlanMID:nil success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
//            [LCProgressHUD showSuccess:@"生成成功"];   // 显示成功

            if (footerView != nil) {
               [footerView removeFromSuperview];
            }
            
            self.type = 2;
            [self.view addSubview:self.putButton];
            [_putButton setTitle:@"修改商业计划书" forState:UIControlStateNormal];
            
            return;
        }
//        [LCProgressHUD showFailure:@"生成失败"];   // 显示失败
    } failure:^(NSError *error) {
//        [NSObject showError:error];
    }];
}


- (void)putButtonClick:(UIButton *)button
{
    
    if (self.type == 1) {

        [self alertViewStr:@"" and:@"是否确定生成商业计划书"];
    }else if(self.type == 2)
    {
        //修改
        [self updateButtonClick];
    }else
    {
        //编辑商业计划书
        KipoMyBusinessPlanViewController *myBusiness = [[KipoMyBusinessPlanViewController alloc]init];
        myBusiness.titleStr = self.titleStr;
        [self.navigationController pushViewController:myBusiness animated:YES];
    }
    
}

#pragma mark - 修改我的商业计划书
- (void)updateButtonClick
{
    BPProjectAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"ProjectAlertView" owner:nil options:nil] firstObject];
    alert.topLable.text = @"商业计划书修改后";
    alert.leftLable.text = @"需要重新生成";
    alert.delegate = self;
    [self.view addSubview:alert];
    [alert show];
}

#pragma mark - alertDelegate
- (void)AlertView:(BPProjectAlertView *)AlertView okBtnTapped:(id)sender
{
    [KipoMyBusinessPlanViewModel fixBusinessSuccess:^(id json)
     {
         
         NSDictionary *dict = json;
         if ([dict[@"status_code"] isEqualToString:@"200"])
         {
             
             KipoMyBusinessPlanViewController *myBusiness = [[KipoMyBusinessPlanViewController alloc]init];
             myBusiness.titleStr = self.titleStr;
             [self.navigationController pushViewController:myBusiness animated:YES];
             
             return;
         }
     } failure:^(NSError *error) {
     }];
    
}
- (void)AlertView:(BPProjectAlertView *)AlertView cancelBtnTapped:(id)sender
{
}



#pragma mark 分享
-(void)shareAction
{







//    [LCProgressHUD showLoading:@"正在加载"];   // 显示等待
//    [[Kipo_NetAPIManager sharedManager] request_Share_Api_bpInfo_autId:_bpUserId andBlock:^(id data, NSError *error) {
//        if (data) {
//            [LCProgressHUD hide];
//
//            NSString *title =data[@"shareTitle"];
//            NSString *desc= @"查看项目BP,希望和你就项目有深入的交流";
//            NSString * link= self.myBussinessUrl;
//            NSString * objId= data[@"objId"];;
//
//
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:data[@"shareImg"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
//             {
//                 //处理下载进度
//             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//
//                 if (image) {
//
//                     UIImage *testImage = image;
//                     
//                     // bp分享
//                     OSMessage *msg=[[OSMessage alloc]init];
//                     msg.title= title;
//                     msg.desc= desc;
//                     msg.link= link;
//                     msg.image=testImage;//缩略图
//                     msg.type=@"bp";//
//                     msg.objId=objId;//
//                     msg.headURL=data[@"shareImg"];
//                     
//                     [[Kipo_ShareManager sharedManager]showTRZXShareViewMessage:msg];
//                     
//                 }
//             }
//             ];
//
//
//
//            //==============================
//
//
//        }else{
//
//        }
//
//    }];






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
