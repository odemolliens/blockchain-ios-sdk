//
//  ODListeningAdresses.swift
//  ODBlockChainWallet
//
//  Created by OlivierDemolliens on 8/19/14.
//  Copyright (c) 2014 Olivier Demolliens. All rights reserved.
//

import UIKit

class ODListeningAdresses: NSObject {
 
    class func parseErrorResponseFromAPI(response:NSString) -> ODBCErrorAPI
    {
        // TODO : undev
        if(response.isEqualToString(kBCCommonNull) || response.isEqualToString(kBCCommonCloudFare)){
            return ODBCErrorAPI.ApiUnavailable;
        }
        else if (response.isEqualToString(kBCWalletConfirmationsLimit)){
            return ODBCErrorAPI.Invalid;
        }else{
            return ODBCErrorAPI.Unknow;
        }
    }
}
