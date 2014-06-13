//
//  ODBlockChainWalletTests.swift
//  ODBlockChainWalletTests
//
//  Created by OlivierDemolliens on 6/11/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import XCTest

class ODBlockChainWalletTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testFunction() {
        //ODWalletService.createWallet("", password: "password0123123", apiKey: "JEANAIPAS", email: "", success: , failure: );
        
        ODWalletService.createWallet("", password: "", apiKey: "", email: "",
            success:{(object : AnyObject) -> Void in
                NSLog("%@", "success");
                XCTAssert(true, "Success")
                /**/},
            
            failure: {(error : ODBlockChainError) -> Void in
                 XCTAssert(false, "Fail")
                /**/});
    }
    
}
