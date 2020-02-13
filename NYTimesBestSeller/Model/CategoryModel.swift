//
//  CategoryModel.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/12/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct AllCategory: Codable {
    let results: [Categories]
}

struct Categories: Codable {
    let listName: String
 
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
    }
}

