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

    func fetchJokesFromAPI(limit: Int, completionHandler: @escaping (Jokes) -> Void) {
        
        service.fetchJokes(limit: limit) { result in
            switch result {
            case .success(let jokesArray):
                completionHandler(jokesArray)
            case .failure(let error):
                print("Error : \(error.localizedDescription)")
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
