//
//  RecentBlocksViewModelTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest
@testable import blockchain_eos

class RecentBlocksViewModelTests: XCTestCase {

    private var viewModel : RecentBlocksViewModel!
    private var apiClient : EosApi!

    override func setUp() {
        super.setUp()
        self.apiClient = MockEosApi()
        MockDataProvider.clearAllMockData()
        self.viewModel = RecentBlocksViewModel(apiClient: apiClient)
    }

    override func tearDown() {
        self.apiClient = nil
        self.viewModel = nil
    }

    func testRecentBlocksFetch() {
        self.viewModel.onRecentsBlocksUpdated = { status in
            XCTAssertTrue(self.viewModel.blockCount == MockDataProvider.loadedBlocks.count)
        }
        self.viewModel.fetchRecentBlocks()
    }
    
    func testNoService() {
        self.apiClient = nil
        self.viewModel.onError = { error in
            XCTAssertNotNil(error)
        }
        self.viewModel.fetchRecentBlocks()
    }
    
    func testBlockCountTitle() {
        self.viewModel.onRecentsBlocksUpdated = { status in
            XCTAssertTrue(self.viewModel.getViewTitle().contains("\(MockDataProvider.loadedBlocks.count)") )
        }
        self.viewModel.fetchRecentBlocks()
    }
}
