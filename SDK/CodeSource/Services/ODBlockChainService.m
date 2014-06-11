//
//  ODBlockChainService.m
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODBlockChainService.h"

//Vendor
#import "NSURLConnection+Blocks.h"

//Domain
#import "ODBlockChainError.h"

@interface ODBlockChainService()
{
    
}

@end


@implementation ODBlockChainService

+(void)manageRequest:(NSMutableURLRequest*)request
             success:(void(^)(id))successBlock
             failure:(void(^)(ODBlockChainError*))failureBlock
{
    
    //Generic parameters
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [NSURLConnection asyncRequest:request
                          success:^(NSData *data, NSURLResponse *response) {
                              
                              NSError *error = nil;
                              
                              NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                              
                              id object = [NSJSONSerialization
                                           JSONObjectWithData:data
                                           options:NSJSONReadingAllowFragments
                                           error:&error];
                              
                              if(error) {
                                  failureBlock([ODBlockChainError parseError:error]);
                              }else{
                                  successBlock(object);
                              }
                          }
                          failure:^(NSData *data, NSError *error) {
                              failureBlock([ODBlockChainError network:error]);
                          }];
}

@end
