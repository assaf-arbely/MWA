//
//  APIModel.m
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import "APIModel.h"
#import "Constants.h"

NSString const *kBaseUrl = @"https://httpbin.org/get";

static CGFloat defaultTimeout = 60.0f;

@implementation APIModel

- (void)GET_RequestWithURL:(NSString *)urlString
                  restPath:(NSArray *)restPath
                    params:(NSDictionary *)restParameters
                  callback:(void (^)(id jsonData, NSError * error))callback{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [self constructURLWith:urlString restPath:restPath urlParameters:restParameters];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:defaultTimeout];
    
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data){
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            BOOL isValid = [NSJSONSerialization isValidJSONObject:jsonObj];
            if (isValid){
                callback(jsonObj, nil);
            } else if (error){
                callback(nil, error);
            } else {
                callback(nil, nil);
                MWALog(@"Unkown Error");
            }
        } else {
            callback(nil, nil);
            MWALog(@"Unkown Error");
        }
    }];
    [getDataTask resume];
}

- (void)POST_RequestWithURL:(NSString *)urlString
                   restPath:(NSArray *)restPath
                     params:(NSDictionary *)restParameters
                   callback:(void (^)(id jsonData, NSError * error))callback{
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *url = [self constructURLWith:urlString restPath:restPath urlParameters:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:defaultTimeout];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    if (restParameters){
    NSData *postData = [NSJSONSerialization dataWithJSONObject:restParameters options:0 error:&error];
    [request setHTTPBody:postData];
    } else {
        MWALog(@"No parameters for this request");
    }
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        BOOL isValid = [NSJSONSerialization isValidJSONObject:jsonObj];
        if (isValid){
            callback(jsonObj, nil);
            MWALog(@"%@",NSStringFromClass([jsonObj class]));
            MWALog(@"%@",jsonObj);
        } else if (error){
            callback(nil, error);
        } else {
            callback(nil, nil);
            MWALog(@"Unkown Error");
        }
    }];
    
    [postDataTask resume];
}


- (NSURL *)constructURLWith:(NSString *)baseURL
                restPath:(NSArray *)path
          urlParameters:(NSDictionary *)parameters{
   
    NSString *lastChar = [baseURL substringFromIndex:[baseURL length] - 1];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",baseURL ,([lastChar isEqualToString:@"/"]) ? @"" : @"/",
                     [path componentsJoinedByString:@"/"]];
    if (parameters){
        NSMutableArray *params = [NSMutableArray new];
        for (NSString *paramName in parameters){
            [params addObject:[NSString stringWithFormat:@"%@=%@", paramName, [parameters[paramName] urlEncoded]]];
        }
        url = [url stringByAppendingFormat:@"?%@",[params componentsJoinedByString:@"&"]];
    }
    return [NSURL URLWithString:url];
}

@end
