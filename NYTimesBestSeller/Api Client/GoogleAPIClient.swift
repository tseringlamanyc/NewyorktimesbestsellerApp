//
//  GoogleAPIClient.swift
//  NYTimesBestSeller
//
//  Created by Kelby Mittan on 2/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import NetworkHelper

struct GoogleAPIClient {
    
    static func getGoogleBooks(for isbn: String, completion: @escaping (Result<([GoogleBook]), AppError>) -> ()) {
        
        let googleAPIEndpointURL = "https://www.googleapis.com/books/v1/volumes?q=\(isbn)&maxResults=2"
        
        guard let url = URL(string: googleAPIEndpointURL) else {
            completion(.failure(.badURL(googleAPIEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let bookSearch = try JSONDecoder().decode(GoogleSearch.self, from: data)
                    let bookHits = bookSearch.items
                    
                    completion(.success(bookHits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
