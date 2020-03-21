//
//  MockEosApi.swift
//  blockchain-eosUITests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

@testable import blockchain_eos

class MockEosApi: EosApi {
    func getChainInfo(_ completion: @escaping (Result<EosInfo, ApiError>) -> Void) {
        
    }
    
    func getBlock(blockId: String, _ completion: @escaping (Result<EosBlock, ApiError>) -> Void) {
        
    }
    

}
