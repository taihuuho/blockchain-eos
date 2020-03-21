//
//  EosInfo.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

struct EosInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case headBlockId = "head_block_id"
    }
    
    // we only need this field for now
    let headBlockId: String
}
