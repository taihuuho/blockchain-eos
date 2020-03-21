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
    @IBOutlet weak var transactionsCountLabel: UILabel!
    @IBOutlet weak var toggleRawJsonButton: UIButton!
    @IBOutlet weak var rawJsonTextView: UITextView!
    
    private var viewModel: BlockDetailsViewModel!
    
    func inject(viewModel: BlockDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func setUpUI() {
        self.rawJsonTextView.isEditable = false
    }
    
    override func setUpBinding() {
        self.title = self.viewModel.getViewTitle()
        self.producerNameLabel.text = self.viewModel.producer
        self.transactionsCountLabel.text = self.viewModel.transactionsCount
        self.producerSignatureLabel.text = self.viewModel.producerSignature
        self.rawJsonTextView.text = self.viewModel.rawJsonString
        
        self.viewModel.onRawJSONToggled = { hidden in
            self.rawJsonTextView.isHidden = hidden
        }
        
        self.viewModel.onToggleJsonViewerButtonTitleChanged = { title  in
            self.toggleRawJsonButton.setTitle(title, for: .normal)
        }
    }
    
    @IBAction func toggleRawJsonViewer() {
        self.viewModel.toggleRawJsonViewer()
    }
}
