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


class ODBalance : NSObject
{
    var balance : NSNumber;
    
    // MARK: Constructor
    override init()
    {
        balance = 0;
    }
    
    // MARK: Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODBalance
    {
        var myBalance : ODBalance = ODBalance();
        myBalance.balance = dic.valueForKey("balance") as NSNumber!;
        return myBalance;
    }
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        // TODO : undev
        if(response.isEqualToString(kBCCommonNull) || response.isEqualToString(kBCCommonCloudFare)){
            return ODBCErrorAPI.ApiUnavailable;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    // MARK: Methods
    
    
}