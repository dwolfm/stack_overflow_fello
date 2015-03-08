//
//  StackOverflowService.m
//  stackOverflowFellows
//
//  Created by drwizzard on 2/17/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "StackOverflowService.h"
#import "Question.h"
@implementation StackOverflowService


//make this a singleton clas
+(id)sharedService {
    static StackOverflowService *mySharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedService =[[StackOverflowService alloc]init];
    });
    return mySharedService;
}

-(void)fetchQusetionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error)) completionHandler {
    NSString *urlString = @"https://api.stackexchange.com/2.2/";
    urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
    urlString = [urlString stringByAppendingString:searchTerm];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"token"];
    NSLog(@"my token is %@", token);
    if (token){
        urlString = [urlString stringByAppendingString:@"&access_token="];
        urlString = [urlString stringByAppendingString:token];
        urlString = [urlString stringByAppendingString:@"&key=HiyWYNRclaueo2kdwv0QzA(("];
        
    }

    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"this is my url %@", url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionHandler(nil, @"couldNotConnect");
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            switch (statusCode) {
                case 200 ... 299: {
                    
                NSLog(@"Statuscode for seachRequet %d)", (int)statusCode);
                    NSArray *results = [Question questionsFromJSON:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (results){
                            completionHandler(results, nil);
                        } else {
                            completionHandler(nil, @"shearch could not be completed");
                        }
                    });
                    break;
                }
                default:
                    NSLog(@"eek twas a status code waz badd %d", (int)statusCode);
                    break;
            }
        }
    }];
    [dataTask resume];
}


-(void)fetchImageForURL: (NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler{
    dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    dispatch_async(imageQueue, ^{
        NSURL *url = [NSURL URLWithString:avatarURL];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(image);
        });
    }); 
}

@end
