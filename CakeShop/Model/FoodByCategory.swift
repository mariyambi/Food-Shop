//
//  FoodByCategory.swift
//  CakeShop
//
//  Created by Subair Ariyil on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation

struct Food: Codable {
    var id: Int?
    var title, image, datumDescription, cakeCategoryID: String?
    var isPopular, price, availableFrom, availableTo: String?
    var fromTime, fromTimeSection, toTime, toTimeSection: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case datumDescription = "description"
        case cakeCategoryID = "cake_category_id"
        case isPopular = "is_popular"
        case price
        case availableFrom = "available_from"
        case availableTo = "available_to"
        case fromTime = "from_time"
        case fromTimeSection = "from_time_section"
        case toTime = "to_time"
        case toTimeSection = "to_time_section"
    }
}
