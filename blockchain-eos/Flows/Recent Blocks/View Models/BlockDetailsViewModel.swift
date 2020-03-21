//
//  BlockDetailsViewModel.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class BlockDetailsViewModel: BaseViewModel {
    
    private let eosBlock: EosBlock
    
    var producer: String {
        get {
            return "Producer: \(eosBlock.producer)"
        }
    }
    
    var transactionsCount: String {
        get {
            let transactionsCountText = eosBlock.transactionsCount > 1 ? "\(eosBlock.transactionsCount) transactions" : "\(eosBlock.transactionsCount) transaction"
            
            return "Transactions Count: \(transactionsCountText)"
        }
    }
    
    var producerSignature: String {
        get {
            return "Producer Signature: \n \(eosBlock.producerSignature)"
        }
    }
    
    init(eosBlock: EosBlock) {
        self.eosBlock = eosBlock
    }
    
    func getViewTitle() -> String {
        return "Block Details"
    }
}
