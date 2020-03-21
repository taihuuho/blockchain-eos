//
//  UIViewController+Extension.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func main() -> UIStoryboard {
      return UIStoryboard(name: "Main", bundle: nil)
    }
}

protocol StoryboardBasedViewController {
    static func instantiate(from storyboard: UIStoryboard) -> Self
}

extension StoryboardBasedViewController where Self:UIViewController {
    static func instantiate(from storyboard: UIStoryboard) -> Self {
        // NOTE: We will be using the class name for the storyboard ID of the view controller
        
        // this returns the full name with the app name space included, for example "blockchain_ios.RecentBlocksViewController"
        let fullName = NSStringFromClass(self)

        // We want to get the last part, after the last dot "RecentBlocksViewController"
        let nameComponents = fullName.components(separatedBy: ".")
        let simpleClassName = nameComponents[nameComponents.count - 1]
        
        return storyboard.instantiateViewController(withIdentifier: simpleClassName) as! Self
    }
}
