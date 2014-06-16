//
//  ODBlock.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/16/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

class ODBlock : NSObject
{
    //Domain
    var hashBlock : NSString;
    var ver : NSInteger;
    var prevBlock : NSString;
    var mrklRoot : NSString;
    var time : NSInteger;
    var bits : NSInteger;
    var nonce: NSInteger;
    var numberOftx: NSInteger;
    var size : NSInteger;
    var blockIndex : NSInteger;
    var mainChain : Bool;
    var height : NSInteger;
    var receveidTime : NSInteger;
    var relayedBy : NSString;
    
    //Constructor
    init()
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
    
    //Static Methods
    class func instantiateWithDictionnary(dic:NSDictionary) -> ODBlock
    {
        var block : ODBlock = ODBlock();
        block.hashBlock = dic.valueForKey("hashBlock") as NSString;
        block.ver = dic.valueForKey("ver") as NSInteger;
        block.prevBlock = dic.valueForKey("prev_block") as NSString;
        block.time = dic.valueForKey("time") as NSInteger;
        block.nonce = dic.valueForKey("nonce") as NSInteger;
        block.bits = dic.valueForKey("bits") as NSInteger;
        block.numberOftx = dic.valueForKey("n_tx") as NSInteger;
        block.size = dic.valueForKey("size") as NSInteger;
        block.blockIndex = dic.valueForKey("block_index") as NSInteger;
        block.mainChain = dic.valueForKey("main_chain") as Bool;
        block.height = dic.valueForKey("height") as NSInteger;
        block.receveidTime = dic.valueForKey("received_time") as NSInteger;
        block.relayedBy = dic.valueForKey("relayed_by") as NSString;
        
        return block;
    }
    
    
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        if(response.isEqualToString("Invalid Block Hash")){
            return ODBCErrorAPI.InvalidBlockHash;
        }else if(response.isEqualToString("Invalid Block Index")){
            return ODBCErrorAPI.InvalidBlockIndex;
        }else if(response.isEqualToString("Block Not Found")){
            return ODBCErrorAPI.BlockNotFound;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
    
    
}