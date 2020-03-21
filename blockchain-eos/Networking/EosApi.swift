//
//  EosApi.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

protocol EosApi: class {
    func getChainInfo(_ completion: @escaping(Result<EosInfo, Error>) -> Void)
    func getBlock(blockId: String, _ completion: @escaping(Result<EosBlock, Error>) -> Void)
}

func httpStatusIsOK(_ statusCode: Int) -> Bool {
    return statusCode >= 200 && statusCode < 400;
}
