//
//  CategoriesResponse.swift
//  CakeShop
//
//  Created by Mariyambi on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation


// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    var status, statuscode, message: String?
    var data: [FoodCategory]?
}


