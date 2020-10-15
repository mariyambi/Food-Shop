//
//  UIViewExtensions.swift
//  CakeShop
//
//  Created by Mariyambi on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //For Card Style
    func setCardView(){
        layer.cornerRadius = 3.0
        layer.borderWidth = 0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.8
    }
}
