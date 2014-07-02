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

/////////// NETWORK ///////////

//Http request
let kBlockChainGET : NSString = "GET";
let kBlockChainPOST : NSString = "POST";

//Network Management
let kBlockChainTimeout : NSInteger = 20;


/////////// URL ///////////
let kBlockChainUrl : NSString = "https://blockchain.info/";
let kBlockChainUrlApi : NSString = "api/v2/";

//CreateWalletService
let kBlockChainUrlCreateWallet = NSString(format:"%@%@%@",kBlockChainUrl,kBlockChainUrlApi,"create_wallet");

//NetworkService
let kBlockChainUrlBlockInfo = NSString(format:"%@%@",kBlockChainUrl,"rawblock/");
let kBlockChainUrlTransactionInfo = NSString(format:"%@%@",kBlockChainUrl,"rawtx/");
let kBlockChainUrlTransactionSingleAddress = NSString(format:"%@%@",kBlockChainUrl,"address/");
let kBlockChainUrlTransactionMultiAddress = NSString(format:"%@%@",kBlockChainUrl,"multiaddr?active=");

//
/////////// END OF NETWORK CONSTANTS ///////////