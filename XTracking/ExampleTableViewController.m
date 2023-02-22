//
//  ExampleTableViewController.m
//  XTracking
//
//  Created by liuxc on 2022/11/11.
//

#import "ExampleTableViewController.h"
#import "Example1ViewController.h"
#import "Example2ViewController.h"
#import "XTracking.h"

@interface ExampleTableViewController ()

@end

@implementation ExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 80;
    self.title = @"XTracking";
    self.tk_page = [[TKPageContext alloc] initWithPageId:@"ExampleTableViewController" userData:@{@"name": @"ExampleTable"}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ?: [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.numberOfLines = 0;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"列表滚动触发曝光";
        cell.detailTextLabel.text = @"实时曝光，Cell 有复用";
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"页面监控";
        cell.detailTextLabel.text = @"进入页面监控";
    }
    
    // 事件监控
    [cell setTk_actionContext:[[TKActionContext alloc] initWithTrackingId:cell.textLabel.text userData:@{
        @"indexPath.row": @(indexPath.row),
    }]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Example1ViewController *vc = [[Example1ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {
        Example2ViewController *vc = [[Example2ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
