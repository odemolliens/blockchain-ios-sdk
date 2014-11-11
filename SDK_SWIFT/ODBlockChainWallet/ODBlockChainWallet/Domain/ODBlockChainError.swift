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
    case ApiUnavailable
    //case CloudFareUnavailable //http code 522 -> case ApiUnavailable
    case PasswordLength
    case ApiKey
    case Email
    case AlphaNumericOnly
    case Hash
    case Index
    case NotFound
    case TransactionNotFound
    case IllegalCharacter
    case Invalid
    case DecryptingWallet
}

class ODBlockChainError : NSObject
{
    
    // MARK: Domain
    var type : ODBCError;
    var error : NSError;
    
    
    // MARK: Constructor
    override init()
    {
        self.type = ODBCError.ODBCErrorNone;
        self.error = NSError();
    }
    
    // MARK: Methods
    
    func contentMessage() -> NSString
    {
        var error : NSString = NSString();
        
        var dic : NSDictionary = self.error.userInfo as NSDictionary!;
        
        // TODO : need optimization
        if((dic.valueForKey("content")) != nil){
            //if(dic.valueForKey("content").isKindOfClass(NSString)){
                error = dic.valueForKey("content") as NSString;
            //}
        }
        
        if(error.length>0){
            return error;
        }else{
            return "NO_CONTENT";
        }
    }
    
    // MARK: Static methods
    
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
    
    //TODO : this is not used for the moment
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
        var statusCode : NSNumber = NSNumber();
        
        var odError : ODBlockChainError = ODBlockChainError();
        
        var dic : NSDictionary = apiError.userInfo as NSDictionary!;
        if((dic.valueForKey("httpcode")) != nil){
            //if(dic.valueForKey("httpcode").isKindOfClass(NSNumber)){
                statusCode = dic.valueForKey("httpcode") as NSNumber;
                
                if(statusCode==522){
                    odError.type = ODBCError.ODBCErrorAPI;
                    odError.error = apiError;
                    //Force key for contentMessage() method
                    var dicError : NSDictionary = odError.error.userInfo as NSDictionary!;
                    dicError.setValue("CloudFare", forKey: "content");
                    
                    return odError;
                }
                
            //}
        }
        
        odError.type = ODBCError.ODBCErrorAPI;
        odError.error = apiError;
        
        return odError;
    }
    
    class func parseManualError(error : NSString) -> ODBlockChainError
    {
        //TODO : manage error domain + error code
        var nsError : NSError = NSError(domain: "parseManualError", code: -46, userInfo: NSDictionary(object: error, forKey: "content"));
        
        var odError : ODBlockChainError = ODBlockChainError();
        odError.type = ODBCError.ODBCErrorAPI;
        odError.error = nsError;
        
        return odError;
    }

}