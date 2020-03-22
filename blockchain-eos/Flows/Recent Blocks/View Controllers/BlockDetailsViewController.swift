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
    @IBOutlet weak var transactionCountLabel: UILabel!
    @IBOutlet weak var toggleRawJsonButton: UIButton!
    @IBOutlet weak var rawJsonTextView: UITextView!
    
    private var viewModel: BlockDetailsViewModel!
    
    func inject(viewModel: BlockDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func setUpUI() {
        self.rawJsonTextView.isEditable = false
        self.rawJsonTextView.layer.borderWidth = 1
        self.rawJsonTextView.layer.borderColor = Constants.UI.AppTextColor.cgColor
        
        self.title = self.viewModel.getViewTitle()
        self.producerNameLabel.text = self.viewModel.producer
        self.transactionCountLabel.text = self.viewModel.transactionCount
        self.producerSignatureLabel.text = self.viewModel.producerSignature
        self.rawJsonTextView.text = self.viewModel.rawJsonString
    }
    
    override func setUpBinding() {
        
        self.viewModel.onRawJSONToggled = { hidden in
            self.rawJsonTextView.isHidden = hidden
        }
        
        self.viewModel.onToggleJsonViewerButtonTitleChanged = { title  in
            self.toggleRawJsonButton.setTitle(title, for: .normal)
        }
        
        self.viewModel.toggleRawJsonViewer()
    }
    
    @IBAction func toggleRawJsonViewer() {
        self.viewModel.toggleRawJsonViewer()
    }
}
