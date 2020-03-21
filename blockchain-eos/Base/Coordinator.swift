//
//  Coordinator.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

protocol Coordinator {
    /// Kicks off the flow that is governed by the coordinator.
    /// For example, a view controller might be pushed onto another view controller
    /// that this coordinator is initialized with.
    func start()
}
