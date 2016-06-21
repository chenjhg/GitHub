//
//  UserModel.h
//  znxq
//
//  Created by Arvin Yang on 15/10/20.
//  Copyright © 2015年 Arvin Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

// 用户登陆的token值
@property (nonatomic, copy) NSString *token;
// 用户ID号
@property (nonatomic, assign) NSInteger ID;
// 手机号码
@property (nonatomic, copy) NSString *loginMobile;
// 头像图片
@property (nonatomic, copy) NSString *headPic;
// 身份证号
@property (nonatomic, copy) NSString *idCardNo;
// 姓名
@property (nonatomic, copy) NSString *realName;
// 性别，1代表男性，2代表女性
@property (nonatomic, assign) NSInteger gender;
// 住址
@property (nonatomic, copy) NSString *address;
// 住址ID
@property (nonatomic, copy) NSString *addressIds;
// 住址Code
@property (nonatomic, copy) NSString *addressCode;
// 是否退休
@property (nonatomic, assign) NSInteger isRetire;

+ (instancetype)userModelWithDic:(NSDictionary *)dic;
+ (instancetype)shareUserModel;
+ (void)userLogOut;

@end