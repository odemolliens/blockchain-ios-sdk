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


/**
{ "message" : "Response Message" , "tx_hash": "Transaction Hash", "notice" : "Additional Message" }

{ "message" : "Sent 0.1 BTC to 1A8JiWcwvpY7tAopUkSnGuEYHmzGYfZPiq" , "tx_hash" : "f322d01ad784e5deeb25464a5781c3b20971c1863679ca506e702e3e33c18e9c" , "notice" : "Some funds are pending confirmation and cannot be spent yet (Value 0.001 BTC)" }
*/

class ODPaymentResults : NSObject
{
    
    var message : NSString;
    var txHash : NSString;
    var notice : NSString;
    
    // MARK: Constructor
    override init()
    {
        message = "";
        txHash = "";
        notice = "";
    }
    
    // MARK: Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODPaymentResults
    {
        var paymentResult : ODPaymentResults = ODPaymentResults();
        paymentResult.message = dic.valueForKey("message") as! NSString!;
        paymentResult.txHash = dic.valueForKey("tx_hash") as! NSString!;
        paymentResult.notice = dic.valueForKey("notice") as! NSString!;
        return paymentResult;
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