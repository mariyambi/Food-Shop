//
//  FoodByCategoryResponse.swift
//  CakeShop
//
//  Created by Mariyambi on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation
// MARK: - FoodByCategoriesResponse
struct FoodByCategoriesResponse: Codable {
    var status, statuscode, message: String?
    var data: [Food]?
}


