//
//  MenuTableViewController.m
//  stackOverflowFellows
//
//  Created by drwizzard on 2/16/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "MenuTableViewController.h"
#import "WebOAuthViewController.h"

@interface MenuTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

-(void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    if (!token) {
        WebOAuthViewController *webOauthCtlr = [[WebOAuthViewController alloc] init];
        [self presentViewController:webOauthCtlr animated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
