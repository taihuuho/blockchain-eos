//
//  RecentBlocksViewController.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

final class RecentBlocksViewController: BaseViewController {
    
    private var viewModel: RecentBlocksViewModel!
    
    func inject(viewModel: RecentBlocksViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Test API
        
        let api  = try! EosApiImpl(endpoint: "https://eos.greymass.com")
        api.getChainInfo { (result) in
            switch result {
                case .success(let eosInfo):
                    print(eosInfo.headBlockId)
                    break;
                case .failure(let error):
                    print(error)
                    break;
            }
        }
    }
}
