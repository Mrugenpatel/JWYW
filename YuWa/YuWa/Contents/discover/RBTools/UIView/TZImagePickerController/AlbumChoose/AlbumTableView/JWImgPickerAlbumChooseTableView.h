//
//  JWImgPickerAlbumChooseTableView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWImgPickerAlbumChooseTableView : UITableView

@property (nonatomic,copy)void(^choosedTypeBlock)(NSString *,NSString *);

@property (nonatomic,strong)NSArray * dataArr;

@end
