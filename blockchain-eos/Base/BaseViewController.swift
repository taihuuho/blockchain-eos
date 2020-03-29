//
//  BaseViewController.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, StoryboardBasedViewController {

    #if DEBUG
    deinit {
        print("\(self) deninitializing")
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        setUpBinding()
        
        self.view.backgroundColor = Constants.UI.AppViewBackgroundColor
    }
    
    func setUpUI() {
        
    }
    
    func setUpBinding() {
        
    }
}
