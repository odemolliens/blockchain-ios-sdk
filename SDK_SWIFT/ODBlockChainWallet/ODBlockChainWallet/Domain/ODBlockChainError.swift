//
//  ODBlockChainError.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import Foundation

enum ODBCError {
    case ODBCErrorParse
    case ODBCErrorUnexpectedObject
    case ODBCErrorMissingKeys
    case ODBCErrorNetwork
    case ODBCErrorNone
}

class ODBlockChainError : NSObject
{
    
    //Domain
    var type : ODBCError;
    var error : NSError;
    
    
    //Constructor
    init()
    {
        self.type = ODBCError.ODBCErrorNone;
        self.error = NSError();
    }
    
    //Static methods
    
    class func parseError(parseError: NSError) -> ODBlockChainError
    {
        
        var nsError : NSError = NSError();
        
        var odError : ODBlockChainError = ODBlockChainError();
        odError.type = ODBCError.ODBCErrorParse;
        odError.error = nsError;
        
        return odError;
    }
    
    
    class func parseUnexpectedObject() -> ODBlockChainError
    {
        //TODO : manage error domain + error code
        var nsError : NSError = NSError(domain: "ParseErrorUnexpectedObject", code: -50, userInfo: NSDictionary());
        
        var odError : ODBlockChainError = ODBlockChainError();
        odError.type = ODBCError.ODBCErrorUnexpectedObject;
        odError.error = nsError;
        
        return odError;
    }
    
    class func parseErrorMissingKeys(missingKeys : NSDictionary) -> ODBlockChainError
    {
        //TODO : manage error domain + error code
        var nsError : NSError = NSError(domain: "ParseMissingKeysError", code: -51, userInfo: missingKeys);
        
        var odError : ODBlockChainError = ODBlockChainError();
        odError.type = ODBCError.ODBCErrorMissingKeys;
        odError.error = nsError;
        
        return odError;
    }
    
    class func network(networkError: NSError) -> ODBlockChainError
    {
        var odError : ODBlockChainError = ODBlockChainError();
        odError.type = ODBCError.ODBCErrorMissingKeys;
        odError.error = networkError;
        
        return odError;
    }
    
    
}