//
//  ODBlockChainConstants.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

//HTTP
let kBlockChainGET : NSString = "GET";
let kBlockChainPOST : NSString = "POST";

//NETWORK MANAGEMENT

let kBlockChainUrl : NSString = "https://blockchain.info/api/v2/";

let kBlockChainUrlCreateWallet = NSString(format:"%@%@",kBlockChainUrl,"create_wallet");