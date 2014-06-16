//
//  ODBlockChainConstants.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
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


//
/////////// END OF NETWORK CONSTANTS ///////////