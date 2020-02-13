//
//  CategoryAPI.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/12/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import NetworkHelper

struct CategoryAPI {
    static func getCategory(completion: @escaping (Result<[Categories], AppError>) -> ()) {
        
        let categoryUrl = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(APIKey.nYTKey)"
        
        guard let url = URL(string: categoryUrl) else {
            completion(.failure(.badURL(categoryUrl)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let categorySearch = try JSONDecoder().decode(AllCategory.self, from: data)
                    let allCategory = categorySearch.results
                    completion(.success(allCategory))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
