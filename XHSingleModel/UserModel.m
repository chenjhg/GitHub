//
//  UserModel.m
//  znxq
//
//  Created by Arvin Yang on 15/10/20.
//  Copyright © 2015年 Arvin Yang. All rights reserved.
//

#define EWEUserDefaults [NSUserDefaults standardUserDefaults]
#define kToken @"token"
#define kHeadPic @"headPic"
#define kLoginMobile @"loginMobile"
#define kIsRemindRepay @"isRemindRepay"
#define kRegisterTime @"registerTime"
#define kRoleType @"roleType"
#define kAuthStatus @"authStatus"
#define kID @"id"
#define kLastLoginTime @"lastLoginTime"
#define kUserSetting @"userSetting"
#define kUser @"user"

#import "UserModel.h"
#import "AppDelegate.h"
//#import "LoginVC.h"

@interface UserModel()

@end

@implementation UserModel

static UserModel *userModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [super allocWithZone:zone];
    });
    return userModel;
}

- (id)copy
{
    return userModel;
}

+ (instancetype)shareUserModel
{
//    static UserModel *userModel;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        userModel = [[UserModel alloc] init];
        userModel.token = [EWEUserDefaults stringForKey:kToken];
        userModel.ID = [EWEUserDefaults integerForKey:kID];
        userModel.loginMobile = [EWEUserDefaults stringForKey:kLoginMobile];
//        userModel.headPic = [EWEUserDefaults stringForKey:kHeadPic];
        userModel.idCardNo = [EWEUserDefaults stringForKey:@"idCardNo"];
        userModel.realName = [EWEUserDefaults stringForKey:@"realName"];
        userModel.gender = [EWEUserDefaults integerForKey:@"gender"];
        
        userModel.address = [EWEUserDefaults stringForKey:@"address"];
        userModel.addressIds = [EWEUserDefaults stringForKey:@"addressIds"];
        userModel.addressCode = [EWEUserDefaults stringForKey:@"addressCode"];

        userModel.isRetire = [EWEUserDefaults boolForKey:@"isRetire"];
    });
    
    return userModel;
}

+ (instancetype)userModelWithDic:(NSDictionary *)dic
{
    UserModel *userModel = [UserModel shareUserModel];
    userModel.token = [dic objectForKey:kToken];
    [EWEUserDefaults setObject:userModel.token forKey:kToken];

    userModel.addressCode = [dic objectForKey:@"addressCode"];
    [EWEUserDefaults setObject:userModel.addressCode forKey:@"addressCode"];

    NSDictionary *subDic = [dic objectForKey:kUser];
    userModel.ID = [[subDic objectForKey:kID] integerValue];
    [EWEUserDefaults setInteger:userModel.ID forKey:kID];
    
    userModel.loginMobile = [subDic objectForKey:kLoginMobile];
    [EWEUserDefaults setObject:userModel.loginMobile forKey:kLoginMobile];
    
//    userModel.headPic = [subDic objectForKey:kHeadPic];
//    [EWEUserDefaults setObject:userModel.headPic forKey:kHeadPic];
    
    userModel.idCardNo = [subDic objectForKey:@"idCardNo"];
    [EWEUserDefaults setObject:userModel.idCardNo forKey:@"idCardNo"]; 

    userModel.realName = [subDic objectForKey:@"realName"];
    [EWEUserDefaults setObject:userModel.realName forKey:@"realName"];
    
    userModel.gender = [[subDic objectForKey:@"gender"] integerValue];
    [EWEUserDefaults setInteger:userModel.gender forKey:@"gender"];
    

    userModel.address = [subDic objectForKey:@"address"];
    userModel.addressIds = [subDic objectForKey:@"addressIds"];
    userModel.addressCode = [subDic objectForKey:@"addressCode"];
    if (!(userModel.address && userModel.addressIds && userModel.addressIds && userModel.addressCode.length != 0 && userModel.address.length!= 0 && userModel.addressIds.length != 0 && userModel.addressIds.length != 0 && userModel.addressCode.length != 0)) {
        userModel.address = @"暂无信息";
        userModel.addressIds =  @"暂无信息";
        userModel.addressCode =  @"暂无信息";
    }
    [EWEUserDefaults setObject:userModel.address forKey:@"address"];
    [EWEUserDefaults setObject:userModel.addressIds forKey:@"addressIds"];
    [EWEUserDefaults setObject:userModel.addressCode forKey:@"addressCode"];


    userModel.isRetire = [[subDic objectForKey:@"isRetire"] boolValue];
    [EWEUserDefaults setBool:userModel.isRetire forKey:@"isRetire"];
    
    [EWEUserDefaults synchronize];
    return userModel;
    
}

+ (void)userLogOut
{
    UserModel *userModel = [UserModel shareUserModel];
    
    userModel.token = nil;
    [EWEUserDefaults removeObjectForKey:kToken];
    userModel.ID = 0;
    [EWEUserDefaults removeObjectForKey:kID];
    userModel.loginMobile = 0;
    [EWEUserDefaults removeObjectForKey:kLoginMobile];
//    userModel.headPic = nil;
//    [EWEUserDefaults removeObjectForKey:kHeadPic];
    userModel.idCardNo = nil;
    [EWEUserDefaults removeObjectForKey:@"idCardNo"];
    userModel.realName = nil;
    [EWEUserDefaults removeObjectForKey:@"realName"];
    userModel.gender = 0;
    [EWEUserDefaults removeObjectForKey:@"gender"];
    userModel.address = nil;
    [EWEUserDefaults removeObjectForKey:@"address"];
    userModel.addressIds = nil;
    [EWEUserDefaults removeObjectForKey:@"addressIds"];
    userModel.addressCode = nil;
    [EWEUserDefaults removeObjectForKey:@"addressCode"];
    userModel.isRetire = 0;
    [EWEUserDefaults removeObjectForKey:@"isRetire"];

    [EWEUserDefaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogoutNotification object:nil];
//    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
//    loginNav.navigationBar.hidden = YES;
//    [UIApplication sharedApplication].keyWindow.rootViewController = loginNav;
}


@end

