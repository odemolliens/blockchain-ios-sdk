//
//  ODBlockChainWalletSampleTests.swift
//  ODBlockChainWalletSampleTests
//
//  Created by OlivierDemolliens on 6/13/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import XCTest

class ODBCWNetwork: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testODBlockIndexInvalidBlockHash() {
        ODNetworkService.singleBlockHash("Test", success: {(object : AnyObject) -> Void in
            XCTFail("fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                
                if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.InvalidBlockHash){
                    XCTAssert("Success")
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    func testODBlockIndexInvalidBlockIndex() {
        ODNetworkService.singleBlockHash("1", success: {(object : AnyObject) -> Void in
            XCTFail("fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                
                if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.BlockNotFound){
                    XCTAssert("Success")
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
}
