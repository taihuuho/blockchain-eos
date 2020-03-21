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

class RecentBlocksViewControllerTests: QuickSpec {
    
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
        
        describe("RecentBlocksViewControllerTests") {
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
            
            context("when the button is clicked") {
                beforeEach {
                    MockDataProvider.clearAllMockData()
                    subject.viewRecentBlocksButton.sendActions(for: .touchUpInside)
                }
                
                it("the table view should become visible") {
                    expect(subject.recentBlocksTableView.isHidden).toEventually(equal(false))
                }
                
                describe("Table view") {
                    it("shoul have one section") {
                        expect(subject.recentBlocksTableView.numberOfSections).to(equal(1))
                    }
                    it("there should be \(MAX_BLOCKS_PER_PAGE) cells in table view") {
                        expect(subject.recentBlocksTableView.numberOfRows(inSection: 0)).to(equal(MAX_BLOCKS_PER_PAGE))
                    }
                    
                    it("the 9th cell should display the correct info of the 9th eos block") {
                        let row = 8
                        let block = MockDataProvider.loadedBlocks[row]
                        let cell = subject.tableView(subject.recentBlocksTableView, cellForRowAt: [row, 0]) as! EosBlockTableViewCell
                        
                        expect(cell.producerNameLabel.text).to(contain(block.producer))
                        expect(cell.blockIdLabel.text).to(contain(block.id))
                    }
                }
            }
        }
    }
}
