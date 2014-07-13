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


class ODSingleAddress : NSObject {
    
    var hash160 : NSString;
    var address : NSString;
    var nTx : NSNumber;
    var nUnredeemed : NSNumber;
    var totalReceived : NSNumber;
    var totalSent : NSNumber;
    var finalBalance : NSNumber;
    //"txs":[--Array of Transactions--]
    //var tx : NSArray;
    
    // MARK: Constructor
    init()
    {
        self.hash160 = "";
        self.address = "";
        self.nTx = 0;
        self.nUnredeemed = 0;
        self.totalReceived = 0;
        self.totalSent = 0;
        self.finalBalance = 0;
    }
    
    // MARK: Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODSingleAddress
    {
        var singleAddress : ODSingleAddress = ODSingleAddress();
        singleAddress.hash160 = dic.valueForKey("hash160") as NSString!;
        singleAddress.address = dic.valueForKey("address") as NSString!;
        singleAddress.nTx = dic.valueForKey("n_tx") as NSNumber!;
        //singleAddress.nUnredeemed = dic.valueForKey("n_unredeemed") as NSNumber!;
        singleAddress.totalReceived = dic.valueForKey("total_received") as NSNumber!;
        singleAddress.totalSent = dic.valueForKey("total_sent") as NSNumber!;
        singleAddress.finalBalance = dic.valueForKey("final_balance") as NSNumber!;
        return singleAddress;
    }
    
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.hasPrefix(kBCBlockChainIllegalChar)){
            return ODBCErrorAPI.IllegalCharacter;
        }else if(response.isEqualToString(kBCBlockChainHash160)){
            return ODBCErrorAPI.Hash;
        }else if(response.isEqualToString(kBCCommonNull) || response.isEqualToString(kBCCommonCloudFare)){
            return ODBCErrorAPI.ApiUnavailable;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
}