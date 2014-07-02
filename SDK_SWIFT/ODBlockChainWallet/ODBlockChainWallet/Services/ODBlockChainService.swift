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
            
            if(parseError){
                failure(ODBlockChainError.parseError(parseError!));
            }else{
                success(id);
            }
            
            }, failure: {data,error in
                
                var content : NSString = NSString();
                
                // TODO : need optimization
                if(error.userInfo.valueForKey("content")){
                    if(error.userInfo.valueForKey("content").isKindOfClass(NSString)){
                        content = error.userInfo.valueForKey("content") as NSString;
                        
                        var odError : ODBlockChainError = ODBlockChainError.api(error);
                        failure(odError);
                    }
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