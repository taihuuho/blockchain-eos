//
//  BlockDetailsCoordinatorTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest
@testable import blockchain_eos

class BlockDetailsCoordinatorTests: XCTestCase {

    var navController: UINavigationController!
    var coordinator: BlockDetailsCoordinator!
    var eosBlock: EosBlock!
    
    override func setUp() {
        navController = UINavigationController()
        eosBlock = MockDataProvider.createEosBlock()
        coordinator = BlockDetailsCoordinator(presenter: navController, eosBlock: eosBlock)
    }

    override func tearDown() {
        navController = nil
        coordinator = nil
        eosBlock = nil
    }

    func testShouldShowBlockDetailsScreen() {
        coordinator.start()
        
        XCTAssertTrue(navController.topViewController is BlockDetailsViewController)
    }

}
