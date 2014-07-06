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

/////////// BEGIN NETWORK CONSTANTS ///////////
//


//
/////////// HTTP Request ///////////
//
let kBCGET : NSString = "GET";
let kBCPOST : NSString = "POST";

//
/////////// Network Management ///////////
//
let kBCTimeout : NSInteger = 20;

//
/////////// URL ///////////
//
let kBCUrl : NSString = "https://blockchain.info/";
let kBCUrlApi : NSString = "api/v2/";

//
/////////// Wallet Service ///////////
//
let kBCUrlCreateWallet = NSString(format:"%@%@%@",kBCUrl,kBCUrlApi,"create_wallet");

//
/////////// BlockChain Service ///////////
//
let kBCUrlBlockInfo = NSString(format:"%@%@",kBCUrl,"rawblock/");
let kBCUrlTransactionInfo = NSString(format:"%@%@",kBCUrl,"rawtx/");
let kBCUrlTransactionSingleAddress = NSString(format:"%@%@",kBCUrl,"address/");
let kBCUrlTransactionMultiAddress = NSString(format:"%@%@",kBCUrl,"multiaddr?active=");


//
/////////// END NETWORK CONSTANTS ///////////


/////////// BEGIN ERROR NETWORK CONSTANTS ///////////
//



//
/////////// Common ///////////
//
let kBCCommonNull = "null";
let kBCCommonCloudFare = "CloudFare"; // httpcode 522


//
/////////// Wallet ///////////
//


let kBCWalletPasswordLength = "Password Must be greater than 10 characters in length";
let kBCWalletApiKey = "Authorization Key invalid or disabled";
let kBCWalletEmail = "Invalid Email";
let kBCWalletAlphaNumeric = "Label Must be alphanumeric";
let kBCWalletInvalidAdress = "Invalid Bitcoin Address";


//
/////////// BlockChain ///////////
//


let kBCBlockChainHash = "Invalid Block Hash";
let kBCBlockChainIndex = "Invalid Block Index";
let kBCBlockChainBlockNotFound = "Block Not Found";
let kBCBlockChainTransactionNotFound = "Transaction not found";
let kBCBlockChainIllegalChar = "Illegal character";
let kBCBlockChainHash160 = "Sorry this is is not a valid  hash 160";


//
/////////// END ERROR NETWORK CONSTANTS ///////////







