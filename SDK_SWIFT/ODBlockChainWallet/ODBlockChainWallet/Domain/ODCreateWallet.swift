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
    
    //Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODCreateWallet
    {
        var createWallet : ODCreateWallet = ODCreateWallet();
        createWallet.guid = dic.valueForKey("guid") as NSString;
        createWallet.address = dic.valueForKey("address") as NSString;
        createWallet.link = dic.valueForKey("link") as NSString;
        
        return createWallet;
    }
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.isEqualToString("Password Must be greater than 10 characters in length")){
            return ODBCErrorAPI.PasswordLength;
        }else if(response.isEqualToString("Authorization Key invalid or disabled")){
            return ODBCErrorAPI.ApiKey;
        }else if(response.isEqualToString("Invalid Email")){
            return ODBCErrorAPI.InvalidEmail;
        }else if(response.isEqualToString("Label Must be alphanumeric")){
            return ODBCErrorAPI.AlphaNumericOnly;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    //Methods
    
}

