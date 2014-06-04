//
//  ODCreateWallet.m
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODCreateWallet.h"

@implementation ODCreateWallet



+(ODCreateWallet*)instantiateWithDictionnary:(NSDictionary*)dictionnary
{
    NSString *guid = [dictionnary valueForKey:@"guid"];
    NSString *address = [dictionnary valueForKey:@"address"];
    NSString *link = [dictionnary valueForKey:@"link"];
    
}


@end
