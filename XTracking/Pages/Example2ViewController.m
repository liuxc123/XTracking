//
//  Example2ViewController.m
//  XTracking
//
//  Created by liuxc on 2022/11/11.
//

#import "Example2ViewController.h"
#import "XTracking.h"

@interface Example2ViewController ()

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

@end
