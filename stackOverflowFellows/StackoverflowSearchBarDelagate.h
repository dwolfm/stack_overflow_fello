//
//  StackoverflowSearchBarDelagate.h
//  stackOverflowFellows
//
//  Created by drwizzard on 2/17/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackoverflowSearchBarDelagate <NSObject>
- (void) didFinishEditing:(NSString *)searchString;
@end
