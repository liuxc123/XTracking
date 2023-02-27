//
//  Example2ViewController.m
//  XTracking
//
//  Created by liuxc on 2022/11/11.
//

#import "Example2ViewController.h"
#import "XTracking.h"

@interface Example2ViewController () <ITKPageObject>

@end

@implementation Example2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Example2";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 页面标记
    self.tk_page = [[TKPageContext alloc] initWithPageId:@"Example2ViewController" userData:@{@"name": @"Example2"}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.title = @"EmptyView";
//    vc.tk_page = [[TKPageContext alloc] initWithPageId:@"EmptyViewController" userData:@{@"name": @"Empty"}];
//    vc.view.backgroundColor = [UIColor yellowColor];
//    [self.navigationController pushViewController:vc animated:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    alert.tk_page = [[TKPageContext alloc] initWithPageId:@"AlertViewController" userData:@{@"name": @"alert"}];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)pageEntry:(TKPageContext *)context {
    NSString *trackingId = context.pageId; //用户声明的trackingId
    id userData = context.userData; //用户声明的业务数据
    
    NSLog(@"Page Entry Tracking 进入页面时间戳：%d, 退出页面时间戳: %d, 页面浏览时长：%d ,进入后台时间：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.pageEntryDuration.intValue, context.appEndDuration.intValue);
}

- (void)pageExit:(TKPageContext *)context {
    NSString *trackingId = context.pageId; //用户声明的trackingId
    id userData = context.userData; //用户声明的业务数据
    NSLog(@"Page Exit Tracking 进入页面时间戳：%d, 退出页面时间戳: %d, 页面浏览时长：%d ,进入后台时间：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.pageEntryDuration.intValue, context.appEndDuration.intValue);
}

@end
