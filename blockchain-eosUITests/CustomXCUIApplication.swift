//
//  CustomXCUIApplication.swift
//  blockchain-eosUITests
//
//  Created by Tai Huu Ho on 3/22/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest

class CustomXCUIApplication: XCUIApplication {
    override func launch() {
        self.launchArguments = [ "--uitesting" ]
        self.launchEnvironment = [
            "GET_INFO_SUCCESS" : TestContants.getInfoJSONSuccess,
            "GET_BLOCK_SUCCESS" : TestContants.getEosBlockJSON
        ]
        super.launch()
    }
}
