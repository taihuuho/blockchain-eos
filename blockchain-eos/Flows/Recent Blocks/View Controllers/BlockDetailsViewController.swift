//
//  BlockDetailsViewController.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

final class BlockDetailsViewController: BaseViewController {
    @IBOutlet weak var producerNameLabel: UILabel!
    @IBOutlet weak var producerSignatureLabel: UILabel!
    
    @IBOutlet weak var toggleRawJsonButton: UIButton!
    @IBOutlet weak var transactionsCountLabel: UILabel!
    private var viewModel: BlockDetailsViewModel!
    
    func inject(viewModel: BlockDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func setUpUI() {
        
    }
    
    override func setUpBinding() {
        self.title = self.viewModel.getViewTitle()
        self.producerNameLabel.text = self.viewModel.producer
        self.transactionsCountLabel.text = self.viewModel.transactionsCount
        self.producerSignatureLabel.text = self.viewModel.producerSignature
    }
}
