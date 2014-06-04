//
//  ODBlockChainError.h
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ODBCErrorParse,
    ODBCErrorUnexpectedObject,
    ODBCErrorMissingKeys,
    ODBCErrorNetwork
} ODBCError;


@interface ODBlockChainError : NSObject
{
    
}


@property(nonatomic,assign)ODBCError type;

// TODO : retain assign ? custom NSError ?
@property(nonatomic,retain)NSError *error;


+(ODBlockChainError*)parseError:(NSError*)parseError;
+(ODBlockChainError*)parseUnexpectedObject;
+(ODBlockChainError*)parseErrorMissingKeys:(NSDictionary*)missingKeys;
+(ODBlockChainError*)network:(NSError*)networkError;

@end
