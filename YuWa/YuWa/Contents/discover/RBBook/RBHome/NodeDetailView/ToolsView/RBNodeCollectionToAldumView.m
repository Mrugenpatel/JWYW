//
//  RBNodeCollectionToAldumView.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/9.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBNodeCollectionToAldumView.h"
#import "HttpObject.h"
#import "JWTools.h"
#import "RBNodeAddToAldumTableViewCell.h"

#define ADDTOALDUMCELL @"RBNodeAddToAldumTableViewCell"
@implementation RBNodeCollectionToAldumView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)awakeFromNib{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.alphaBGView addGestureRecognizer:tap];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableBGView.layer.cornerRadius = 5.f;
    self.tableBGView.layer.masksToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:ADDTOALDUMCELL bundle:nil] forCellReuseIdentifier:ADDTOALDUMCELL];
    [self aldumReload];
}
- (void)tapAction{
    self.cancelBlock();
}
- (void)setDataArr:(NSMutableArray *)dataArr{
    if (!dataArr)return;
    _dataArr = dataArr;
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.headView) {
        self.headView = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width - 72.f, 44.f)];
        self.headView.backgroundColor = [UIColor whiteColor];
        self.headView.textAlignment = NSTextAlignmentCenter;
        self.headView.text = @"收藏至我的专辑";
        self.headView.font = [UIFont systemFontOfSize:18.f];
    }
    return self.headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.addToAlbumBlock(indexPath.row);
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RBNodeAddToAldumTableViewCell * addCell = [tableView dequeueReusableCellWithIdentifier:ADDTOALDUMCELL];
    addCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    addCell.model = self.dataArr[indexPath.row];
    return addCell;
}
- (IBAction)addAldumBtnAction:(id)sender {
    self.newAlbumBlock();
}
#pragma mark - Http
- (void)aldumReload{
    [self.dataArr removeAllObjects];
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid)};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_RB_ALDUM withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        [self.tableView reloadData];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }];
    //h333333333
    
    
//    233333333要删
    NSInteger count = [[UserSession instance].aldumCount integerValue] > 0?[[UserSession instance].aldumCount integerValue]:1;
    for (int i = 0; i<count; i++) {
        [self.dataArr addObject:[[RBNodeAddToAldumModel alloc]init]];
    }
    [self.tableView reloadData];
//    233333333要删
    
    
}

@end
