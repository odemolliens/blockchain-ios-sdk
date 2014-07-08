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
    class func createWallet(name : NSString, password : NSString, apiKey : NSString, email : NSString, success :(ODWallet) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@api_code=%@", firstCharKeys, apiKey);
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@password=%@", firstCharKeys, password);
        
        //Optionnal keys
        if(email.length>0){
            postKeys.appendFormat("%@email=%@", firstCharKeys, email);
        }
        
        if(name.length>0){
            postKeys.appendFormat("%@label=%@", firstCharKeys ,name);
        }
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlCreateWallet,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)));
        
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
    
    
    /****
    Response:
    
    { "message" : "Response Message" , "tx_hash": "Transaction Hash", "notice" : "Additional Message" }
    
    { "message" : "Sent 0.1 BTC to 1A8JiWcwvpY7tAopUkSnGuEYHmzGYfZPiq" , "tx_hash" : "f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9c" , "notice" : "Some funds are pending confirmation and cannot be spent yet (Value 0.001 BTC)" }
    
    ***/
    
    /*
    //TODO : untested
    Making Outgoing Payments
    Send bitcoin from your wallet to another bitcoin address. All transactions include a 0.0001 BTC miners fee.
    -> mainPassword : Your Main My wallet password
    -> secondPassword : Your second My Wallet password if double encryption is enabled.
    -> to : Recipient Bitcoin Address.
    -> amount : Amount to send in satoshi.
    -> from : Send from a specific Bitcoin Address (Optional)
    shared "true" or "false" indicating whether the transaction should be sent through a shared wallet. Fees apply. (Optional)
    -> fee : Transaction fee value in satoshi (Must be greater than default fee) (Optional)
    -> note : A public note to include with the transaction (Optional)
    Knowed Errors
    case Unknow
    */
    class func makePayment(walletIdentifier : NSString,mainPassword : NSString, secondPassword : NSString, amount : NSNumber, to : NSString,from : NSString,shared : NSNumber,fee : NSNumber,note : NSString, success :(ODPaymentResults) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";

        //Parameters
        postKeys.appendFormat("%@/payment", walletIdentifier);
        
        postKeys.appendFormat("%@main_password=%@", firstCharKeys, mainPassword);
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@second_password=%@", firstCharKeys, secondPassword);
        
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
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)));
        
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
    The above example would send 1 BTC to 1JzSZFs2DQke2B3S4pBxaNaMzzVZaG4Cqh, 15 BTC to 12Cf6nCcRtKERh9cQm3Z29c9MWvQuFSxvT and 2 BTC to 1dice6YgEVBf88erBFra9BHf6ZMoyvG88 in the same transaction.
    Response:
    
    { "message" : "Response Message" , "tx_hash": "Transaction Hash" }
    
    { "message" : "Sent To Multiple Recipients" , "tx_hash" : "f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9c" }
    
    */

    /*
    //TODO : untested
    Send Many Transactions
    Send a transaction to multiple recipients in the same transaction.. All transactions include a 0.0001 BTC miners fee.
    -> mainPassword : Your Main My wallet password
    -> secondPassword : Your second My Wallet password if double encryption is enabled.
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
    class func makeManyPayments(walletIdentifier : NSString,mainPassword : NSString, secondPassword : NSString, to : NSDictionary,from : NSString,shared : NSNumber,fee : NSNumber,note : NSString, success :(ODPaymentResults) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        var firstCharKeys : NSString = "?";
        
        //Parameters
        postKeys.appendFormat("%@/payment", walletIdentifier);
        
        postKeys.appendFormat("%@main_password=%@", firstCharKeys, mainPassword);
        
        firstCharKeys = "&";
        
        postKeys.appendFormat("%@second_password=%@", firstCharKeys, secondPassword);
        
        var error : NSError?;
        var data : NSData;
        
        data = NSJSONSerialization.dataWithJSONObject(to, options: NSJSONWritingOptions.PrettyPrinted, error: &error);
        
        // TODO : can be optimized
        if(error){
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
            
            url = NSURL.URLWithString(NSString(format : "%@%@",kBCUrlWalletMerchant,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)));
            
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
    

}