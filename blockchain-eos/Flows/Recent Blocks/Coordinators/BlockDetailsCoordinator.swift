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
    
    init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    func start() {
        let blockDetailsVC = BlockDetailsViewController.instantiate(from: UIStoryboard.main())
        self.presenter?.navigationController?.pushViewController( blockDetailsVC, animated: true)
    }
}
