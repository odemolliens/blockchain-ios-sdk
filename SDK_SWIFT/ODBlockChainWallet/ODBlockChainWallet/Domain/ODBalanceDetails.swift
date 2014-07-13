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

class ODBalanceDetails : ODBalance
{
    var address : NSString;
    var label : NSString;
    var totalReceived : NSNumber;
    
    // MARK: Constructor
    init()
    {
        address = "";
        label = "";
        totalReceived = 0;
    }
    
    // MARK: Static Methods
    override class func instantiateWithDictionnary(dic:NSDictionary) -> ODBalanceDetails
    {
        var myBalance : ODBalanceDetails = ODBalanceDetails();
        
        if(!(dic.valueForKey("balance")==nil)){
            myBalance.balance = dic.valueForKey("balance") as NSNumber!;
        }
        
        myBalance.address = dic.valueForKey("address") as NSString!;
        
        if(!(dic.valueForKey("label")==nil)){
            myBalance.label = dic.valueForKey("label") as NSString!;
        }
        
        if(!(dic.valueForKey("total_received")==nil)){
            myBalance.totalReceived = dic.valueForKey("total_received") as NSNumber!;
        }
        
        return myBalance;
    }
    
    override class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
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