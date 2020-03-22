//
//  BlockDetailsViewModel.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import Foundation

class BlockDetailsViewModel: BaseViewModel {
    
    var onRawJSONToggled: ((Bool) -> Void)?
    var onToggleJsonViewerButtonTitleChanged: ((String) -> Void)?
    
    private let eosBlock: EosBlock
    private var isRawJsonHidden: Bool = true
    
    var producer: String {
        get {
            return "Producer: \(eosBlock.producer)"
        }
    }
    
    var transactionCount: String {
        get {
            let transactionCountText = eosBlock.transactionCount > 1 ? "\(eosBlock.transactionCount) transactions" : "\(eosBlock.transactionCount) transaction"
            
            return "Transactions Count: \(transactionCountText)"
        }
    }
    
    var producerSignature: String {
        get {
            return "Producer Signature: \n \(eosBlock.producerSignature)"
        }
    }
    
    var rawJsonString: String {
        get {
            return eosBlock.rawJsonResponse?.description ?? ""
        }
    }
    
    init(eosBlock: EosBlock) {
        self.eosBlock = eosBlock
    }
    
    func getToggleRawJsonTitle() -> String {
        return self.isRawJsonHidden ? "Show Raw JSON" : "Hide Raw JSON"
    }
    
    func getViewTitle() -> String {
        return "Block Details"
    }
    
    func toggleRawJsonViewer() {
        self.isRawJsonHidden = !self.isRawJsonHidden
        self.onRawJSONToggled?(self.isRawJsonHidden)
        self.onToggleJsonViewerButtonTitleChanged?(self.getToggleRawJsonTitle())
    }
}
