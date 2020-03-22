//
//  RecentBlocksCoordinatorTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest
@testable import blockchain_eos

class RecentBlocksCoordinatorTests: XCTestCase {

    var navController: UINavigationController!
    var coordinator: RecentBlocksCoordinator!
    var apiClient: EosApi!
    
    override func setUp() {
        navController = UINavigationController()
        apiClient = MockEosApi()
        coordinator = RecentBlocksCoordinator(presenter: navController, apiClient: apiClient)
    }

    override func tearDown() {
        navController = nil
        apiClient = nil
        coordinator = nil
    }

    func testCoordinatorShouldShowRecentBlocksScreen() {
        coordinator.start()
        
        XCTAssertTrue(navController.topViewController is RecentBlocksViewController)
    }
}
