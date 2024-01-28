//
//  ViewController.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 24/01/24.
//

import UIKit

class JokesViewController: UITableViewController {

    // Private properties
    private var jokesListViewModel: JokesListViewModel!
    // Diplaying the activity indicator
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Initialize viewModel
        jokesListViewModel = JokesListViewModel(serviceProtocol: JokesService())
        renderingData()
    }
    
    func renderingData() {
        // Start animating the activity indicator
        activityIndicator.startAnimating()
        
        jokesListViewModel.fetchJokesFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success( _):
                self.tableView.reloadData()
                self.stopAnimating()
            case .failure(let error):
                print(error)
                self.stopAnimating()
            }
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

