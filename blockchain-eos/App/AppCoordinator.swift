//
//  AppCoordinator.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    // because we will push to Block Details screen, so we will be using a nav controller
    private let rootVC: UINavigationController
    
    init(window: UIWindow, navController: UINavigationController) {
        self.window = window
        self.rootVC = navController
    }
    
    func start() {
        self.window.rootViewController = rootVC
        self.window.makeKeyAndVisible()
        
        self.showInitialScreen()
    }
    
    private func showInitialScreen() {
        let initialScreen = RecentBlocksViewController.instantiate(from: UIStoryboard.main())
        
        self.rootVC.setViewControllers([initialScreen], animated: false)
    }
}
