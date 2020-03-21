//
//  BaseViewModel.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import Foundation

class BaseViewModel {
    var onError: ((ApiError) -> Void)?
    
    #if DEBUG
    deinit {
        print("\(NSStringFromClass(Self.self)) deinitiated")
    }
    #endif
}
