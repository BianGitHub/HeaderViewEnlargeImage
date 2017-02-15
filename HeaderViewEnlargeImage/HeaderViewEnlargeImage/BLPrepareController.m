//
//  BLPrepareController.m
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLPrepareController.h"

NSString *const cellID = @"cellID";
#define kHeaderViewHeight 200
@interface BLPrepareController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BLPrepareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 禁止调整顶部缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setTableView];
    [self setHeaderView];
}
    // 修改状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
    
    //视图将要出现时隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
    
- (void)setHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kHeaderViewHeight)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
}
    
- (void)setTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
    
    // 调整表格视图顶部间距
    tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    // 设置滚动指示器的间距
    tableView.scrollIndicatorInsets = tableView.contentInset;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}
@end
