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


class ODCreateWallet: NSObject
{
    
    //Domain
    var guid : NSString;
    var address : NSString;
    var link : NSString;
    
    
    //Constructor
    init()
    {
        self.guid = "";
        self.address = "";
        self.link = "";
    }
    
    //Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODCreateWallet
    {
        var createWallet : ODCreateWallet = ODCreateWallet();
        createWallet.guid = dic.valueForKey("guid") as NSString;
        createWallet.address = dic.valueForKey("address") as NSString;
        createWallet.link = dic.valueForKey("link") as NSString;
        
        return createWallet;
    }
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.isEqualToString("Password Must be greater than 10 characters in length")){
            return ODBCErrorAPI.PasswordLength;
        }else if(response.isEqualToString("Authorization Key invalid or disabled")){
            return ODBCErrorAPI.ApiKey;
        }else if(response.isEqualToString("Invalid Email")){
            return ODBCErrorAPI.Email;
        }else if(response.isEqualToString("Label Must be alphanumeric")){
            return ODBCErrorAPI.AlphaNumericOnly;
        }else if(response.isEqualToString("null")){
            return ODBCErrorAPI.ApiUnavailable;
        }else if(response.isEqualToString("Invalid Bitcoin Address")){
            return ODBCErrorAPI.Invalid;
        }else if(response.isEqualToString("null") || response.isEqualToString("CloudFare")){
            return ODBCErrorAPI.ApiUnavailable;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    //Methods
    
}

