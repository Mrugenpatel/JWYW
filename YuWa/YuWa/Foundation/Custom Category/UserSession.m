//
//  UserSession.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "UserSession.h"
#import "JPUSHService.h"

@implementation UserSession
static UserSession * user=nil;

+(UserSession*)instance{
    if (!user) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            user=[[UserSession alloc]init];
        });
        user.token=@"";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [UserSession getDataFromUserDefault];
        });
    }
    
    return user;
}


+(void)clearUser{
    [UserSession saveUserLoginWithAccount:@"" withPassword:@""];
    user = nil;
    user=[[UserSession alloc]init];
    user.token=@"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient].options setIsAutoLogin:NO];
        
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error)MyLog(@"环信退出成功");
        [UserSession getDataFromUserDefault];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
        });
        
        NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
        friendsRequest = [NSMutableArray arrayWithCapacity:0];
        [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
    });
}

+ (void)saveUserLoginWithAccount:(NSString *)account withPassword:(NSString *)password{
    user.account = account;
    [KUSERDEFAULT setValue:account forKey:AUTOLOGIN];
    user.password = password;
    [KUSERDEFAULT setValue:password forKey:AUTOLOGINCODE];
}

//get local saved data
+ (void)getDataFromUserDefault{
    NSString * accountDefault = [KUSERDEFAULT valueForKey:AUTOLOGIN];
    if (accountDefault) {
        if ([accountDefault isEqualToString:@""])return;
        user.account = accountDefault;
        user.password = [KUSERDEFAULT valueForKey:AUTOLOGINCODE];
        [UserSession autoLoginRequestWithPragram:@{@"tel":user.account,@"pwd":user.password}];//根据接口改2333333
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            EMError *errorLog = [[EMClient sharedClient] loginWithUsername:user.account password:user.password];
            if (!errorLog){
                [[EMClient sharedClient].options setIsAutoLogin:NO];
                [[EMClient sharedClient].chatManager getAllConversations];
                MyLog(@"环信登录成功");
            }
            
            [JPUSHService setAlias:user.account callbackSelector:nil object:nil];
        });
    }
}

//auto login
+ (void)autoLoginRequestWithPragram:(NSDictionary *)pragram{
//    [[HttpObject manager]getDataWithType:(kMaldivesType)MaldivesType_Login withPragram:pragram success:^(id responsObj) {
//        MyLog(@"Pragram is %@",pragram);
//        MyLog(@"Data is %@",responsObj);
    [UserSession saveUserInfoWithDic:@{}];
//        [UserSession saveUserInfoWithDic:responsObj[@"data"]];
//    } failur:^(id responsObj, NSError *error) {
//        MyLog(@"Pragram is %@",pragram);
//        MyLog(@"Data Error error is %@",responsObj);
//        MyLog(@"Error is %@",error);
//    }];
}

+ (void)saveUserInfoWithDic:(NSDictionary *)dataDic{
//    user.collection = dataDic[@"collection"];
//    user.newinfo = [NSString stringWithFormat:@"%@",dataDic[@"new_info"]];
//    if (![dataDic[@"sex"] isKindOfClass:[NSNull class]]) {
//        user.sex = dataDic[@"sex"];
//    }
//    user.logo = dataDic[@"logo"];
//    user.point = dataDic[@"point"];
//    user.token = dataDic[@"token"];
//    user.name = dataDic[@"user"];
//    if (![dataDic[@"name"] isKindOfClass:[NSNull class]]) {
//        user.realName = dataDic[@"name"];
//    }
//    if (![dataDic[@"email"] isKindOfClass:[NSNull class]]) {
//        user.email = dataDic[@"email"];
//    }
//    if (![dataDic[@"birthday"] isKindOfClass:[NSNull class]]) {
//        user.birthday = dataDic[@"birthday"];
//    }
//    if (![dataDic[@"city"] isKindOfClass:[NSNull class]]) {
//        user.city = dataDic[@"city"];
//    }
//    user.mobile = dataDic[@"mobile"];
//    user.userid = dataDic[@"userid"];
    
    
    user.isLogin = YES;
}

@end
