//
//  ODBlockChainWalletSampleTests.swift
//  ODBlockChainWalletSampleTests
//
//  Created by OlivierDemolliens on 6/13/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import XCTest

class ODBCWCreateWallet: XCTestCase {
    
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
            ODWalletService.createWallet("", password: "", apiKey: "a", email: "",
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
            ODWalletService.createWallet("", password: "0123456789", apiKey: "", email: "",
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
    func testWalletCreateWalletErrorInvalidEmail() {
            ODWalletService.createWallet("", password: "0123456789", apiKey: "", email: "wtfsdasd",
                success:{(object : AnyObject) -> Void in
                    XCTFail("fail");
                    
                },
                
                failure: {(error : ODBlockChainError) -> Void in
                    
                    if(ODCreateWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.InvalidEmail){
                        XCTAssert("Success")
                    }else{
                        XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                    }
                    
                });
    }
    
    //500 - Create Wallet - Alphanumeric only
    func testWalletCreateWalletErrorAlphaNumericOnly() {
            ODWalletService.createWallet("$", password: "0123456789", apiKey: "", email: "test@test.com",
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
    
    //200 - Create Wallet
    func testWalletCreateWalletValid() {
        ODWalletService.createWallet("myWallet", password: "0123456789aeza", apiKey: /*YourAPIKey*/"", email: "test1@test234.com",
            success:{(object : AnyObject) -> Void in
                XCTAssert("Success")
                
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
}
