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
            
            if((parseError) != nil){
                failure(ODBlockChainError.parseError(parseError!));
            }else{
                
                var content : NSString = NSString();
                var dic : NSDictionary = id as NSDictionary!;
                
                // TODO : improve
                if((dic.valueForKey("error")) != nil){
                    
                    //if((dic.valueForKey("error")).isKindOfClass(NSString)){
                        content = dic.valueForKey("error") as NSString;
                    //}
                }
                
                if(content.length>0){
                    var odError : ODBlockChainError = ODBlockChainError.parseManualError(content);
                    failure(odError);
                }else{
                    success(id);
                }
            }
            
            }, failure: {data,error in
                
                var content : NSString = NSString();
                var dic : NSDictionary = error.userInfo as NSDictionary!;
                
                // TODO : improve
                if((dic.valueForKey("content")) != nil){
                    //if((dic.valueForKey("content")).isKindOfClass(NSString)){
                        content = dic.valueForKey("content") as NSString;
                    //}
                }
                
                if(content.length>0){
                    var odError : ODBlockChainError = ODBlockChainError.api(error);
                    failure(odError);
                }else{
                    var odError : ODBlockChainError = ODBlockChainError.network(error);
                    failure(odError);
                }
            });
    }
}