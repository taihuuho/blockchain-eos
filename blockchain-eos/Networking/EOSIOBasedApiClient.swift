//
//  EOSIOBasedApiClient.swift
//  blockchain-eos
//
//  Created by Tai Ho on 3/22/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import PromiseKit
import EosioSwift

class EOSIOBasedApiClient: EosApi {
    
    var rpcProvider: EosioRpcProvider!
    
    init(endpoint: String) {
        if let endpointUrl = URL(string: endpoint) {
            self.rpcProvider = EosioRpcProvider(endpoint: endpointUrl)
        }
    }
    
    func getChainInfo(_ completion: @escaping (Swift.Result<EosInfo, ApiError>) -> Void) {
        
        rpcProvider
            .getInfo(PMKNamespacer.promise)
            .done { (eosInfo) in
                let myEosInfo = EosInfo(rawJsonResponse: eosInfo._rawResponse as AnyObject, headBlockId: eosInfo.headBlockId)
                completion(.success(myEosInfo))
            }.catch { (error) in
                let eosioError = error.eosioError
                let apiError = ApiError(code: eosioError.originalError?.code ??  -1, message: eosioError.reason)
                completion(.failure(apiError))
            }
    }
    
    func getBlock(blockId: String, _ completion: @escaping (Swift.Result<EosBlock, ApiError>) -> Void) {

        let params = EosioRpcBlockRequest(blockNumOrId: blockId)
        rpcProvider
            .getBlock(PMKNamespacer.promise, requestParameters: params)
            .done { (eosBlock) in
                if let rawJSONResponse = eosBlock._rawResponse,
                    let data = try? JSONSerialization.data(withJSONObject: rawJSONResponse, options: []),
                    let myEosBlock = try? JSONDecoder().decode(EosBlock.self, from: data)
                    {
                    completion(.success(myEosBlock))
                } else {
                    
                }
            }
            .catch { (error) in
                let eosioError = error.eosioError
                let apiError = ApiError(code: eosioError.originalError?.code ??  -1, message: eosioError.reason)
                completion(.failure(apiError))
            }
    }

}
