//
//  JokesViewModel.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

class JokesViewModel {
    
    var jokes: Jokes = []

    // Dependancy injection by using protocol instance
    private let service: JokesServiceProtocol
    init(serviceProtocol: JokesServiceProtocol) {
        self.service = serviceProtocol
    }
}

// MARK: - Data Preparation
extension JokesViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return self.jokes.count
    }
    
    func getJokeBy(_ index: Int) -> Joke? {
        return index < jokes.count ? jokes[index] : nil
    }
}

// MARK: API calling
extension JokesViewModel {
    typealias completionHandler = ((Result<Bool, NetworkError>) -> Void)

    func fetchJokesFromAPI(completionHandler: @escaping completionHandler) {
        
        service.fetchJokes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let jokesArray):
                self.jokes = jokesArray
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
