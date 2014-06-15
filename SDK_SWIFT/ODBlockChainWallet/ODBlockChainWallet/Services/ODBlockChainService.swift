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
        
        NSLog("%@", request.URL.description);

        NSURLConnection.asyncRequest(request, success: {data,response in
            
            var datastring: String = NSString(data:data, encoding:NSUTF8StringEncoding)
            
            NSLog("%@", datastring);
            
           // response.
            
            var parseError : NSError?;
            
            var id : AnyObject! =  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments,error: &parseError);
            
            if(parseError){
                failure(ODBlockChainError.parseError(parseError!));
            }else{
                success(id);
            }
            
            }, failure: {data,error in
                
                var odError : ODBlockChainError = ODBlockChainError.network(error);
                failure(odError);
            });
        
        
        NSURLConnection.asyncRequest(request, success: {data,response in
         
            }, failure: {data,error in
                
            });
    }
}