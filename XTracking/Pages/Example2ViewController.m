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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 页面标记
        self.tk_page = [[TKPageContext alloc] initWithPageId:@"Example2ViewController" userData:@{@"name": @"Example2"}];
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Example2";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"EmptyView";
    vc.tk_page = [[TKPageContext alloc] initWithPageId:@"EmptyViewController" userData:@{@"name": @"Empty"}];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)appStart:(TKPageContext *)context {
    NSLog(@"App Start Tracking 进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.appStartTimeStamp.intValue, context.appEndTimeStamp.intValue, context.appEndDuration.intValue, context.pageBrowseDuration.intValue);
}

- (void)appEnd:(TKPageContext *)context {
    NSLog(@"App End Tracking 进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.appStartTimeStamp.intValue, context.appEndTimeStamp.intValue, context.appEndDuration.intValue, context.pageBrowseDuration.intValue);
}

- (void)appTerminate:(TKPageContext *)context {
    NSLog(@"App Terminate Tracking 进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.appStartTimeStamp.intValue, context.appEndTimeStamp.intValue, context.appEndDuration.intValue, context.pageBrowseDuration.intValue);
}

- (void)pageLoaded:(TKPageContext *)context {
    NSLog(@"Page Loaded Tracking 进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.appStartTimeStamp.intValue, context.appEndTimeStamp.intValue, context.appEndDuration.intValue, context.pageBrowseDuration.intValue);
}

- (void)pageEntry:(TKPageContext *)context {
    NSLog(@"Page Entry Tracking 进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.appStartTimeStamp.intValue, context.appEndTimeStamp.intValue, context.appEndDuration.intValue, context.pageBrowseDuration.intValue);
}

- (void)pageExit:(TKPageContext *)context {
    NSLog(@"Page Exit Tracking 进入页面时间戳：%d, 退出页面时间戳: %d，进入前台时间戳：%d, 进入后台时间戳：%d, 页面在后台时长：%d, 页面浏览总时长：%d", context.pageEntryTimeStamp.intValue, context.pageExitTimeStamp.intValue, context.appStartTimeStamp.intValue, context.appEndTimeStamp.intValue, context.appEndDuration.intValue, context.pageBrowseDuration.intValue);
}

@end
