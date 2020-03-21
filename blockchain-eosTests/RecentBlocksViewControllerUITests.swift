//
//  RecentBlocksViewControllerUITests.swift.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/19/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import Nimble
import Quick
@testable import blockchain_eos

class RecentBlocksViewControllerUITests: QuickSpec {
    
    override func spec() {
        var subject: RecentBlocksViewController!
        var viewModel: RecentBlocksViewModel!
        var apiClient: EosApi!
        
        beforeEach {
            apiClient = MockEosApi()
            viewModel = RecentBlocksViewModel(apiClient: apiClient)
            subject = RecentBlocksViewController.instantiate(from: UIStoryboard.main())
            subject.inject(viewModel: viewModel)
            
            // hell yeah, need to do this to trigger viewDidLoad
            _ = subject.view
        }
        
        context("when view is load") {
            it("the table view should be hidden") {
                expect(subject.recentBlocksTableView.isHidden).to(equal(true))
            }
            
            it("the button title should be correct") {
                expect(subject.viewRecentBlocksButton.titleLabel?.text).to(equal("View Recent Blocks"))
            }
            
            it("the View Recents Block button should visible") {
                expect(subject.viewRecentBlocksButton.isHidden).to(equal(false))
            }
        }
    }
}
