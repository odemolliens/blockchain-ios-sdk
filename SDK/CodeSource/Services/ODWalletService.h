//
//  WalletService.h
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import <Foundation/Foundation.h>


//Domain
#import "ODBlockChainError.h"
#import "ODCreateWallet.h"

@interface ODWalletService : NSObject
{
    
}

/*
 The create_wallet method can be used to create a new blockchain.info bitcoin wallet. It can be created containing a pre-generated private key or will otherwise generate a new private key.
 
 @name: A label to set for the first address in the wallet. Alphanumeric only. (Optional)
 @password: The password for the new wallet. Must be at least 10 characters in length.
 @apiKey: An API code with create wallets permission.
 @email: An email to associate with the new wallet i.e. the email address of the user you are creating this wallet on behalf of. (Optional)
 */


+(void)createWalletWithName:(NSString*)name withPassword:(NSString*)password andAPIKey:(NSString*)apiKey andEmail:(NSString*)email
                    success:(void(^)(ODCreateWallet*))successBlock
                    failure:(void(^)(ODBlockChainError*))failureBlock;


@end
