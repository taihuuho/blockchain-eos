//
//  BlockDetailsViewModel.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class BlockDetailsViewModel: BaseViewModel {
    
    var onRawJSONToggled: ((Bool) -> Void)?
    var onToggleJsonViewerButtonTitleChanged: ((String) -> Void)?
    
    private let eosBlock: EosBlock
    private var isRawJsonHidden: Bool = false
    
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
    
    var rawJsonString: String {
        get {
            return eosBlock.rawJsonResponse?.description ?? ""
        }
    }
    
    init(eosBlock: EosBlock) {
        self.eosBlock = eosBlock
    }
    
    private func getToggleRawJsonTitle() -> String {
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
