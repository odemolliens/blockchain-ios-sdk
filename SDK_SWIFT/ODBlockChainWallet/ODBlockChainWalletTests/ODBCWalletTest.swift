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
    
    // MARK: Create Wallet
    
    //500 - Create Wallet - Password length
    func testWalletCreateWalletErrorPasswordLength() {
        ODBCWalletService.createWallet("", apiKey: kBCTestApiKey,password: "",  email: "",
            success:{(object : ODWallet) -> Void in
                XCTFail("fail");
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                
                if(ODWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.PasswordLength){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Create Wallet - Api key
    func testWalletCreateWalletErrorApiKey() {
        ODBCWalletService.createWallet("", apiKey: "a",password: "0123456789", email: "",
            success:{(object : ODWallet) -> Void in
                XCTFail("fail");
                
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                
                if(ODWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.ApiKey){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
                
        });
    }
    
    //500 - Create Wallet - Invalid email
    func testWalletCreateWalletErrorEmail() {
        ODBCWalletService.createWallet("",apiKey: kBCTestApiKey, password: "0123456789", email: "wtfsdasd",
            success:{(object : ODWallet) -> Void in
                XCTFail("fail");
                
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                
                if(ODWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Email){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
                
        });
    }
    
    //500 - Create Wallet - Alphanumeric only
    func testWalletCreateWalletErrorAlphaNumericOnly() {
        ODBCWalletService.createWallet("$",apiKey: kBCTestApiKey, password: "0123456789", email: "test@test.com",
            success:{(object : ODWallet) -> Void in
                XCTFail("fail");
                
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                
                if(ODWallet.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.AlphaNumericOnly){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //200 - Create Wallet
    func testWalletCreateWalletValid() {
        ODBCWalletService.createWallet("myWallet", apiKey: kBCTestApiKey,password: "0123456789aeza", email: "test1@test234.com",
            success:{(object : ODWallet) -> Void in
                //Success
            },
            
            failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
        });
    }
    
    // MARK: Listing addresses
    
    //200 - Listing Adresses
    func testWalletListingAddresses() {
        
        ODBCWalletService.listingAddresses(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, confirmations: 6, success: {(object : NSArray) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
        });
    }
    
    //500 - Listing Adresses - GUID
    func testWalletListingAddressesGuid() {
        
        ODBCWalletService.listingAddresses("test",apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, confirmations: 1, success: {(object : NSArray) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Listing Adresses - Bad Password
    func testWalletListingAddressesBadPassword() {
        
        ODBCWalletService.listingAddresses(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: "test", confirmations: 1, success: {(object : NSArray) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Listing Adresses - ApiKey
    func testWalletListingAddressesApiKey() {
        
        ODBCWalletService.listingAddresses(kBCTestWalletIdentifier,apiKey: "test", mainPassword: kBCTestMainPassword, confirmations: 1, success: {(object : NSArray) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.ApiKey){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Listing Adresses - Confirmations
    func testWalletListingAddressesConfirmations() {
        
        ODBCWalletService.listingAddresses(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, confirmations: -1, success: {(object : NSArray) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Invalid){
                    //Success
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    // MARK: Fetching Wallet balance
    
    //200 - Fetching Wallet balance
    func testWalletFetchingWalletBalance() {
        
        ODBCWalletService.fetchingWalletBalance(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, success: {(object : ODBalance) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                //TODO : undev
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
        });
    }
    //500 - Fetching Wallet balance - GUID
    func testWalletFetchingWalletBalanceGuid() {
        
        ODBCWalletService.fetchingWalletBalance("test",apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, success: {(object : ODBalance) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Fetching Wallet balance - Bad password
    func testWalletFetchingWalletBalanceBadPassword() {
        
        ODBCWalletService.fetchingWalletBalance(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: "test", success: {(object : ODBalance) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Fetching Wallet balance - Api Key
    func testWalletFetchingWalletBalanceApiKey() {
        
        ODBCWalletService.fetchingWalletBalance(kBCTestWalletIdentifier,apiKey: "test", mainPassword: kBCTestMainPassword, success: {(object : ODBalance) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.ApiKey){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    
    // MARK: My Address
    
    //200 - My Address
    func testWalletMyAddress() {
        
        ODBCWalletService.myAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, address: kBCTestAddress, confirmations: 6, success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
        });
    }
    
    
    //500 - My Address - Empty Address
    func testWalletMyAddressEmptyAddress() {
        
        ODBCWalletService.myAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, address: "", confirmations: 6, success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Invalid){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - My Address - Guid
    func testWalletMyAddressGuid() {
        
        ODBCWalletService.myAddress("test",apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, address: "", confirmations: 6, success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - My Address - Bad Password
    func testWalletMyAddressBadPassword() {
        
        ODBCWalletService.myAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: "test", address: kBCTestAddress, confirmations: 6, success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - My Address - Api Key
    func testWalletMyAddressApiKey() {
        
        ODBCWalletService.myAddress(kBCTestWalletIdentifier,apiKey: "test", mainPassword: kBCTestMainPassword, address: kBCTestAddress, confirmations: 6, success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.ApiKey){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - My Address - Confirmations
    func testWalletMyAddressConfirmations() {
        
        ODBCWalletService.myAddress(kBCTestWalletIdentifier,apiKey: "test", mainPassword: kBCTestMainPassword, address: kBCTestAddress, confirmations: 2, success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Invalid){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    // MARK: Create Address
    
    //200 - Create Address
    func testWalletCreateAddress() {
        
        ODBCWalletService.createAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, secondPassword: kBCTestSecondPassword, label: "nameAddress", success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
        });
    }
    
    
    //500 - Create Address - Empty Address
    func testWalletCreateAddressEmptyAddress() {
        
        ODBCWalletService.createAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, secondPassword: kBCTestSecondPassword, label: "nameAddress", success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.Invalid){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Create Address - Guid
    func testWalletCreateAddressGuid() {
        
        ODBCWalletService.createAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: kBCTestMainPassword, secondPassword: kBCTestSecondPassword, label: "nameAddress", success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Create Address - Bad Password
    func testWalletCreateAddressBadPassword() {
        
        ODBCWalletService.createAddress(kBCTestWalletIdentifier,apiKey: kBCTestApiKey, mainPassword: "1234", secondPassword: "456", label: "nameAddress", success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.DecryptingWallet){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    //500 - Create Address - Api Key
    func testWalletCreateAddressApiKey() {
        
        ODBCWalletService.createAddress(kBCTestWalletIdentifier,apiKey: "test", mainPassword: kBCTestMainPassword, secondPassword: kBCTestSecondPassword, label: "nameAddress", success: {(object : ODBalanceDetails) -> Void in
            //Success
            
            }, failure: {(error : ODBlockChainError) -> Void in
                if(ODBalanceDetails.parseErrorResponseFromAPI(error.contentMessage())==ODBCErrorAPI.ApiKey){
                    //Success
                    
                }else{
                    XCTFail(NSString(format:"Fail: %@",error.contentMessage()));
                }
        });
    }
    
    // MARK: Make payment
    
    // MARK: Make many payments
    
}
