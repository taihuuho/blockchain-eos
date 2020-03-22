//
//  RecentBlocksViewModel.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class RecentBlocksViewModel: BaseViewModel {
    
    var onRecentsBlocksUpdated: (([EosBlock]) -> Void)?
    var onLoadingStatusUpdated: ((ApiStatus) -> Void)?
    var onClickOnBlock: ((EosBlock) -> Void)?
    
    var blockCount: Int {
        get {
            return recentBlocks.count
        }
    }
    
    private var apiClient: EosApi!
    private var recentBlocks = [EosBlock]()
    private var currentPage = 1
    
    init(apiClient: EosApi) {
        self.apiClient = apiClient
    }
    
    private func fetchBlocks(blockId: String) {
        self.onLoadingStatusUpdated?(.IN_PROGRESS)
        self.apiClient.getBlock(blockId: blockId) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let eosBlock):
                self.recentBlocks.append(eosBlock)
                self.onRecentsBlocksUpdated?(self.recentBlocks)
                
                if self.recentBlocks.count % Constants.Networking.MAX_BLOCKS_PER_PAGE != 0 {
                    self.fetchBlocks(blockId: eosBlock.previousBlockId)
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
    
    func refreshData() {
        currentPage = 1
        self.recentBlocks = [EosBlock]()
        self.onRecentsBlocksUpdated?(self.recentBlocks)
        self.fetchRecentBlocks()
    }
    
    func viewMore() {
        if let currentLowestBlockId = self.recentBlocks.last?.id {
            currentPage += 1
            self.fetchBlocks(blockId: currentLowestBlockId)
        }
    }
    
    func fetchRecentBlocks() {
        self.onLoadingStatusUpdated?(.IN_PROGRESS)
        self.apiClient.getChainInfo { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let eosInfo):
                self.fetchBlocks(blockId: eosInfo.headBlockId)
                break
            case .failure(let error):
                self.onError?(error)
                self.onLoadingStatusUpdated?(.ERROR)
                break
            }
        }
    }
    
    func configureCell(_ cell: EosBlockTableViewCell, forIndexPath indexPath: IndexPath) {
        let eosBlock = self.recentBlocks[indexPath.row]
        cell.producerNameLabel.text = "Producer: \(eosBlock.producer)"
        cell.blockIdLabel.text = "Id: \(eosBlock.id)"
    }
    
    func getViewTitle() -> String {
        return "\(self.blockCount)/\(Constants.Networking.MAX_BLOCKS_PER_PAGE * currentPage) Blocks"
    }
    
    func clickOnCell(atIndexPath indexPath: IndexPath) {
        let selectedBlock = self.recentBlocks[indexPath.row]
        self.onClickOnBlock?(selectedBlock)
    }
}
