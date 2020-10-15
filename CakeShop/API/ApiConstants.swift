//
//  ApiConstants.swift
//  CakeShop
//
//  Created by Mariyambi on 13/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation
struct ApiConstants {
    static let BaseUrl = "https://mobileapp.chickinguae.com/index.php/api/"
    static let categories = "\(ApiConstants.BaseUrl)listAllCakeCategory"
    static let listCakeByCategory = "\(ApiConstants.BaseUrl)listCakesByCategory/"
    static let ImageUrl = "https://mobileapp.chickinguae.com/images/"
    static let imageForFood = "\(ImageUrl)cakes/"
}
