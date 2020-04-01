//
//  CustomXCUIApplication.swift
//  blockchain-eosUITests
//
//  Created by Tai Huu Ho on 3/22/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest
import Swifter

class CustomXCUIApplication: XCUIApplication {
    
    static let mockServer: HttpServer = createMockServer()
    
    override func launch() {
        if !CustomXCUIApplication.mockServer.operating{
            try! CustomXCUIApplication.mockServer.start(80)
        }
        self.launchEnvironment = [
            "MOCK_SERVER" : "http://127.0.0.1"
        ]
        super.launch()
    }
    
    private static func createMockServer() -> HttpServer {

        let server = HttpServer()
        
        let getInfoData = TestContants.getInfoJSONSuccess.data(using: .utf8)!
        let getInfoResponse = try! JSONSerialization.jsonObject(with: getInfoData, options: [.allowFragments])
        
        server.POST["/v1/chain/get_info"] = { request in
            return HttpResponse.ok(.json(getInfoResponse))
        }
        
        let getBlockData = TestContants.getEosBlockJSON.data(using: .utf8)!
        let getBlockResponse = try! JSONSerialization.jsonObject(with: getBlockData, options: [.allowFragments])
        server.POST["/v1/chain/get_block"] = { request in
            return HttpResponse.ok(.json(getBlockResponse))
        }
        
        return server
    }
}
