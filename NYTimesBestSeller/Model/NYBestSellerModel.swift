//
//  NYBestSellerModel.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct BookSearch: Codable & Equatable {
    let lastModified: String
    let results: BookResult
    private enum CodingKeys: String, CodingKey {
        case lastModified = "last_modified"
        case results
    }
}

struct BookResult: Codable & Equatable {
    let listName: String
    let listNameEncoded: String
    let books: [Book]
    let bestsellersDate: String
    let publishedDate: String
    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case books
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
    }
}

struct Book: Codable & Equatable {
    let rank: Int
    let rankLastWeek: Int
    let weeksOnList: Int
    let description: String
    let price: Int
    let title: String
    let author: String
    let bookImage: String
    let contributor: String
    let primaryIsbn10: String
    let bookReviewLink: String
    let buyLinks: [Link]
    
    private enum CodingKeys: String, CodingKey {
        case rank
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case description
        case price
        case title
        case author
        case bookImage = "book_image"
        case contributor
        case primaryIsbn10 = "primary_isbn10"
        case bookReviewLink = "book_review_link"
        case buyLinks = "buy_links"
    }
}

struct Link: Codable & Equatable {
    let name: String
    let url: String
}

enum BuyLink: String {
    case amazon = "Amazon"
    case appleBooks = "Apple Books"
    case barnesAndNoble = "Barnes and Noble"
    case localBooksellers = "Local Booksellers"
}

extension Book {
    func getBuyLinkURL(for linkType: BuyLink) -> String {
        
        let result = buyLinks.filter { $0.name == linkType.rawValue }
        guard let firstResult = result.first else { return "Empty" }
        
        return firstResult.url
    }
}
