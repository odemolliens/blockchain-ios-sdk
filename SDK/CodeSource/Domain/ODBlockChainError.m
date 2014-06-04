//
//  ODBlockChainError.m
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODBlockChainError.h"

@implementation ODBlockChainError



#pragma mark Constructor


+(ODBlockChainError*)parseError:(NSError*)parseError;
{
    ODBlockChainError *error = [[[ODBlockChainError alloc]init]autorelease];
    
    [error setType:ODBCErrorParse];
    [error setError:parseError];
    
    return error;
}

+(ODBlockChainError*)parseErrorMissingKeys:(NSDictionary*)missingKeys;
{
    ODBlockChainError *error = [[[ODBlockChainError alloc]init]autorelease];
    
    NSError *errorMissingKeys = [[NSError alloc]initWithDomain:@"ParseError" code:-50 userInfo:missingKeys];
    
    [error setType:ODBCErrorMissingKeys];
    [error setError:errorMissingKeys];
    
    [errorMissingKeys release],errorMissingKeys = nil;
    
    return error;
}


+(ODBlockChainError*)network:(NSError*)networkError
{
    ODBlockChainError *error = [[[ODBlockChainError alloc]init]autorelease];
    
    [error setType:ODBCErrorNetwork];
    [error setError:networkError];
    
    return error;
}


@end
