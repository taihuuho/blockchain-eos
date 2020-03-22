//
//  UtilFunctionsTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest
@testable import blockchain_eos

class UtilFunctionsTests: XCTestCase {

    func testHTTPStatusIsOK() {
        let statuses = [
            100: false,
            200: true,
            201: true,
            300: true,
            399: true,
            400: false,
            500:false
        ]
        
        statuses.forEach { (arg) in
            let (statusCode, isValid) = arg
            XCTAssert(httpStatusIsOK(statusCode) == isValid)
        }
    }
    
    func testStoryboardBasedInitiation() {
        let _ = RecentBlocksViewController.instantiate(from: UIStoryboard.main())
        XCTAssert(true)
    }

}
