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
let kBCUrlWalletMerchant = NSString(format:"%@%@",kBCUrl,"merchant/");

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

let kBCWalletSatoshi : NSNumber = 100000000.0;
let kBCWalletPasswordLength : NSString = "Password Must be greater than 10 characters in length";
let kBCWalletApiKey : NSString = "Authorization Key invalid or disabled";
let kBCWalletEmail : NSString = "Invalid Email";
let kBCWalletAlphaNumeric : NSString = "Label Must be alphanumeric";
let kBCWalletInvalidAdress : NSString = "Invalid Bitcoin Address";
let kBCWalletInvalidAdress2 : NSString = "com.google.bitcoin.core.AddressFormatException: Input to short";
let kBCWalletDecryptWallet : NSString = "Error Decrypting Wallet";
let kBCWalletDecryptWalletPwd : NSString = "pad block corrupted";
let kBCWalletDecodingAddress : NSString = "Error decoding private key for address x";
let kBCWalletSecondPasswordIncorrect : NSString = "Second password incorrect";
let kBCWalletAddressAndAmount : NSString = "You must provide an address and amount";
let kBCWalletWalletChecksumNotValidated : NSString = "Wallet Checksum did not validate. Serious error: Restore a backup if necessary.";
let kBCWalletTwoFactorAuthNotEnabled : NSString = "Two factor authentication currently not enabled in the Merchant API";
let kBCWalletLabelMustBeBetween : NSString = "Label must be between 0 & 255 characters";
let kBCWalletErrorSavingWallet : NSString = "Error saving wallet";
let kBCWalletRetrictedWallet : NSString = "Wallets are currently restricted to 5000 transactions";
let kBCWalletIdentifierNotFound : NSString = "Wallet identifier not found";
let kBCWalletConfirmationsLimit : NSString = "Fail: Confirmations must be between 0 and 120";
let kBCWalletUnknow : NSString = "Uknown method";
let kBCWalletUnknowGuid : NSString = "Unknown Key Format";

//
/////////// BlockChain ///////////
//


let kBCBlockChainHash : NSString = "Invalid Block Hash";
let kBCBlockChainIndex : NSString = "Invalid Block Index";
let kBCBlockChainBlockNotFound : NSString = "Block Not Found";
let kBCBlockChainTransactionNotFound : NSString = "Transaction not found";
let kBCBlockChainIllegalChar : NSString = "Illegal character";
let kBCBlockChainHash160 : NSString = "Sorry this is is not a valid  hash 160";


//
/////////// END ERROR NETWORK CONSTANTS ///////////







