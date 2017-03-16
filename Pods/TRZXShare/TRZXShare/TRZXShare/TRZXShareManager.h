//
//  TRZXShareManager.h
//  TRZXShare
//
//  Created by N年後 on 2017/3/14.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRZXShareHeader.h"
@interface TRZXShareManager : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, copy) void (^didSelectToTRZXFriendAction)(OSMessage* message); // 投融好友
@property (nonatomic, copy) void (^didSelectToTRZXAction)(OSMessage* message); // 投融圈
@property (nonatomic, copy) void (^didSelectToWeixinAction)(OSMessage* message); // 微信好友
@property (nonatomic, copy) void (^didSelectToWeixinTimelineAction)(OSMessage* message); // 微信时间线
@property (nonatomic, copy) void (^didSelectToQQFriendsAction)(OSMessage* message); // QQ好友
@property (nonatomic, copy) void (^didSelectToQQZoneAction)(OSMessage* message); // QQ空间

-(void)showTRZXShareViewMessage:(TRZXOSMessage*)message;
- (void)hideTRZXShareViewMessage;

#pragma 邀请好友
-(void)showInvitationMessage:(OSMessage*)message index:(NSInteger)index;

@end
