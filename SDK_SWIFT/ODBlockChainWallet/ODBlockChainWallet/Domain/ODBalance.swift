
//
//  ODBalance.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 7/10/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation


class ODBalance : NSObject
{
    var balance : NSNumber;
    
    //Constructor
    init()
    {
        balance = 0;
    }
    
    //Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODBalance
    {
        var myBalance : ODBalance = ODBalance();
        myBalance.balance = dic.valueForKey("balance") as NSNumber!;
        return myBalance;
    }
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        // TODO : undev
        if(response.isEqualToString(kBCCommonNull) || response.isEqualToString(kBCCommonCloudFare)){
            return ODBCErrorAPI.ApiUnavailable;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    //Methods
    
    
}