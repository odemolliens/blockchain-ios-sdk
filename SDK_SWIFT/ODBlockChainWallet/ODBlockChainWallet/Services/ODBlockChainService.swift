//
//  ODBlockChainService.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

class ODBlockChainService
{
    
    class func manageRequest(request : NSMutableURLRequest, success:(AnyObject) -> Void = {response in /* ... */},failure: (ODBlockChainError) -> Void = {error in /* ... */})
    {
        //Generic parameters
        request.setValue("application/json", forHTTPHeaderField: "Accept");
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        
        NSURLConnection.asyncRequest(request, success: {data,response in
            
            var parseError : NSError?;
            
            var id : AnyObject! =  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments,error: &parseError);
            
            if(parseError){
                failure(ODBlockChainError.parseError(parseError!));
            }else{
                success(id);
            }
            
            }, failure: {data,error in
                
                var content : NSString = error.userInfo.valueForKey("content") as NSString;
                
                if(content != nil){
                    var odError : ODBlockChainError = ODBlockChainError.api(error);
                    failure(odError);
                }else{
                    var odError : ODBlockChainError = ODBlockChainError.network(error);
                    failure(odError);
                }
            });
    }
}