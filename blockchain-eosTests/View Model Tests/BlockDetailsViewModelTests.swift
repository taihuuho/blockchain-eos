//
//  BlockDetailsViewModelTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest
@testable import blockchain_eos

class BlockDetailsViewModelTests: XCTestCase {

    private var viewModel : BlockDetailsViewModel!
    private var eosBlock : EosBlock!

    override func setUp() {
        super.setUp()
        self.eosBlock = MockDataProvider.createEosBlock()
        MockDataProvider.clearAllMockData()
        self.viewModel = BlockDetailsViewModel(eosBlock: eosBlock)
    }
    
    override func tearDown() {
        self.viewModel = nil
    }

    func testDataMatch() {
        XCTAssertTrue(self.viewModel.producer.contains(eosBlock.producer))
        XCTAssertTrue(self.viewModel.producerSignature.contains(eosBlock.producerSignature))
        XCTAssertTrue(self.viewModel.transactionCount.contains("\(eosBlock.transactionCount)"))
        XCTAssertTrue(self.viewModel.rawJsonString == eosBlock.rawJsonResponse!.description)
    }
    
    func testToggleRawJSONTwice() {
        
        self.viewModel.onRawJSONToggled = { hidden in
            XCTAssertFalse(hidden)
        }
        
        self.viewModel.toggleRawJsonViewer()
        
        self.viewModel.onRawJSONToggled = { hidden in
            XCTAssertTrue(hidden)
        }
        
        self.viewModel.toggleRawJsonViewer()
    }

}
