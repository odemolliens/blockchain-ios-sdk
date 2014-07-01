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
    
    /*func testODBlockIndexInvalidBlockHash() {
    ODNetworkService.singleBlockHash("23742834223412414233949234", success: {(object : AnyObject) -> Void in
    XCTFail("fail");
    }, failure: {(error : ODBlockChainError) -> Void in
    
    if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.InvalidBlockHash){
    XCTAssert("Success")
    }else{
    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
    }
    });
    }*/
    
    /*func testODBlockIndexInvalidBlockIndex() {
    ODNetworkService.singleBlockIndex("1", success: {(object : AnyObject) -> Void in
    XCTFail("fail");
    }, failure: {(error : ODBlockChainError) -> Void in
    
    if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.InvalidBlockIndex){
    XCTAssert("Success")
    }else{
    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
    }
    });
    }*/
    
    //500 - Single Block Index - Block not found
    func testNetworkSingleBlockIndexBlockNotFound() {
        ODNetworkService.singleBlockIndex("1", success: {(object : ODBlock) -> Void in
            XCTFail("fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                
                if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.BlockNotFound){
                    XCTAssert("Success")
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //200 - Single block Hash
    func testNetworkSingleBlockHashValid() {
        ODNetworkService.singleBlockHash("45345",
            success: {(object : ODBlock) -> Void in
                XCTAssert("Success:%@",object.hashBlock);
                
                // TODO : test domain
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
   
    //500 - Single Transaction Hash - Transaction Not Found
    func testNetworkSingleTransactionHashInvalid() {
        ODNetworkService.singleTransactionHash("18f7f4e51afe9659d12f6722995928d8ef87dbfde2dbca2d25231bb7591afbd8",
            success: {(object : ODSingleTransaction) -> Void in
                XCTFail("Fail")
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleTransaction.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.TransactionNotFound){
                    XCTAssert("Success")
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //200 - Single Transaction Hash
    func testNetworkSingleTransactionHashValid() {
        ODNetworkService.singleTransactionHash("18f7f4e51afe9659d84f6722995928d8ef87dbfde2dbca2d25231bb7591afbd8",
            success: {(object : ODSingleTransaction) -> Void in
                XCTAssert("Success")
                // TODO : Test domain content
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
    //500 - Single Transaction Index - Transaction Not Found
    func testNetworkSingleTransactionIndexInvalid() {
        ODNetworkService.singleTransactionIndex("-1",
            success: {(object : ODSingleTransaction) -> Void in
                XCTFail("Fail")
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleTransaction.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.TransactionNotFound){
                    XCTAssert("Success")
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //200 - Single Transaction Index
    func testNetworkSingleTransactionIndexValid() {
        ODNetworkService.singleTransactionIndex("46714",
            success: {(object : ODSingleTransaction) -> Void in
                XCTAssert("Success")
                // TODO : Test domain content
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
    
    
    //
    

}
