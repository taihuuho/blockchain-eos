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
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    private var viewModel: RecentBlocksViewModel!
    
    func inject(viewModel: RecentBlocksViewModel) {
        self.viewModel = viewModel
    }
    
    override func setUpUI() {
        
        self.loadingIndicatorView.hidesWhenStopped = true
        
        self.recentBlocksTableView.rowHeight = UITableView.automaticDimension
        self.recentBlocksTableView.estimatedRowHeight = 60
        self.recentBlocksTableView.delegate = self
        self.recentBlocksTableView.dataSource = self
        self.recentBlocksTableView.isHidden = true
        self.viewRecentBlocksButton.isHidden = false
        self.loadingIndicatorView.isHidden = true
    }
    
    override func setUpBinding() {
        self.viewModel.onError = { error in
            DispatchQueue.main.async {
                self.showMessage(title: NSLocalizedString("Error", comment: ""), message: error.message)
            }
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
        
        self.viewModel.onLoadingStatusUpdated = { [weak self] apiStatus in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                switch apiStatus {
                case .IN_PROGRESS:
                    self.loadingIndicatorView.startAnimating()
                    self.view.isUserInteractionEnabled = false
                    self.viewRecentBlocksButton.isHidden = true
                    self.recentBlocksTableView.isHidden = false
                case .COMPLETED:
                    self.loadingIndicatorView.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                default:
                    self.loadingIndicatorView.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.viewRecentBlocksButton.isHidden = false
                    self.recentBlocksTableView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func viewRecentBlocks(_ sender: Any) {
        self.viewModel.fetchRecentBlocks()
    }
}

extension RecentBlocksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.blockCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: EosBlockTableViewCell.reuseIdentifier) as? EosBlockTableViewCell {
            viewModel.configureCell(cell, forIndexPath: indexPath)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.clickOnCell(atIndexPath: indexPath)
    }
}
