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

class ODWalletService
{
    /*
    Create Wallet Service
    -> Email & Name : parameters are optionnal
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
        
        url = NSURL.URLWithString(NSString(format : "%@%@",kBlockChainUrlCreateWallet,postKeys.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)));
        
        request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:NSTimeInterval(kBlockChainTimeout));
        
        ODBlockChainService.manageRequest(request,
            success:{(object : AnyObject) -> Void in
                success(object);
            },failure:{(error : ODBlockChainError) -> Void in
                failure(error);
            });
    }

}