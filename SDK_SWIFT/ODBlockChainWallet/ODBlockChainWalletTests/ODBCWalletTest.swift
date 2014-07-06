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

import XCTest

class ODBCWalletTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //500 - Create Wallet - Password length
    func testWalletCreateWalletErrorPasswordLength() {
            ODBCWalletService.createWallet("", password: "", apiKey: "a", email: "",
                success:{(object : AnyObject) -> Void in
                    XCTFail("fail");
                },
                
                failure: {(error : ODBlockChainError) -> Void in
                    
                    if(ODCreateWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.PasswordLength){
                        XCTAssert("Success")
                    }else{
                        XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                    }
                });
    }
    
    //500 - Create Wallet - Api key
    func testWalletCreateWalletErrorApiKey() {
            ODBCWalletService.createWallet("", password: "0123456789", apiKey: "", email: "",
                success:{(object : AnyObject) -> Void in
                    XCTFail("fail");
                    
                },
                
                failure: {(error : ODBlockChainError) -> Void in
                    
                    if(ODCreateWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.ApiKey){
                        XCTAssert("Success")
                    }else{
                        XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                    }
                    
                });
    }
    
    //500 - Create Wallet - Invalid email
    func testWalletCreateWalletErrorEmail() {
            ODBCWalletService.createWallet("", password: "0123456789", apiKey: "", email: "wtfsdasd",
                success:{(object : AnyObject) -> Void in
                    XCTFail("fail");
                    
                },
                
                failure: {(error : ODBlockChainError) -> Void in
                    
                    if(ODCreateWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Email){
                        XCTAssert("Success")
                    }else{
                        XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                    }
                    
                });
    }
    
    //500 - Create Wallet - Alphanumeric only
    func testWalletCreateWalletErrorAlphaNumericOnly() {
            ODBCWalletService.createWallet("$", password: "0123456789", apiKey: "", email: "test@test.com",
                success:{(object : AnyObject) -> Void in
                    XCTFail("fail");
                    
                },
                
                failure: {(error : ODBlockChainError) -> Void in
                    
                    if(ODCreateWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.AlphaNumericOnly){
                        XCTAssert("Success")
                    }else{
                        XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                    }
                });
    }
    
    //200 - Create Wallet - FIXME - disabled test service
    func testWalletCreateWalletValid() {
        ODBCWalletService.createWallet("myWallet", password: "0123456789aeza", apiKey: /*YourAPIKey*/"", email: "test1@test234.com",
            success:{(object : AnyObject) -> Void in
                XCTAssert("Success")
                
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
}
