//
//  AppDelegate.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/19/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

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
        
        let apiClientFactory = APIClientFactory(apiClientMode: Constants.Networking.ApiClientMode)
        var apiClient = apiClientFactory.newApiClient()
        
        #if DEBUG
        if let mockEndpoint = ProcessInfo.processInfo.environment["MOCK_SERVER"] {
            apiClient = EosApiClient(endpoint: mockEndpoint)
        }
        #endif
        
        self.appCoordinator = AppCoordinator(window: window, presenter: navController, apiClient: apiClient)
        
        self.appCoordinator?.start()
    }
}

