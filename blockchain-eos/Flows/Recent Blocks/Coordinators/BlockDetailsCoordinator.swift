//
//  BlockDetailsCoordinator.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

final class BlockDetailsCoordinator: Coordinator {
    var presenter: UIViewController?
    let eosBlock: EosBlock
    
    init(presenter: UIViewController, eosBlock: EosBlock) {
        self.presenter = presenter
        self.eosBlock = eosBlock
    }
    
    func start() {
        let blockDetailsVC = BlockDetailsViewController.instantiate(from: UIStoryboard.main())
        let viewModel = BlockDetailsViewModel(eosBlock: self.eosBlock)
        blockDetailsVC.inject(viewModel: viewModel)
        self.presenter?.navigationController?.pushViewController( blockDetailsVC, animated: true)
    }
}
