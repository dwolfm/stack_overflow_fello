//
//  SearchViewController.h
//  stackOverflowFellows
//
//  Created by drwizzard on 2/16/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackoverflowSearchBarDelagate.h"
@interface SearchViewController : UIViewController <StackoverflowSearchBarDelagate>
@property (strong, nonatomic) UITextField *searchBar;
@end
