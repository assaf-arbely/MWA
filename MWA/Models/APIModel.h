//
//  APIModel.h
//  MWA
//
//  Created by Vitalii Popruzhenko on 11.07.16.
//  Copyright © 2016 verint. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIModel : NSObject

- (void)GET_RequestWithURL:(NSString *)urlString
                  restPath:(NSArray *)restPath
                    params:(NSDictionary *)restParameters
                    callback:(void (^)(id jsonData, NSError * error))callback;

- (void)POST_RequestWithURL:(NSString *)urlString
                   restPath:(NSArray *)restPath
                     params:(NSDictionary *)restParameters
                     callback:(void (^)(id jsonData, NSError * error))callback;


@end
