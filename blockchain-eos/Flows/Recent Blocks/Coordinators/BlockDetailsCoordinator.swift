//
//  BlockDetailsCoordinator.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

protocol BlockDetailsCoordinatorProtocol {
    func showBlockDetails()
}

final class BlockDetailsCoordinator: Coordinator {
    
    var presenter: UINavigationController?
    
    let eosBlock: EosBlock
    
    init(presenter: UINavigationController?, eosBlock: EosBlock) {
        self.presenter = presenter
        self.eosBlock = eosBlock
    }
    
    func start() {
        showBlockDetails()
    }
}

extension BlockDetailsCoordinator: BlockDetailsCoordinatorProtocol {
    func showBlockDetails() {
        let blockDetailsVC = BlockDetailsViewController.instantiate(from: UIStoryboard.main())
        let viewModel = BlockDetailsViewModel(eosBlock: self.eosBlock)
        blockDetailsVC.inject(viewModel: viewModel)
        self.presenter?.pushViewController( blockDetailsVC, animated: true)
    }
}
