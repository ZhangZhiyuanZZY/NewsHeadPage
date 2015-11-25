//
//  ZYHeadlineNewsController.m
//  新闻首页
//
//  Created by 章芝源 on 15/11/22.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYHeadlineNewsController.h"

@interface ZYHeadlineNewsController ()

@end

@implementation ZYHeadlineNewsController

static NSString * const ID = @"headline";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -- %ld", self.title, indexPath.row];

    return cell;
}



@end
