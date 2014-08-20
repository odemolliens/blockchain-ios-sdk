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

class ODBCWalletService
{
    
    /*
    * Encode all char
    */
    class func encode(toEncode : NSString) -> NSString {
        return CFURLCreateStringByAddingPercentEscapes(
            nil,
            toEncode,
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringBuiltInEncodings.UTF8.toRaw()
        )
    }
    
    
    /*
    Create Wallet Service
    -> Email & Name : parameters are optionnal
    Return an ODWallet object with identifier if successfull
    Knowed Errors
    case Unknow
    case PasswordLength
    case ApiKey
    case Email
    case AlphaNumericOnly
    */
    class func createWallet(name : NSString, apiKey : NSString, password : NSString,  email : NSString, success :(ODWallet) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@api_code=%@", firstCharKeys, apiKey);
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(password));
        
        //Optionnal keys
        if(email.length>0){
            postKeys.appendFormat("%@email=%@", firstCharKeys, email);
        }
        
        if(name.length>0){
            postKeys.appendFormat("%@label=%@", firstCharKeys ,name);
        }
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlCreateWallet,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    success(ODWallet.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    /*
    //TODO : untested
    Making Outgoing Payments
    Send bitcoin from your wallet to another bitcoin address. All transactions include a 0.0001 BTC miners fee.
    -> mainPassword : Your Main My wallet password
    -> secondPassword : Your second My Wallet password if double encryption is enabled (Optional).
    -> to : Recipient Bitcoin Address.
    -> amount : Amount to send in satoshi.
    -> from : Send from a specific Bitcoin Address (Optional)
    shared "true" or "false" indicating whether the transaction should be sent through a shared wallet. Fees apply. (Optional)
    -> fee : Transaction fee value in satoshi (Must be greater than default fee) (Optional)
    -> note : A public note to include with the transaction (Optional)
    Knowed Errors
    case Unknow
    */
    class func makePayment(walletIdentifier : NSString, apiKey : NSString, mainPassword : NSString, secondPassword : NSString, amount : NSNumber, to : NSString,from : NSString,shared : NSNumber,fee : NSNumber,note : NSString, success :(ODPaymentResults) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/payment", walletIdentifier);
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(mainPassword));
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@api_code=%@", firstCharKeys ,apiKey);
        
        postKeys.appendFormat("%@second_password=%@", firstCharKeys, encode(secondPassword));
        
        postKeys.appendFormat("%@amount=%f", firstCharKeys, (amount.floatValue*kBCWalletSatoshi.floatValue));
        
        postKeys.appendFormat("%@to=%@", firstCharKeys, to);
        
        if(from.length>0){
            postKeys.appendFormat("%@from=%@", firstCharKeys ,from);
        }
        
        if(!(shared.floatValue==(-1.0))){
            postKeys.appendFormat("%@shared=%f", firstCharKeys ,shared);
        }
        
        if(fee.floatValue>0){
            postKeys.appendFormat("%@fee=%f", firstCharKeys ,(fee.floatValue*kBCWalletSatoshi.floatValue));
        }
        
        if(note.length>0){
            postKeys.appendFormat("%@note=%@", firstCharKeys ,note);
        }
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    success(ODPaymentResults.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    /*
    //TODO : untested
    Send Many Transactions
    Send a transaction to multiple recipients in the same transaction.. All transactions include a 0.0001 BTC miners fee.
    -> walletIdentifier : Your Wallet identifier
    -> mainPassword : Your Main My wallet password
    -> secondPassword : Your second My Wallet password if double encryption is enabled (Optional).
    -> from : Send from a specific Bitcoin Address (Optional)
    -> to : Send an NSDictionnary like this
    {
    "1JzSZFs2DQke2B3S4pBxaNaMzzVZaG4Cqh": 100000000,
    "12Cf6nCcRtKERh9cQm3Z29c9MWvQuFSxvT": 1500000000,
    "1dice6YgEVBf88erBFra9BHf6ZMoyvG88": 200000000
    }
    shared "true" or "false" indicating whether the transaction should be sent through a shared wallet. Fees apply. (Optional)
    -> fee : Transaction fee value in satoshi (Must be greater than default fee) (Optional)
    -> note : A public note to include with the transaction (Optional)
    Knowed Errors
    case Unknow
    */
    class func makeManyPayments(walletIdentifier : NSString,apiKey : NSString, mainPassword : NSString, secondPassword : NSString, to : NSDictionary,from : NSString,shared : NSNumber,fee : NSNumber,note : NSString, success :(ODPaymentResults) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/payment", walletIdentifier);
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(mainPassword));
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@api_code=%@", firstCharKeys ,apiKey);
        
        postKeys.appendFormat("%@second_password=%@", firstCharKeys, encode(secondPassword));
        
        var error : NSError?;
        var data : NSData;
        
        data = NSJSONSerialization.dataWithJSONObject(to, options: NSJSONWritingOptions.PrettyPrinted, error: &error)!;
        
        // TODO : can be optimized
        if((error) != nil){
            failure(ODBlockChainError.parseError("NSDictionnary", result: to.description));
        }else{
            
            // TODO : can be optimized
            postKeys.appendFormat("%@recipients=%@", firstCharKeys, NSString(data: data,encoding: NSUTF8StringEncoding));
            
            if(from.length>0){
                postKeys.appendFormat("%@from=%@", firstCharKeys ,from);
            }
            
            if(!(shared.floatValue==(-1.0))){
                postKeys.appendFormat("%@shared=%f", firstCharKeys ,shared);
            }
            
            if(fee.floatValue>0){
                postKeys.appendFormat("%@fee=%f", firstCharKeys ,(fee.floatValue*kBCWalletSatoshi.floatValue));
            }
            
            if(note.length>0){
                postKeys.appendFormat("%@note=%@", firstCharKeys ,note);
            }
            
            url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
            
            request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
            
            ODBlockChainService.manageRequest(request,
                success:{(object : AnyObject) -> Void in
                    if(object.isKindOfClass(NSDictionary)){
                        var dic : NSDictionary = object as NSDictionary;
                        success(ODPaymentResults.instantiateWithDictionnary(dic));
                    }else{
                        failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                    }
                },failure:{(error : ODBlockChainError) -> Void in
                    failure(error);
                });
        }
    }
    
    /*
    Fetching the wallet balance
    Fetch the balance of a wallet. This should be used as an estimate only and will include unconfirmed transactions and possibly double spends.
    -> walletIdentifier : Your Wallet identifier
    -> mainPassword : Your Main My wallet password
    Knowed Errors
    case Unknow
    */
    class func fetchingWalletBalance(walletIdentifier : NSString,apiKey : NSString, mainPassword : NSString,  success :(ODBalance) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/balance", walletIdentifier);
        
        postKeys.appendFormat("%@api_code=%@", firstCharKeys ,apiKey);
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(mainPassword));
        
        /*
        
        TODO : encode pwd !!!!
        var str = CFURLCreateStringByAddingPercentEscapes(
            nil,
            NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!),
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringBuiltInEncodings.UTF8.toRaw()
        )*/
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
        
        //url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    success(ODBalance.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    
    /*
    Listing Addresses
    List all active addresses in a wallet. Also includes a 0 confirmation balance which should be used as an estimate only and will include unconfirmed transactions and possibly double spends.
    -> walletIdentifier : Your Wallet identifier
    -> mainPassword : Your Main My wallet password
    -> confirmations : The minimum number of confirmations transactions must have before being included in balance of addresses (Optional)
    Knowed Errors
    case Invalid
    case DecryptingWallet
    case Unknow
    case ApiKey
    */
    class func listingAddresses(walletIdentifier : NSString,apiKey : NSString,mainPassword : NSString,confirmations : NSNumber,  success :(NSArray) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/list", walletIdentifier);
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(mainPassword));
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@api_code=%@", firstCharKeys ,apiKey);
        
        if(!(confirmations.floatValue==(-1.0))){
            postKeys.appendFormat("%@confirmations=%i", firstCharKeys ,confirmations.integerValue);
        }
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    
                    
                    //if(dic.valueForKey("addresses").isKindOfClass(NSArray)){
                        var resultArray : NSArray = dic.valueForKey("addresses") as NSArray;
                        var mArray : NSMutableArray = NSMutableArray();
                        
                        for(var i = 0; i < resultArray.count;i++){
                            var dicAddress : NSDictionary = resultArray.objectAtIndex(i) as NSDictionary;
                            
                            mArray.addObject(ODBalanceDetails.instantiateWithDictionnary(dicAddress));
                        }
                        
                        success(mArray);
                        
                    /*}else{
                        failure(ODBlockChainError.parseError(NSArray.description(),result:dic.description));
                    }*/
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    /*
    //TODO : untested
    Getting the balance of an address
    Retrieve the balance of a bitcoin address. Querying the balance of an address by label is depreciated.
    -> walletIdentifier : Your Wallet identifier
    -> mainPassword : Your Main My wallet password
    -> confirmations : The minimum number of confirmations transactions must have before being included in balance of addresses (Optional)
    -> address : The bitcoin address to lookup
    Knowed Errors
    case Invalid
    case Unknow
    */
    //#define kBCWalletMyAdress
    class func myAddress(walletIdentifier : NSString,apiKey : NSString,mainPassword : NSString,address : NSString,confirmations : NSNumber,  success :(ODBalanceDetails) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/address_balance", walletIdentifier);
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(mainPassword));
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@api_code=%@", firstCharKeys ,apiKey);
        
        postKeys.appendFormat("%@address=%@", firstCharKeys, address);
        
        if(!(confirmations.floatValue==(-1.0))){
            postKeys.appendFormat("%@confirmations=%i", firstCharKeys ,confirmations.integerValue);
        }
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    success(ODBalanceDetails.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    
    /*
    Generating a new address
    -> walletIdentifier : Your Wallet identifier
    -> mainPassword Your Main My wallet password
    -> secondPassword : Your second My Wallet password if double encryption is enabled (Optional).
    -> label : An optional label to attach to this address. It is recommended this is a human readable string e.g. "Order No : 1234". You May use this as a reference to check balance of an order (documented later)
    Knowed Errors
    case Unknow
    */
    
    class func createAddress(walletIdentifier : NSString,apiKey : NSString,mainPassword : NSString,secondPassword : NSString,label : NSString,  success :(ODBalanceDetails) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/new_address", walletIdentifier);
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, encode(mainPassword));
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@api_code=%@", firstCharKeys ,apiKey);
        
        postKeys.appendFormat("%@second_password=%@", firstCharKeys, encode(secondPassword));

        postKeys.appendFormat("%@label=%@", firstCharKeys, label);
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBCTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                if(object.isKindOfClass(NSDictionary)){
                    var dic : NSDictionary = object as NSDictionary;
                    success(ODBalanceDetails.instantiateWithDictionnary(dic));
                }else{
                    failure(ODBlockChainError.parseError(NSDictionary.description(),result:object.description));
                }
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }
    
    
    
    
    /*
    
    Archiving an address
    
    To improve wallet performance addresses which have not been used recently should be moved to an archived state. They will still be held in the wallet but will no longer be included in the "list" or "list-transactions" calls.
    
    For example if an invoice is generated for a user once that invoice is paid the address should be archived.
    
    Or if a unique bitcoin address is generated for each user, users who have not logged in recently (~30 days) their addresses should be archived.
    
    https://blockchain.info/merchant/$guid/archive_address?password=$main_password&second_password=$second_password&address=$address
    
    $main_password Your Main My wallet password
    $second_password Your second My Wallet password if double encryption is enabled.
    $address The bitcoin address to archive
    
    Response:
    
    {"archived" : "18fyqiZzndTxdVo7g9ouRogB4uFj86JJiy"}
    
    */
    
    
    
    /*
    
    Unarchive an address
    
    Unarchive an address. Will also restore consolidated addresses (see below).
    
    https://blockchain.info/merchant/$guid/unarchive_address?password=$main_password&second_password=$second_password&address=$address
    
    $main_password Your Main My wallet password
    $second_password Your second My Wallet password if double encryption is enabled.
    $address The bitcoin address to unarchive
    
    Response:
    
    {"active" : "18fyqiZzndTxdVo7g9ouRogB4uFj86JJiy"}
    
    */
    
    
    /*
    Consolidating Addresses
    
    Queries to wallets with over 10 thousand addresses will become sluggish especially in the web interface. The auto_consolidate command will remove some inactive archived addresses from the wallet and insert them as forwarding addresses (see receive payments API). You will still receive callback notifications for these addresses however they will no longer be part of the main wallet and will be stored server side.
    
    If generating a lot of addresses it is a recommended to call this method at least every 48 hours. A good value for days is 60 i.e. addresses which have not received transactions in the last 60 days will be consolidated.
    
    https://blockchain.info/merchant/$guid/auto_consolidate?password=$main_password&second_password=$second_password&days=$days
    
    $main_password Your Main My wallet password
    $second_password Your second My Wallet password if double encryption is enabled.
    $days Addresses which have not received any transactions in at least this many days will be consolidated.
    
    Response:
    
    { "consolidated" : ["18fyqiZzndTxdVo7g9ouRogB4uFj86JJiy"]}
    */

}