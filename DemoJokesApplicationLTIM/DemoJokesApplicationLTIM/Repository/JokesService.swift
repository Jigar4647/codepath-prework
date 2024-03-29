//
//  JokesService.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation


struct JokesService: JokesServiceProtocol {
    
    func fetchJokes(limit: Int, completionHandler: @escaping resultCompletion) {
        
        let urlString = Constants.baseURL + String(format: APIPath.endPoint, limit)
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        HTTPUtility.shared.fetchData(request: request, resultType: Jokes.self) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
