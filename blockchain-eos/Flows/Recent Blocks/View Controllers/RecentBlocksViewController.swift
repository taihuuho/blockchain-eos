//
//  RecentBlocksViewController.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

final class RecentBlocksViewController: BaseViewController {
    
    @IBOutlet weak var viewRecentBlocksButton: UIButton!
    @IBOutlet weak var recentBlocksTableView: UITableView!
    
    private var viewModel: RecentBlocksViewModel!
    
    func inject(viewModel: RecentBlocksViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpBinding()
    }
    
    private func setUpUI() {
        self.recentBlocksTableView.rowHeight = UITableView.automaticDimension
        self.recentBlocksTableView.estimatedRowHeight = 60
        self.recentBlocksTableView.delegate = self
        self.recentBlocksTableView.dataSource = self
        self.recentBlocksTableView.isHidden = true
        self.viewRecentBlocksButton.isHidden = false
    }
    
    private func setUpBinding() {
        self.viewModel.onError = { error in
            print(error)
        }
        self.viewModel.onRecentsBlocksUpdated = { [weak self] blocks in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                self.title = self.viewModel.getViewTitle()
                self.viewRecentBlocksButton.isHidden = true
                self.recentBlocksTableView.isHidden = false
                self.recentBlocksTableView.reloadData()
            }
        }
        
        self.viewModel.onRecentBlocksFetchCompleted = { [weak self] in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    @IBAction func viewRecentBlocks(_ sender: Any) {
        self.viewModel.fetchRecentBlocks()
        self.view.isUserInteractionEnabled = false
    }
}

extension RecentBlocksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.transactionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: EosBlockTableViewCell.reuseIdentifier) as? EosBlockTableViewCell {
            viewModel.configureCell(cell, forIndexPath: indexPath)
            
            return cell
        }
        
        return UITableViewCell()
    }
}
