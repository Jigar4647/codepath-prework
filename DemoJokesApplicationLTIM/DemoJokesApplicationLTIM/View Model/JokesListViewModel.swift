//
//  JokesViewModel.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

class JokesListViewModel {
    
    var jokes: Jokes = []

    // Dependancy injection by using protocol instance
    private let service: JokesServiceProtocol
    init(serviceProtocol: JokesServiceProtocol) {
        self.service = serviceProtocol
    }
}

// MARK: - Data Preparation
extension JokesListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return self.jokes.count
    }
    
    func jokeAtIndex(_ index: Int) -> JokesViewModel {
        let joke = self.jokes[index]
        return JokesViewModel(joke: joke)
    }
}

// MARK: API calling
extension JokesListViewModel {
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

struct JokesViewModel {
    private let objJoke: Joke
    
    init(joke: Joke) {
        self.objJoke = joke
    }
    
    var jokeDescription: String {
        return objJoke.joke
    }
}
