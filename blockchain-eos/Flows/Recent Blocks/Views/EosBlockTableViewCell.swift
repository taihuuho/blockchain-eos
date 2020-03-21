//
//  EosBlockTableViewCell.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

class EosBlockTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = "EosBlockTableViewCell"
    
    @IBOutlet weak var producerNameLabel: UILabel!
    
    @IBOutlet weak var transactionsCountLabel: UILabel!

}
