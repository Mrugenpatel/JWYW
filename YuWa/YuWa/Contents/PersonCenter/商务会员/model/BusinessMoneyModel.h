//
//  BusinessMoneyModel.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//"settlement_business" = <null>,
//"total_business" = <null>,
//"today_business" = <null>,
//"my_shop_nums" = 2,
@interface BusinessMoneyModel : NSObject

@property(nonatomic,strong)NSString*settlement_business;   //待结算的收益
@property(nonatomic,strong)NSString*total_business;      //总共的收益
@property(nonatomic,strong)NSString*today_business;  //今天的收益
@property(nonatomic,strong)NSString*my_shop_nums;   //多少家签约店铺

@end
