//
//  ODCreateWallet.h
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/4/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODCreateWallet : NSObject


@property(nonatomic,retain) NSString * identifier;


+(ODCreateWallet*)instantiateWithDictionnary:(NSDictionary*)dictionnary;


@end
