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


class ODWallet: NSObject
{
    
    // MARK: Domain
    var guid : NSString;
    var address : NSString;
    var link : NSString;
    
    
    // MARK: Constructor
    override init()
    {
        self.guid = "";
        self.address = "";
        self.link = "";
    }
    
    // MARK: Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODWallet
    {
        var createWallet : ODWallet = ODWallet();
        createWallet.guid = dic.valueForKey("guid") as! NSString!;
        createWallet.address = dic.valueForKey("address") as! NSString!;
        createWallet.link = dic.valueForKey("link") as! NSString!;
        
        return createWallet;
    }
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.isEqualToString(kBCWalletPasswordLength as String)){
            return ODBCErrorAPI.PasswordLength;
        }else if(response.isEqualToString(kBCWalletApiKey as String)){
            return ODBCErrorAPI.ApiKey;
        }else if(response.isEqualToString(kBCWalletEmail as String)){
            return ODBCErrorAPI.Email;
        }else if(response.isEqualToString(kBCWalletAlphaNumeric as String)){
            return ODBCErrorAPI.AlphaNumericOnly;
        }else if(response.isEqualToString(kBCWalletInvalidAdress as String) || response.isEqualToString(kBCWalletInvalidAdress2 as String)){
            return ODBCErrorAPI.Invalid;
        }else if(response.isEqualToString(kBCCommonNull) || response.isEqualToString(kBCCommonCloudFare)){
            return ODBCErrorAPI.ApiUnavailable;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    // MARK: Methods
    
}

