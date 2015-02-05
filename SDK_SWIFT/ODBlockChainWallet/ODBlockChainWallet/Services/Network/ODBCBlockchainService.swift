//
//Copyright 2014 Olivier Demolliens - @odemolliens
//
//Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
//
//file except in compliance with the License. You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software distributed under
//
//the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
//
//ANY KIND, either express or implied. See the License for the specific language governing
//
//permissions and limitations under the License.
//
//

import Foundation


class ODBCBlockchainService
{
    
    /*
    Retrieve information about one block with index number
    Return ODBlock with block information
    Knowed Errors
    case Unknow
    case Hash -> TODO Never return by server
    case Index -> TODO Never return by server
    case NotFound
    */
    class func singleBlockIndex(index : NSString, success :(ODBlock) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL(string:NSString(format : "%@%@",kBCUrlBlockInfo,index))!;
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
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
    case Hash
    case Index
    case NotFound
    */
    class func singleBlockHash(hash : NSString, success :(ODBlock) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        url = NSURL(string:NSString(format : "%@%@",kBCUrlBlockInfo,hash))!;
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
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
        
        url = NSURL(string:NSString(format : "%@%@?format=json",kBCUrlTransactionInfo,hash))!;
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
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
        
        url = NSURL(string:NSString(format : "%@%@",kBCUrlTransactionInfo,index))!;
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
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
    -> limit : Optional limit parameter to show n transactions e.g. &limit=50 (Max 50)
    -> offset : Optional offset parameter to skip the first n transactions e.g. &offset=100 (Page 2 for limit 50)
    -> ! Use -1 if you don't need to use the parameters - /// TODO fix nil object when implement
    Knowed Errors
    case Unknow
    case Hash
    */
    class func singleAddressHash(hash : NSString, limit : NSNumber, offset : NSNumber, success :(ODSingleAddress) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Optionnal keys
        if(/*limit != nil*/ limit != -1){
            postKeys.appendFormat("%@limit=%@", firstCharKeys,limit);
            firstCharKeys = "&";
        }
        
        if(/*offset != nil*/ offset != -1){
            postKeys.appendFormat("%@offset=%@", firstCharKeys,offset);
            firstCharKeys = "&";
        }
        
        url = NSURL(string:NSString(format : "%@%@%@%@format=json",kBCUrlTransactionSingleAddress,hash,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!,firstCharKeys))!;
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
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
    
    /*Retrieve information about a multi address
    Latest 50 Transactions on each address
    Knowed Errors
    case Unknow
    */
    
    //Disabled because doesn't work same as the documentation https://blockchain.info/api/blockchain_api
    //If you want try by yourself - don't forget uncomment in test ;) (ODBCAPI)
    /*class func multiAddress(addressList : NSArray, success :(NSArray) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
    var url : NSURL;
    var request : NSMutableURLRequest;
    
    var postKeys : NSMutableString = NSMutableString();
    
    var firstCharKeys : NSString = "|";
    
    
    for(var i = 0; i < addressList.count;i++){
    
    var adress : NSString = addressList.objectAtIndex(i) as NSString!;
    
    if(postKeys.length==0){
    postKeys.appendFormat("%@", adress);
    }else{
    postKeys.appendFormat("%@%@", firstCharKeys,adress);
    }
    }
    
    //first params is in constants url
    firstCharKeys = "&";
    
    url = NSURL(string:NSString(format : "%@%@%@format=json",kBCUrlTransactionMultiAddress,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding),firstCharKeys));
    
    request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
    
    ODBlockChainService.manageRequest(request,
    success:{(object : AnyObject) -> Void in
    if(object.isKindOfClass(NSArray)){
    var dic : NSArray = object as NSArray;
    
    var mArray : NSMutableArray = NSMutableArray();
    
    for(var j = 0; j < addressList.count;j++){
    var singleAdress : NSDictionary = addressList.objectAtIndex(j) as NSDictionary!;
    mArray.addObject(ODSingleAddress.instantiateWithDictionnary(singleAdress));
    }
    
    success(mArray);
    
    }else{
    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
    }
    },failure:{(error : ODBlockChainError) -> Void in
    failure(error);
    });
    }*/
    
    
    
    
    //TODO : Chart Data / Block Height / Unspent outputs / Latest Block / Unconfirmed Transactions / Blocks / Inventory Data
    
    
    
}
