//
//  TextViewStyleVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/12/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit

class TextViewStyleVC: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        layer.borderColor = UIColor(red:0.81, green:0.85, blue:0.86, alpha:1.0).cgColor
        layer.borderWidth = 1.2
        
    }
}
