//
//  ODBlockChainWalletSampleTests.swift
//  ODBlockChainWalletSampleTests
//
//  Created by OlivierDemolliens on 6/13/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import XCTest

class ODBlockChainWalletSampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testODWalletServicCreateWalletErrorPasswordLength() {
        
        self.measureBlock() {
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
    }
    
    func testODWalletServicCreateWalletErrorApiKey() {
        self.measureBlock() {
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
    }
    
    func testODWalletServicCreateWalletErrorInvalidEmail() {
        self.measureBlock() {
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
    }
    
    func testODWalletServicCreateWalletErrorAlphaNumericOnl() {
        self.measureBlock() {
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
    }
    
}
