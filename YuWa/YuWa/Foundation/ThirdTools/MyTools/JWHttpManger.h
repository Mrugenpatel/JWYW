//
//  JWHttpManger.h
//  YuWaShop
//
//  Created by 蒋威 on 16/12/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface JWHttpManger : AFHTTPRequestOperationManager<MBProgressHUDDelegate>
@property(nonatomic,strong)MBProgressHUD*HUD;

//没有HUD 的get 请求
-(void)getDatasNoHudWithUrl:(NSString*)urlStr withParams:(NSDictionary*)params compliation:(resultBlock)newBlock;
//有HUD 的get 请求
-(void)getDatasWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params compliation:(resultBlock)newBlock;
//没有 HUD  post 请求
-(void)postDatasNoHudWithUrl:(NSString*)urlStr withParams:(NSDictionary*)params compliation:(resultBlock)newBlock;
//有HUD  post 请求
-(void)postDatasWithUrl:(NSString*)urlStr withParams:(NSDictionary*)params compliation:(resultBlock)newBlock;

-(void)postUpdatePohotoWithUrl:(NSString*)urlStr withParams:(NSDictionary*)params withPhoto:(NSData*)data compliation:(resultBlock)newBlock;

#pragma mark - Singleton
+ (id)shareManager;

@end
