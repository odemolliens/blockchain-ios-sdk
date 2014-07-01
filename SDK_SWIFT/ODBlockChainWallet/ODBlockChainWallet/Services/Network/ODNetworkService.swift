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
    class func singleBlockIndex(index : NSString, success :(ODBlock) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlBlockInfo,index));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    
                    success(ODBlock.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            }, failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    /*
    Retrieve information about one block with hash value
    Knowed Errors
    case Unknow
    case InvalidBlockHash
    case InvalidBlockIndex
    case BlockNotFound
    */
    class func singleBlockHash(hash : NSString, success :(ODBlock) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlBlockInfo,hash));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                   
                    success(ODBlock.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
                
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    
    /*
    Retrieve information about a single transaction with an hash
    Knowed Errors
    case Unknow
    case TransactionNotFound
    */
    class func singleTransactionHash(hash : NSString, success :(ODSingleTransaction) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@?format=json",kBlockChainUrlTransactionInfo,hash));

        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;

                    success(ODSingleTransaction.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    /*
    Retrieve information about a single transaction with an index
    Knowed Errors
    case Unknow
    case TransactionNotFound
    */
    class func singleTransactionIndex(index : NSString, success :(ODSingleTransaction) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlTransactionInfo,index));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    
                    success(ODSingleTransaction.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    /*
    Retrieve information about a single address with an hash
    Knowed Errors
    case Unknow
    //http://blockchain.info/address/$hash_160?format=json
    */
    class func singleAddressHash(hash : NSString, success :(ODSingleAddress) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL.URLWithString(NSString(format : "%@%@?format=json",kBlockChainUrlTransactionSingleAddress,hash));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    
                    success(ODSingleAddress.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    
    
    
    
    /*Single Address
    
    http://blockchain.info/address/$hash_160?format=json
    http://blockchain.info/address/$bitcoin_address?format=json
    http://blockchain.info/rawaddr/$bitcoin_address
    
    Optional limit parameter to show n transactions e.g. &limit=50 (Max 50)
    Optional offset parameter to skip the first n transactions e.g. &offset=100 (Page 2 for limit 50)
    
    {
    "hash160":"660d4ef3a743e3e696ad990364e555c271ad504b",
    "address":"1AJbsFZ64EpEfS5UAjAfcUG8pH8Jn3rn1F",
    "n_tx":17,
    "n_unredeemed":2,
    "total_received":1031350000,
    "total_sent":931250000,
    "final_balance":100100000,
    "txs":[--Array of Transactions--]
    }*/
    
    
    
    //TODO : Chart Data / Block Height / Single Address / Multi Address / Unspent outputs / Latest Block / Unconfirmed Transactions / Blocks / Inventory Data
    
    
    
}
