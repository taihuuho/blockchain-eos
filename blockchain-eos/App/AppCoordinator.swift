//
//  AppCoordinator.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    private weak var window: UIWindow!
    // because we will push to the Block Details screen, so we will be using a nav controller
    var presenter: UINavigationController?
    private weak var apiClient: EosApi!
    
    init(window: UIWindow,
         presenter: UINavigationController,
         apiClient: EosApi) {
        self.window = window
        self.presenter = presenter
        self.apiClient = apiClient
    }
    
    func start() {
        self.window.rootViewController = self.presenter
        self.window.makeKeyAndVisible()
        
        self.showInitialScreen()
    }
    
    private func showInitialScreen() {
        let recentBlocksCoordinator = RecentBlocksCoordinator(presenter: self.presenter, apiClient: self.apiClient)
        recentBlocksCoordinator.start()
    }
}
