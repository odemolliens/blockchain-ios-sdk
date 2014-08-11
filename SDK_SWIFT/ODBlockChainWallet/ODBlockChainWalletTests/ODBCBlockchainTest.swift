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

class ODBCBlockchainTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*func testODBlockIndexHash() {
    ODBCBlockchainService.singleBlockHash("23742834223412414233949234", success: {(object : AnyObject) -> Void in
    XCTFail("fail");
    }, failure: {(error : ODBlockChainError) -> Void in
    
    if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Hash){
    XCTAssert("Success")
    }else{
    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
    }
    });
    }*/
    
    /*func testODBlockIndexIndex() {
    ODBCBlockchainService.singleBlockIndex("1", success: {(object : AnyObject) -> Void in
    XCTFail("fail");
    }, failure: {(error : ODBlockChainError) -> Void in
    
    if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Index){
    XCTAssert("Success")
    }else{
    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
    }
    });
    }*/
    
    
    // MARK: Single Block
    
    //500 - Single Block Index - Block not found
    func testNetworkSingleBlockIndexNotFound() {
        ODBCBlockchainService.singleBlockIndex("1", success: {(object : ODBlock) -> Void in
            XCTFail("fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                
                if(ODBlock.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.NotFound){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }

    //200 - Single block Hash
    func testNetworkSingleBlockHashValid() {
        ODBCBlockchainService.singleBlockHash("45345",
            success: {(object : ODBlock) -> Void in
                //Success
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
    // MARK: Single Transaction
   
    //500 - Single Transaction Hash - Transaction Not Found
    func testNetworkSingleTransactionHashInvalid() {
        ODBCBlockchainService.singleTransactionHash("18f7f4e51afe9659d12f6722995928d8ef87dbfde2dbca2d25231bb7591afbd8",
            success: {(object : ODSingleTransaction) -> Void in
                XCTFail("Fail")
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleTransaction.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.TransactionNotFound){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //200 - Single Transaction Hash
    func testNetworkSingleTransactionHashValid() {
        ODBCBlockchainService.singleTransactionHash("18f7f4e51afe9659d84f6722995928d8ef87dbfde2dbca2d25231bb7591afbd8",
            success: {(object : ODSingleTransaction) -> Void in
                //Success
                // TODO : Test domain content
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
    //500 - Single Transaction Index - Transaction Not Found
    func testNetworkSingleTransactionIndexInvalid() {
        ODBCBlockchainService.singleTransactionIndex("-1",
            success: {(object : ODSingleTransaction) -> Void in
                XCTFail("Fail")
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleTransaction.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.TransactionNotFound){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //200 - Single Transaction Index
    func testNetworkSingleTransactionIndexValid() {
        ODBCBlockchainService.singleTransactionIndex("46714",
            success: {(object : ODSingleTransaction) -> Void in
                //Success
                // TODO : Test domain content
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
    // MARK: Single Address 
    
    //200 - Single Address Index
    // TODO : No error returned by server if limit > 50
    func testNetworkSingleAddressHashValid() {
        ODBCBlockchainService.singleAddressHash("660d4ef3a743e3e696ad990364e555c271ad504b",limit: -1,offset: -1,
            success: {(object : ODSingleAddress) -> Void in
               //Success
                // TODO : Test domain content
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
    
    //500 - Single Address Index - Illegal Character
    func testNetworkSingleAddressHashInvalidIllegalCharacter() {
        ODBCBlockchainService.singleAddressHash("1234IL",limit: -1,offset: -1,
            success: {(object : ODSingleAddress) -> Void in
                XCTFail("Fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleAddress.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.IllegalCharacter){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //500 - Single Address Index - Hash
    func testNetworkSingleAddressHashInvalidHash() {
        ODBCBlockchainService.singleAddressHash("00000000a00e3%C3%A0e000ad000000e000c000ad000b",limit: -1,offset: -1,
            success: {(object : ODSingleAddress) -> Void in
                XCTFail("Fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleAddress.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Hash){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    /*
    
    //Disabled because doesn't work same as the documentation https://blockchain.info/api/blockchain_api
    //If you want try by yourself - don't forget uncomment in service class ;) (ODBCBlockchainService)
    //500 - Multi Address - Invalid
    func testNetworkMultiAddressInvalidInvalid() {
        
        var mArray = NSMutableArray();
        
        mArray.addObject("1pkSDfsdfdf");
        mArray.addObject("sf2342342");
        
        ODBCBlockchainService.multiAddress(mArray,
            success: {(object : NSArray) -> Void in
                XCTFail("Fail");
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODSingleAddress.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Invalid){
                    XCTAssert("Success")
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
            });
    }
    
    //200 - Multi Address
    func testNetworkMultiAddressValid() {
        
        var mArray = NSMutableArray();
        
        mArray.addObject("1C9KJmsQk2Tydk3TD7E5AnJpuKV8Y1Hhsv");
        mArray.addObject("1DRw8j2hwmR7Kn45c7foj4dVLKgE5t2Evw");
        
        ODBCBlockchainService.multiAddress(mArray,
            success: {(object : NSArray) -> Void in
                XCTAssert("Success");
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
            });
    }
*/
    
    
}
