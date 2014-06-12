//
//  NSUrlConnection+Blocks.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

extension NSURLConnection
    {
    
    class func asyncRequest(request : NSURLRequest, success :(NSData, NSURLResponse) -> Void = {data, response in /* ... */},failure: (NSData, NSError) -> Void = {data, error in /* ... */})
        
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            var queue : NSOperationQueue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{response,data,error in
                
                if(error){
                    failure(data,error);
                }else{
                    success(data,response);
                }
                });
        }
    }
}