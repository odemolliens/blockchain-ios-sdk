//
//  ODBlockChainService.h
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ODBlockChainError;

@interface ODBlockChainService : NSObject
{
    
}

+(void)manageRequest:(NSMutableURLRequest*)request
                        success:(void(^)(id))successBlock
                        failure:(void(^)(ODBlockChainError*))failureBlock;

@end
