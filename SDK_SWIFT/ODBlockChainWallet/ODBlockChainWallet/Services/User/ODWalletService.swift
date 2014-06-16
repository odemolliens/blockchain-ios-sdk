//
//  ODWalletService.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

class ODWalletService
{
    /*
    Create Wallet Service
    -> Email & Name parameters are optionnal
    Return an ODCreateWallet object with identifier if successfull
    Knowed Errors
    case Unknow
    case PasswordLength
    case ApiKey
    case InvalidEmail
    case AlphaNumericOnly
    */
    class func createWallet(name : NSString, password : NSString, apiKey : NSString, email : NSString, success :(AnyObject) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */}) -> Void
    {
        
        var url : NSURL;
        var request : NSMutableURLRequest;
        var postKeys : NSMutableString = NSMutableString();
        
        
        //Parameters
        postKeys.appendFormat("?api_code=%@", apiKey);
        postKeys.appendFormat("&password=%@", password);
        
        //Optionnal keys
        if(email.length>0){
            postKeys.appendFormat("&email=%@", email);
        }
        
        if(name.length>0){
            postKeys.appendFormat("&label=%@", name);
        }
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlCreateWallet,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:success
            ,failure:failure);
    }

}