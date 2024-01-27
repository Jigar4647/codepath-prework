//
//  JokesService.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation


struct JokesService: JokesServiceProtocol {
    
    func fetchJokes(completionHandler: @escaping resultCompletion) {
        
        let urlString = Constants.baseURL + APIPath.endPoint
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        guard let api_key = Util.getApiKeyFromKeyConfig() else {
            completionHandler(.failure(.invalidApiID))
            return
        }
        request.setValue(api_key, forHTTPHeaderField: Constants.headerField)

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
