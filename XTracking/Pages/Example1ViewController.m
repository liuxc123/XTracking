//
//  Example1ViewController.m
//  XTracking
//
//  Created by liuxc on 2022/11/11.
//

#import "Example1ViewController.h"
#import "Example2ViewController.h"
#import "XTracking.h"

@interface Example1UITableViewCell : UITableViewCell

@end

@implementation Example1UITableViewCell

- (void)dealloc {
    NSLog(@"Example1UITableViewCell dealloc");
}

@end

@interface Example1ViewController ()

@end

@implementation Example1ViewController

- (void)dealloc {
    NSLog(@"Example1ViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.isDelay = YES;
     self.isReuse = YES;
    
    [self updateNavigationItem];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 100;

    // 开启监控
    [[TKExposeTracking shared] registExposeEventLifeIndicator:self handler:^(UIView * _Nonnull view, TKExposeContext * _Nonnull expose, BOOL isInBackground) {
        Example1UITableViewCell *cell = (Example1UITableViewCell *)view;
        if (cell) {
            cell.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
        }
    }];
    
    // TODO: 不复用的时候，reloadData 的时候把 view 给刷走了，那么新数据和旧数据会走 show 和 hide 吗？
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)updateNavigationItem {
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(handleReloadData)]];
    self.navigationItem.rightBarButtonItems = items;
}

- (void)handleReloadData {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Example1UITableViewCell *cell = nil;
    if (self.isReuse) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ?: [[Example1UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    } else {
        NSString *uniqKey = [NSString stringWithFormat:@"%@%@", @(indexPath.row), @([[TKPageTracking shared] currentDate].timeIntervalSince1970 * 1000)];
        cell = [[Example1UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:uniqKey];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.text = cell.textLabel.text && cell.textLabel.text.length > 0 ? [NSString stringWithFormat:@"复用堆栈 %@ - %@ (黄色代表曝光)", @(indexPath.row), [cell.textLabel.text substringWithRange:NSMakeRange(5, cell.textLabel.text.length - 13)]] : [NSString stringWithFormat:@"复用堆栈 %@ (黄色代表曝光)", @(indexPath.row)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"cell: %p", cell];
    
    // 曝光标记
    cell.tk_exposeContext = [[TKExposeContext alloc] initWithTrackingId:[NSString stringWithFormat:@"Example1%@", @(indexPath.row)] userData:@{@"row": @(indexPath.row)}];
    
    // 事件标记
    cell.tk_actionContext = [[TKActionContext alloc] initWithTrackingId:[NSString stringWithFormat:@"Example1%@", @(indexPath.row)] userData:@{@"row": @(indexPath.row)}];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Example2ViewController *vc = [[Example2ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
