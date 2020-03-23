//
//  APIClientFactory.swift
//  blockchain-eos
//
//  Created by Tai Ho on 3/22/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

enum APIClientMode {
    case eosioSDK
    case nonEosioSDK
}

class APIClientFactory {
    let apiClientMode: APIClientMode
    
    init(apiClientMode: APIClientMode = .eosioSDK) {
        self.apiClientMode = apiClientMode
    }
    
    func newApiClient() -> EosApi {
        switch apiClientMode {
        case .eosioSDK:
            return EOSIOBasedApiClient(endpoint: Constants.Networking.EosNodeEndpoint)
        default:
            return EosApiClient(endpoint: Constants.Networking.EosNodeEndpoint)
        }
    }
}
