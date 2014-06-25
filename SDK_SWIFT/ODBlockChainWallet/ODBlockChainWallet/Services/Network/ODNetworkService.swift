//
//  ODNetworkService.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/16/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation


class ODNetworkService
{
    
    /*
    Retrieve information about one block with index number
    Return ODBlock with block information
    Knowed Errors
    case Unknow
    case InvalidBlockHash -> TODO Never return by server
    case InvalidBlockIndex -> TODO Never return by server
    case BlockNotFound
    */
    class func singleBlockIndex(index : NSString, success :(AnyObject) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;

        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlBlockInfo,index));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:success
            ,failure:failure);
    }
    
    /*
    Retrieve information about one block with hash value
    Knowed Errors
    case Unknow
    case InvalidBlockHash
    case InvalidBlockIndex
    case BlockNotFound
    */
    class func singleBlockHash(hash : NSString, success :(AnyObject) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlBlockInfo,hash));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:success
            ,failure:failure);
    }
    
    
    /*
    {
    "hash":"0000000000000bae09a7a393a8acded75aa67e46cb81f7acaa5ad94f9eacd103",
    "ver":1,
    "prev_block":"00000000000007d0f98d9edca880a6c124e25095712df8952e0439ac7409738a",
    "mrkl_root":"935aa0ed2e29a4b81e0c995c39e06995ecce7ddbebb26ed32d550a72e8200bf5",
    "time":1322131230,
    "bits":437129626,
    "nonce":2964215930,
    "n_tx":22,
    "size":9195,
    "block_index":818044,
    "main_chain":true,
    "height":154595,
    "received_time":1322131301,
    "relayed_by":"108.60.208.156",
    "tx":[--Array of Transactions--]
    {
    */
    
    
    
    ///Single Transaction
    
    //http://blockchain.info/rawtx/$tx_index
    //http://blockchain.info/rawtx/$tx_hash
    //http://blockchain.info/tx-index/$tx_index?format=json
    
    class func singleTransactionHash(hash : NSString, success :(AnyObject) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlTransactionInfo,hash));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:success
            ,failure:failure);
    }
    
    /**


**/
    class func singleTransactionIndex(index : NSString, success :(AnyObject) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlTransactionInfo,index));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:success
            ,failure:failure);
    }
    
    /*
    {
    "hash":"b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da",
    "ver":1,
    "vin_sz":1,
    "vout_sz":2,
    "lock_time":"Unavailable",
    "size":258,
    "relayed_by":"64.179.201.80",
    "block_height, 12200,
    "tx_index":"12563028",
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
    
    ]
    }
    */
    
    //TODO : Chart Data / Block Height / Single Address / Multi Address / Unspent outputs / Latest Block / Unconfirmed Transactions / Blocks / Inventory Data
    
    

}
