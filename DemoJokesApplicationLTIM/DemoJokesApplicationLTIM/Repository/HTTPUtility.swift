//
//  HTTPUtility.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

class HTTPUtility {
        
    // Create a Singleton utility class
    static let shared = HTTPUtility()
    private init() { }
    
    func fetchData<T: Decodable>(request: URLRequest, resultType: T.Type, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        
        var request = request
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let api_key = Util.getApiKeyFromKeyConfig() else {
            completionHandler(.failure(.invalidApiID))
            return
        }
        request.setValue(api_key, forHTTPHeaderField: Constants.headerField)
        
        URLSession.shared.dataTask(with: request) { resData, httpResponse, resError in
            if resError != nil {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            if let response = httpResponse as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = resData {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: data)
                            DispatchQueue.main.async {
                                completionHandler(.success(result))
                            }
                        } catch {
                            completionHandler(.failure(.invalidData))
                        }
                    } else {
                        completionHandler(.failure(.invalidData))
                    }
                case 401:
                    completionHandler(.failure(.invalidApiID))
                case 403:
                    completionHandler(.failure(.accessRestricted))
                default:
                    completionHandler(.failure(.invalidResponse))
                }
            }
        }.resume()
    }
}
