//
//  Question.h
//  stackOverflowFellows
//
//  Created by drwizzard on 2/17/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject
+(NSArray *)questionsFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *avatarURL;
@property (strong,nonatomic) UIImage *image;
@end
