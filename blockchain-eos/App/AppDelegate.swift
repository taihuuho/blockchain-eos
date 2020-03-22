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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if CommandLine.arguments.contains("--uitesting") {
            self.stubNetworking()
        }
        
        UILabel.appearance().textColor = Constants.UI.AppTextColor
        UIButton.appearance().setTitleColor( .white, for: .normal)
        UITextView.appearance().textColor =  Constants.UI.AppTextColor
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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

