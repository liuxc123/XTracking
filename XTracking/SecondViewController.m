//
//  SecondViewController.m
//  XTracking
//
//  Created by liuxc on 2022/11/10.
//

#import "SecondViewController.h"
#import "XTracking.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tk_page = [[TKPageContext alloc] initWithPageId:@"SecondViewController" userData:@{@"page_id": @"second page"}];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    subview.tk_exposeContext = [[TKExposeContext alloc] initWithTrackingId:@"subview_expose" userData:@{@"user_id": @122}];
    subview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:subview];
}

@end
