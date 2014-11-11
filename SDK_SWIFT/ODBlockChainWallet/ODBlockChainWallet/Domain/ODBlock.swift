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

class ODBlock : NSObject
{
    // MARK: Domain
    var hashBlock : NSString;
    var ver : NSNumber;
    var prevBlock : NSString;
    var mrklRoot : NSString;
    var time : NSNumber;
    var bits : NSNumber;
    var nonce: NSNumber;
    var numberOftx: NSNumber;
    var size : NSNumber;
    var blockIndex : NSNumber;
    var mainChain : Bool;
    var height : NSNumber;
    var receveidTime : NSNumber;
    var relayedBy : NSString;
    
    // MARK: Constructor
    override init()
    {
        self.hashBlock = "";
        self.ver = -1;
        self.prevBlock = "";
        self.mrklRoot = "";
        self.time = -1;
        self.bits = -1;
        self.nonce  = -1;
        self.numberOftx = -1;
        self.size = -1;
        self.blockIndex = -1;
        self.mainChain = false;
        self.height = -1;
        self.receveidTime = -1;
        self.relayedBy  = "";
    }
    
    // MARK: Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODBlock
    {
        var block : ODBlock = ODBlock();
        
        block.hashBlock = dic.valueForKey("hash") as NSString!;
        block.ver = dic.valueForKey("ver") as NSNumber!;
        block.prevBlock = dic.valueForKey("prev_block") as NSString!;
        block.time = dic.valueForKey("time") as NSNumber!;
        block.nonce = dic.valueForKey("nonce") as NSNumber!;
        block.bits = dic.valueForKey("bits") as NSNumber!;
        block.numberOftx = dic.valueForKey("n_tx") as NSNumber!;
        block.size = dic.valueForKey("size") as NSNumber!;
        block.blockIndex = dic.valueForKey("block_index") as NSNumber!;
        block.mainChain = dic.valueForKey("main_chain") as Bool!;
        block.height = dic.valueForKey("height") as NSNumber!;
        block.receveidTime = dic.valueForKey("received_time") as NSNumber!;
        block.relayedBy = dic.valueForKey("relayed_by") as NSString!;
        
        return block;
    }
    
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.isEqualToString(kBCBlockChainHash)){
            return ODBCErrorAPI.Hash;
        }else if(response.isEqualToString(kBCBlockChainIndex)){
            return ODBCErrorAPI.Index;
        }else if(response.isEqualToString(kBCBlockChainBlockNotFound)){
            return ODBCErrorAPI.NotFound;
        }else if(response.isEqualToString(kBCCommonNull) || response.isEqualToString(kBCCommonCloudFare)){
            return ODBCErrorAPI.ApiUnavailable;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    
}