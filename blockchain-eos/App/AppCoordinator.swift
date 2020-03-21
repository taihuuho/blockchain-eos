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
    private weak var rootVC: UINavigationController!
    private weak var apiClient: EosApi!
    
    init(window: UIWindow,
         navController: UINavigationController,
         apiClient: EosApi) {
        self.window = window
        self.rootVC = navController
        self.apiClient = apiClient
    }
    
    func start() {
        self.window.rootViewController = rootVC
        self.window.makeKeyAndVisible()
        
        self.showInitialScreen()
    }
    
    private func showInitialScreen() {
        let initialScreen = RecentBlocksViewController.instantiate(from: UIStoryboard.main())
        let viewModel = RecentBlocksViewModel(apiClient: self.apiClient)
        initialScreen.inject(viewModel: viewModel)
        self.rootVC.setViewControllers([initialScreen], animated: false)
    }
}
