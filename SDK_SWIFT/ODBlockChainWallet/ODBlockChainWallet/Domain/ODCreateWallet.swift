//
//  ODCreateWallet.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation


class ODCreateWallet: NSObject
{
    //Domain
    var guid : NSString;
    var address : NSString;
    var link : NSString;
    
    
    //Constructor
    init()
    {
        self.guid = "";
        self.address = "";
        self.link = "";
    }
    
    //Static
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODCreateWallet
    {
        var createWallet : ODCreateWallet = ODCreateWallet();
        createWallet.guid = dic.valueForKey("guid") as NSString;
        createWallet.address = dic.valueForKey("address") as NSString;
        createWallet.link = dic.valueForKey("link") as NSString;
        
        return createWallet;
    }
    
    
    //Methods
    
}

