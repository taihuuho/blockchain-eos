//
//  RecentBlocksCoordinator.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

protocol RecentBlocksCoordinatorProtocol {
    func showRecentBlocks()
}

final class RecentBlocksCoordinator: Coordinator {
    
    var presenter: UINavigationController?
    private var apiClient: EosApi
    
    init(presenter: UINavigationController?, apiClient: EosApi) {
        self.presenter = presenter
        self.apiClient = apiClient
    }
    
    func start() {
        showRecentBlocks()
    }
}

extension RecentBlocksCoordinator: RecentBlocksCoordinatorProtocol {
    func showRecentBlocks() {
        let initialScreen = RecentBlocksViewController.instantiate(from: UIStoryboard.main())
        let viewModel = RecentBlocksViewModel(apiClient: self.apiClient)
        viewModel.onClickOnBlock = {[weak self] block in
            guard let `self` = self else { return }
            
            let blockDetailsCoordinator = BlockDetailsCoordinator(presenter: self.presenter, eosBlock: block)
            blockDetailsCoordinator.start()
        }
        initialScreen.inject(viewModel: viewModel)
        
        self.presenter?.setViewControllers([initialScreen], animated: false)
    }
}
