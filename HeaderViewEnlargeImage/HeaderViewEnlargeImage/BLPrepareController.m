//
//  BLPrepareController.m
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLPrepareController.h"

NSString *const cellID = @"cellID";
@interface BLPrepareController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BLPrepareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setTableView];
}

- (void)setTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
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
