//
//  NYTimesBestSellerTests.swift
//  NYTimesBestSellerTests
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import XCTest
@testable import NYTimesBestSeller

class NYTimesBestSellerTests: XCTestCase {

    func testBestBook() {
        
        let expectedTitle = "AMERICAN DIRT"
        
        NYTAPIClient.getBooks(for: "hardcover-fiction") { (result) in
            switch result {
            case .failure(let error):
                XCTFail("decoding error: \(error)")
            case .success(let books):
                let title = books.first?.title
                XCTAssertEqual(expectedTitle, title)
            }
        }
        
    }

}
