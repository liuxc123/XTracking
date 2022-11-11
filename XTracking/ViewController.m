//
//  ViewController.m
//  XTracking
//
//  Created by liuxc on 2022/11/8.
//

#import "ViewController.h"
#import "XTracking.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tk_page = [[TKPageContext alloc] initWithPageId:@"ViewController" userData:@{@"page_id": @"second page"}];
    self.view.tk_exposeContext = [[TKExposeContext alloc] initWithTrackingId:@"view_expose" userData:@{@"user_id": @122}];
    self.actionButton.tk_actionContext = [[TKActionContext alloc] initWithTrackingId:@"button_action" userData:@{@"user_id": @122}];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view addGestureRecognizer:tap];
    self.view.tk_actionContext = [[TKActionContext alloc] initWithTrackingId:@"view_action" userData:@{@"user_id": @122}];
}

- (IBAction)action:(UIButton *)sender {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapGestureAction:(UIGestureRecognizer *)ges {

}

@end
