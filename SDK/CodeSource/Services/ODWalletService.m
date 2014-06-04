//
//  WalletService.m
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODWalletService.h"


//Constants
#import "ODBlockChainConstants.h"

//Vendor
#import "NSURLConnection+Blocks.h"

//Domain
#import "ODBlockChainError.h"
#import "ODCreateWallet.h"

@interface ODWalletService()
{
    
}

@end


/*
 The create_wallet method can be used to create a new blockchain.info bitcoin wallet. It can be created containing a pre-generated private key or will otherwise generate a new private key.
 
 @password: The password for the new wallet. Must be at least 10 characters in length.
 @api_code: An API code with create wallets permission.
 @priv: A private key to add to the wallet (Wallet import format preferred). (Optional)
 @label: A label to set for the first address in the wallet. Alphanumeric only. (Optional)
 @email: An email to associate with the new wallet i.e. the email address of the user you are creating this wallet on behalf of. (Optional)
 
 Response: 200 OK, application/json
 
 {
 "guid": "4b8cd8e9-9480-44cc-b7f2-527e98ee3287",
 "address": "12AaMuRnzw6vW6s2KPRAGeX53meTf8JbZS",
 "link": "https://blockchain.info/wallet/4b8cd8e9-9480-44cc-b7f2-527e98ee3287"
 }
 
 Error Response: Error 500, text/plain
 
 Missing Parameter Password
 */
@implementation ODWalletService

+(void)createWalletWithName:(NSString*)name withPassword:(NSString*)password andAPIKey:(NSString*)apiKey andEmail:(NSString*)email
                    success:(void(^)(ODCreateWallet*))successBlock
                    failure:(void(^)(ODBlockChainError*))failureBlock
{
    // TODO: password >= 10 char
    NSAssert([password length]<10, @"Password must be at least 10 characters in length.");
    // TODO: ApiKey == ?
    // TODO: verify email
    // TODO: label -> Alphanumeric only.
    
    NSURL *url= [NSURL URLWithString:kBlockChainUrlCreateWallet];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:kBlockChainPOST];
    
    /*
     $password The password for the new wallet. Must be at least 10 characters in length.
     $api_code An API code with create wallets permission.
     $priv A private key to add to the wallet (Wallet import format preferred). (Optional)
     $label A label to set for the first address in the wallet. Alphanumeric only. (Optional)
     $email*/
    
    NSMutableString *postKeys = [NSMutableString stringWithFormat:@"?api_code=%@",apiKey];
    
    [postKeys appendFormat:@"&password=%@",password];
    
    if (name != nil) {
        [postKeys appendFormat:@"&label=%@",name];
    }
    
    if (email != nil) {
        [postKeys appendFormat:@"&email=%@",email];
    }
    
    
    [request setHTTPBody:[postKeys dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection asyncRequest:request
                          success:^(NSData *data, NSURLResponse *response) {
                              
                              NSError *error = nil;
                              
                              id object = [NSJSONSerialization
                                           JSONObjectWithData:data
                                           options:0
                                           error:&error];
                              
                              if(error) {
                                  // TODO: ERROR PARSE
                                  failureBlock([ODBlockChainError parseError]);
                              }
                              
                              if (![object isKindOfClass:[NSDictionary class]]) {
                                  // TODO: NOT WAITED OBJECT
                                  failureBlock([ODBlockChainError parseError]);
                              }else{
                                  
                                  ODCreateWallet *createWallet = [ODCreateWallet instantiateWithDictionnary:object];
                                  
                                  if (createWallet == nil) {
                                      // TODO: MISSING PARAMETERS
                                      failureBlock([ODBlockChainError new]);
                                  }else{
                                      successBlock(createWallet);
                                  }
                              }
                          }
                          failure:^(NSData *data, NSError *error) {
                              
                              // TODO: need implemented, manage?
                              failureBlock([ODBlockChainError new]);
                          }];
}






@end