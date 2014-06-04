/////////// NETWORK ///////////

//HTTP
#define kBlockChainGET @"GET"
#define kBlockChainPOST @"POST"

//NETWORK MANAGEMENT
#define kBlockChainTimeout 20

/////////// URL ///////////
#define kBlockChainUrl @"https://blockchain.info/api/v2/"

#define kBlockChainUrlCreateWallet ([NSString stringWithFormat:@"%@%@",kBlockChainUrl,@"create_wallet"])