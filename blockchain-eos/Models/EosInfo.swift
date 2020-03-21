//
//  EosInfo.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

struct EosInfo: RawResponseViewAble {
    
    enum CodingKeys: String, CodingKey {
        case headBlockId = "head_block_id"
    }
    var rawJsonResponse: AnyObject?
    
    // we only need this field for now
    let headBlockId: String
}
