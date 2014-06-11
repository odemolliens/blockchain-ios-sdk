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

class ODBlockChainError
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
    
    
    func parseError(parseError: NSError) -> ODBlockChainError
    {
        return ODBlockChainError();
    }
    
    
    func parseUnexpectedObject() -> ODBlockChainError
    {
        return ODBlockChainError();
    }
    
    func parseErrorMissingKeys(missingKeys : NSDictionary) -> ODBlockChainError
    {
        return ODBlockChainError();
    }
    
    func network(networkError: NSError) -> ODBlockChainError
    {
        return ODBlockChainError();
    }
    
    
}