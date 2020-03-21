//
//  EosApi.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

enum ApiStatus {
    case IN_PROGRESS
    case COMPLETED
    case ERROR
    case OTHER
}

struct ApiError: Error, Decodable {    
    let code: Int
    let message: String
}

protocol EosApi: class {
    func getChainInfo(_ completion: @escaping(Result<EosInfo, ApiError>) -> Void)
    func getBlock(blockId: String, _ completion: @escaping(Result<EosBlock, ApiError>) -> Void)
}

func httpStatusIsOK(_ statusCode: Int) -> Bool {
    return statusCode >= 200 && statusCode < 400;
}
