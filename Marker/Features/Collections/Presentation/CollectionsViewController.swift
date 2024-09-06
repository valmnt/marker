//
//  CollectionsViewController.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import UIKit

class CollectionsViewController: UIViewController {
    
    private let viewModel: CollectionsViewModel = CollectionsViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        return spinner
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .primaryBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpinner()
        viewModel.getCollections {
            DispatchQueue.main.async { [weak self] in
                self?.spinner.stopAnimating()
                if (self?.viewModel.collections.isEmpty ?? true) {
                    self?.setupErrorView()
                } else {
                    self?.setupTableView()
                }
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .primaryBackground
        tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: "GenreTableViewCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupErrorView() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "CollectionsError")
        label.font = label.font.withSize(22)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .white
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupSpinner() {
        spinner.startAnimating()
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension CollectionsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

extension CollectionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collection = viewModel.collections[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell", for: indexPath) as? GenreTableViewCell,
              let genre = Genre.from(rawValue: collection.0) else {
            return UITableViewCell()
        }
        cell.data = collection.1
        cell.title = genre.string()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.collections.count
    }
}
