//
//  ODSingleAddress.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 7/1/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation


class ODSingleAddress : NSObject {
    
    var hash160 : NSString;
    var address : NSString;
    var nTx : NSNumber;
    var nUnredeemed : NSNumber;
    var totalReceived : NSNumber;
    var totalSent : NSNumber;
    var finalBalance : NSNumber;
    //"txs":[--Array of Transactions--]
    //var tx : NSArray;
    
    //Constructor
    init()
    {
        self.hash160 = "";
        self.address = "";
        self.nTx = 0;
        self.nUnredeemed = 0;
        self.totalReceived = 0;
        self.totalSent = 0;
        self.finalBalance = 0;
    }
    
    //Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODSingleAddress
    {
        var singleAddress : ODSingleAddress = ODSingleAddress();
        singleAddress.hash160 = dic.valueForKey("hash160") as NSString!;
        singleAddress.address = dic.valueForKey("address") as NSString!;
        singleAddress.nTx = dic.valueForKey("n_tx") as NSNumber!;
        //singleAddress.nUnredeemed = dic.valueForKey("n_unredeemed") as NSNumber!;
        singleAddress.totalReceived = dic.valueForKey("total_received") as NSNumber!;
        singleAddress.totalSent = dic.valueForKey("total_sent") as NSNumber!;
        singleAddress.finalBalance = dic.valueForKey("final_balance") as NSNumber!;
        return singleAddress;
    }
    
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        //TODO : undev
        if(response.hasPrefix("Illegal character")){
            return ODBCErrorAPI.IllegalCharacter;
        }else if(response.isEqualToString("Sorry this is is not a valid  hash 160")){
            return ODBCErrorAPI.Hash;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
}