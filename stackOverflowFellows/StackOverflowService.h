//
//  StackOverflowService.h
//  stackOverflowFellows
//
//  Created by drwizzard on 2/17/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StackOverflowService : NSObject
+(id)sharedService;
-(void)fetchQusetionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error)) completionHandler;
-(void)fetchImageForURL: (NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler;
@end
