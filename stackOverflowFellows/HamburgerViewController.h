//
//  HamburgerViewController.h
//  stackOverflowFellows
//
//  Created by drwizzard on 2/16/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackoverflowSearchBarDelagate.h"
@interface HamburgerViewController : UIViewController
@property (weak) id <StackoverflowSearchBarDelagate> delagate;

@end
