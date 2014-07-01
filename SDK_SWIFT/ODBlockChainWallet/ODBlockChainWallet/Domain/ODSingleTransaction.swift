//
//  ODSingleTransaction.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/25/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation


class ODSingleTransaction : NSObject
{
    //Domain
    var hashBlock : NSString;
    var ver : NSNumber;
    var vinSz : NSNumber;
    var voutSz : NSNumber;
    var lockTime : NSString;
    var size : NSNumber;
    var relayedBy : NSString;
    var blockHeight : NSNumber;
    var doubleSpend : Bool;
    var time : NSNumber;
    
    /* TODO : undev array inputs
"inputs":[


{
"prev_out":{
"hash":"a3e2bcc9a5f776112497a32b05f4b9e5b2405ed9",
"value":"100000000",
"tx_index":"12554260",
"n":"2"
},
"script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
}

],
"out":[

{
"value":"98000000",
"hash":"29d6a3540acfa0a950bef2bfdc75cd51c24390fd",
"script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
},

{
"value":"2000000",
"hash":"17b5038a413f5c5ee288caa64cfab35a0c01914e",
"script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
}

]*/
    
    
    //Constructor
    init()
    {
        self.doubleSpend  = true;
        self.hashBlock = "";
        self.ver = 0;
        self.vinSz = 0;
        self.voutSz = 0;
        self.lockTime = "";
        self.size = 0;
        self.relayedBy = "";
        self.blockHeight = 0;
        self.time = 0;
    }
    
    //Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODSingleTransaction
    {
        var transaction : ODSingleTransaction = ODSingleTransaction();
        transaction.hashBlock = dic.valueForKey("hash") as NSString!;
        transaction.doubleSpend = dic.valueForKey("double_spend") as Bool!;
        transaction.ver = dic.valueForKey("ver") as NSNumber!;
        transaction.vinSz = dic.valueForKey("vin_sz") as NSNumber!;
        transaction.voutSz = dic.valueForKey("vout_sz") as NSNumber!;
        transaction.size = dic.valueForKey("size") as NSNumber!;
        transaction.relayedBy = dic.valueForKey("relayed_by") as NSString!;
        //transaction.blockHeight = dic.valueForKey("block_height") as NSNumber!;
        //transaction.time = dic.valueForKey("time") as NSNumber!;
        //Server doesn't return locktime -_- - or not always TODO
        //transaction.lockTime = dic.valueForKey("lock_time") as NSString!;
        return transaction;
    }
    
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.isEqualToString("Transaction not found")){
            return ODBCErrorAPI.TransactionNotFound;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    

    
    
}