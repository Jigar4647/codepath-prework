//
//  ViewController.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 24/01/24.
//

import UIKit

class JokesViewController: UITableViewController {

    // Private properties
    var jokesListViewModel: JokesListViewModel!
    
    // Diplaying the activity indicator
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var isLoading = false
    var batchLimit = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Initialize viewModel
        jokesListViewModel = JokesListViewModel(serviceProtocol: JokesService())
        fetchJokesInBatches()
    }
    
    func fetchJokesInBatches() {
        isLoading = true
        // Start animating the activity indicator
        activityIndicator.startAnimating()
        
        jokesListViewModel.fetchJokesFromAPI(limit: batchLimit) { [weak self] newJokes in
            if newJokes.isEmpty {
                // No more jokes to load
                self?.isLoading = false
                return
            }
            self?.isLoading = false
            self?.jokesListViewModel.jokes.append(contentsOf: newJokes)
            self?.tableView.reloadData()
            self?.stopAnimating()
        }
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Add the activity indicator to the view
        view.addSubview(activityIndicator)
        
        // Center the activity indicator in the view
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: UITableViewDataSource functions
extension JokesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return jokesListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesListViewModel.numberOfItemsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JokesCellView else {
            return UITableViewCell()
        }
        
        let objJoke = jokesListViewModel.jokeAtIndex(indexPath.row)
        cell.configureCell(objJoke)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension JokesViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.jokesListViewModel.jokes.count - 1 && !isLoading {
            // Load more jokes when the last cell is about to be displayed
            fetchJokesInBatches()
        }
    }
}

