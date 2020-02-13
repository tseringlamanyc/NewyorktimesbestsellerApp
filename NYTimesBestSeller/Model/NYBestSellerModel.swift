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
    //    "contributor": "by Jeanine Cummins",
    //    "contributor_note": "",
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


//"num_results": 15,
//"last_modified": "2020-02-05T23:38:02-05:00",
//"results": {
//    "list_name": "Hardcover Fiction",
//    "list_name_encoded": "hardcover-fiction",
//    "bestsellers_date": "2020-02-01",
//    "published_date": "2020-02-16",
//    "published_date_description": "latest",
//    "next_published_date": "",
//    "previous_published_date": "2020-02-09",
//    "display_name": "Hardcover Fiction",
//    "normal_list_ends_at": 15,
//    "updated": "WEEKLY",
//    "books": [
//        {
//            "rank": 1,
//            "rank_last_week": 1,
//            "weeks_on_list": 2,
//            "asterisk": 0,
//            "dagger": 0,
//            "primary_isbn10": "1250209765",
//            "primary_isbn13": "9781250209764",
//            "publisher": "Flatiron",
//            "description": "A bookseller flees Mexico for the United States with her son while pursued by the head of a drug cartel.",
//            "price": 0,
//            "title": "AMERICAN DIRT",
//            "author": "Jeanine Cummins",
//            "contributor": "by Jeanine Cummins",
//            "contributor_note": "",
//            "book_image": "https://s1.nyt.com/du/books/images/9781250209764.jpg",
//            "book_image_width": 326,
//            "book_image_height": 495,
//            "amazon_product_url": "https://www.amazon.com/American-Dirt-Oprahs-Book-Club/dp/1250209765?tag=NYTBS-20",
//            "age_group": "",
//            "book_review_link": "https://www.nytimes.com/2020/01/17/books/review-american-dirt-jeanine-cummins.html",
//            "first_chapter_link": "",
//            "sunday_review_link": "",
//            "article_chapter_link": "",
//            "isbns": [
//                {
//                    "isbn10": "1250209765",
//                    "isbn13": "9781250209764"
//                },
//                {
//                    "isbn10": "1250772400",
//                    "isbn13": "9781250772404"
//                }
//            ],
//            "buy_links": [
//                {
//                    "name": "Amazon",
//                    "url": "https://www.amazon.com/American-Dirt-Oprahs-Book-Club/dp/1250209765?tag=NYTBS-20"
//                },
//                {
//                    "name": "Apple Books",
//                    "url": "http://du-gae-books-dot-nyt-du-prd.appspot.com/buy?title=AMERICAN+DIRT&author=Jeanine+Cummins"
//                },
//                {
//                    "name": "Barnes and Noble",
//                    "url": "http://www.anrdoezrs.net/click-7990613-11819508?url=http%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9781250209764"
//                },
//                {
//                    "name": "Local Booksellers",
//                    "url": "http://www.indiebound.org/book/9781250209764?aff=NYT"
//                }
//            ],
//            "book_uri": "nyt://book/ea1c7a1f-1743-57a8-b210-0150f87a4b47"
//        },
