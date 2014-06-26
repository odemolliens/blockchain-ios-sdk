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
    case ODBCErrorAPI
    case ODBCErrorNone
}


enum ODBCErrorAPI {
    case Unknow
    case PasswordLength
    case ApiKey
    case InvalidEmail
    case AlphaNumericOnly
    case InvalidBlockHash
    case InvalidBlockIndex
    case BlockNotFound
    case TransactionNotFound
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
    
    //Methods
    
    func contentMessage() -> NSString
    {
        var error : NSString = self.error.userInfo.valueForKey("content") as NSString;
        
        if(error != nil){
            return error;
        }else{
            return "";
        }
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
    
    class func parseError(expected: NSString, result : NSString) -> ODBlockChainError
    {
        //TODO : manage error domain + error code
        var nsError : NSError = NSError(domain: "ParseErrorUnexpectedObjectClass", code: -49, userInfo: NSDictionary(object: NSString(format:"expected:%@ result:%@",expected,result), forKey: "error"));
        
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
        odError.type = ODBCError.ODBCErrorNetwork;
        odError.error = networkError;
        
        return odError;
    }
    
    class func api(apiError: NSError) -> ODBlockChainError
    {
        var odError : ODBlockChainError = ODBlockChainError();
        odError.type = ODBCError.ODBCErrorAPI;
        odError.error = apiError;
        
        return odError;
    }

}