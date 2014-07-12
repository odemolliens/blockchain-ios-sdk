//
//  ODBalanceDetails.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 7/12/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

class ODBalanceDetails : ODBalance
{
    var address : NSString;
    var label : NSString;
    var totalReceived : NSNumber;
    
    //Constructor
    init()
    {
        address = "";
        label = "";
        totalReceived = 0;
    }
    
    //Static Methods
    override class func instantiateWithDictionnary(dic:NSDictionary) -> ODBalanceDetails
    {
        var myBalance : ODBalanceDetails = ODBalanceDetails();
        myBalance.balance = dic.valueForKey("balance") as NSNumber!;
        myBalance.address = dic.valueForKey("address") as NSString!;
        myBalance.label = dic.valueForKey("label") as NSString!;
        myBalance.totalReceived = dic.valueForKey("total_received") as NSNumber!;
        return myBalance;
    }
    
    override class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
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