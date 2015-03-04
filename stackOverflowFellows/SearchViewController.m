//
//  SearchViewController.m
//  stackOverflowFellows
//
//  Created by drwizzard on 2/16/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "SearchViewController.h"
#import "StackoverflowSearchBarDelagate.h"
#import "HamburgerViewController.h"
#import "StackOverflowService.h"
#import "Question.h"
@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *myResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:0.7 green: 1 blue: 1 alpha:1];
    self.title = @"Search";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didFinishEditing:(NSString *)searchString {
    NSLog(@"got the string maslug: %@", searchString);
    [[StackOverflowService sharedService] fetchQusetionsWithSearchTerm:searchString completionHandler:^(NSArray *results, NSString *error) {
        if (error) {
            NSLog(@"EEKK TWAZ N ERROR : %@", error);
        } else {
            NSLog(@"No error;");
            if (results){
                self.myResults = results;
                [self.tableView reloadData];
            } else {
                NSLog(@"arg somefin went realy wrong");
            }
            
        }
    } ];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEARCH_CELL"];
    Question *question = self.myResults[indexPath.row];
    cell.textLabel.text = question.title;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
