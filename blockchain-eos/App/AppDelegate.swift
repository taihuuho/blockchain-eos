//
//  AppDelegate.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/19/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

#if DEBUG
import OHHTTPStubs
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if CommandLine.arguments.contains("--uitesting") {
            self.stubNetworking()
        }
        
        start()
        
        setAppColors()
        
        return true
    }
    
    private func setAppColors() {
        UILabel.appearance().textColor = Constants.UI.AppTextColor
        UIButton.appearance().setTitleColor( .white, for: .normal)
        UITextView.appearance().textColor =  Constants.UI.AppTextColor
    }

    private func start() {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let navController = UINavigationController()
        let apiClient = EosApiClient(endpoint: Constants.Networking.EosNodeEndpoint)
        
        self.appCoordinator = AppCoordinator(window: window, presenter: navController, apiClient: apiClient)
        
        self.appCoordinator?.start()
    }
    #if DEBUG
    private func stubNetworking() {

        stub(condition: isHost ("eos.greymass.com")) { (_) -> HTTPStubsResponse in
            let mockJSON = ProcessInfo.processInfo.environment["GET_INFO_SUCCESS"]!
            let data = mockJSON.data(using: .utf8)!
            return HTTPStubsResponse(data: data, statusCode:200, headers:nil)
        }
        
        stub(condition: isPath("/v1/chain/get_block")) { (_) -> HTTPStubsResponse in
            let mockJSON = ProcessInfo.processInfo.environment["GET_BLOCK_SUCCESS"]!
            let data = mockJSON.data(using: .utf8)!
            return HTTPStubsResponse(data: data, statusCode:200, headers:nil)
        }
    }
    
    #endif
}

