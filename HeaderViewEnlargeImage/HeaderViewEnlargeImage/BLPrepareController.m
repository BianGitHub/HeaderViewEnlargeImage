//
//  BLPrepareController.m
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLPrepareController.h"
#import "YYWebImage.h"
#import "UIView+Category.h"

NSString *const cellID = @"cellID";
#define kHeaderViewHeight 200
@interface BLPrepareController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BLPrepareController {
    UIView *_headerView;
    UIImageView *_headerImageView;
    UIView *_lineView;
}

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
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kHeaderViewHeight)];
    // 测量导航栏颜色
    _headerView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1];
    [self.view addSubview:_headerView];
    
    // 顶部视图添加imageVIew
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    _headerImageView.backgroundColor = [UIColor blueColor];
    
    // 设置contentMode
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 设置图像裁切
    _headerImageView.clipsToBounds = YES;
    
    [_headerView addSubview:_headerImageView];
    
    // 加载分割线 1个像素点
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeaderViewHeight - lineHeight, _headerView.bl_width, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    
    // YYWebImageOptionShowNetworkActivity 表示带网络指示器
    // 在此, 使用YYWebImage的好处就是他带有网络指示器, 而SD没有此功能
    // AFN也可以实现添加图片的功能, 而且也带有网络指示器  但是 如果图片太大, 有可能不会缓存, 并且他使用的是系统默认的缓存
    [_headerImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
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
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"%f", scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
//    NSLog(@"%f", offset);
    if (offset <= 0) {
//        NSLog(@"放大");
        //  调整headerView 和 headerImageView
        _headerView.bl_y = 0;
        _headerView.bl_height = kHeaderViewHeight - offset;
        
    } else {
//        NSLog(@"整体移动");
        _headerView.bl_height = kHeaderViewHeight;
        
        // headerView y最小值
        CGFloat min = kHeaderViewHeight - 64;
        _headerView.bl_y = -MIN(min, offset);
        
        // 设置透明度
//        NSLog(@"%f", offset / min);
        // 根据输出可以知道  offset / min == 1 不可见
        _headerImageView.alpha = 1 - (offset / min);
        
    }
    
    _headerImageView.bl_height = _headerView.bl_height;
    
    // 设置分割线的位置
    _lineView.bl_y = _headerView.bl_height - _lineView.bl_height;
}
    
    
@end
