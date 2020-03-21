//
//  RecentBlocksViewModel.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

let MAX_BLOCKS = 20;

import UIKit

class RecentBlocksViewModel: BaseViewModel {
    
    var onRecentsBlocksUpdated: (([EosBlock]) -> Void)?
    var onLoadingStatusUpdated: ((ApiStatus) -> Void)?
    
    var transactionCount: Int {
        get {
            return recentBlocks.count
        }
    }
    
    private var apiClient: EosApi!
    private var recentBlocks = [EosBlock]()
    
    init(apiClient: EosApi) {
        self.apiClient = apiClient
    }
    
    private func fetchBlock(blockId: String) {
        self.onLoadingStatusUpdated?(.IN_PROGRESS)
        self.apiClient.getBlock(blockId: blockId) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let eosBlock):
                self.recentBlocks.append(eosBlock)
                self.onRecentsBlocksUpdated?(self.recentBlocks)
                
                if self.recentBlocks.count < MAX_BLOCKS {
                    self.fetchBlock(blockId: eosBlock.previousBlockId)
                } else {
                    self.onLoadingStatusUpdated?(.COMPLETED)
                }
                break
            case .failure(let error):
                self.onError?(error)
                self.onLoadingStatusUpdated?(.ERROR)
                break
            }
        }
    }
    
    func fetchRecentBlocks() {
        self.apiClient.getChainInfo { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let eosInfo):
                self.fetchBlock(blockId: eosInfo.headBlockId)
                break
            case .failure(let error):
                self.onError?(error)
                break
            }
        }
    }
    
    func configureCell(_ cell: EosBlockTableViewCell, forIndexPath indexPath: IndexPath) {
        let eosBlock = self.recentBlocks[indexPath.row]
        cell.producerNameLabel.text = "Producer: \(eosBlock.producer)"
        cell.transactionsCountLabel.text = eosBlock.transactionsCount > 1 ? "\(eosBlock.transactionsCount) transactions" : "\(eosBlock.transactionsCount) transaction"
    }
    
    func getViewTitle() -> String {
        return self.transactionCount > 1 ? "\(self.transactionCount) Blocks" : "\(self.transactionCount) Block"
    }
}
