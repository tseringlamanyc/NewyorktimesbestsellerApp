//
//  GoogleModel.swift
//  NYTimesBestSeller
//
//  Created by Kelby Mittan on 2/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation


struct GoogleSearch: Codable & Equatable {
    let items: [GoogleBook]
}

struct GoogleBook: Codable & Equatable {
    let volumeInfo: Info
}

struct Info: Codable & Equatable {
    let title: String
    let description: String
    let previewLink: String
    let infoLink: String
}
