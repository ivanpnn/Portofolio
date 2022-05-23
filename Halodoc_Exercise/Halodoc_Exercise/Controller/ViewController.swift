//
//  ViewController.swift
//  Halodoc_Exercise
//
//  Created by MacBook Noob on 29/09/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    var searchBar: UISearchBar = UISearchBar()

    private var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        view.addSubview(tableView)
        tableView.addSubview(searchBar)
        
        let queryItems = [
            URLQueryItem(name: "query", value: "topic"),
            URLQueryItem(name: "page", value: "2")
        ]
        
        loadData(withQuery: queryItems)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData(withQuery query: [URLQueryItem]) {
        NetworkManager.shared.getJSONDataFrom(url: Constant.url, queryItems: query) { result in
            self.news = NetworkManager.shared.getNews(data: result)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func showNews(_ url: String) {
        guard url != "null" else {
            showAlert()
            return
        }
        
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Sorry!",
                                      message: "The News you're looking for currently is not available", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = news[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showNews(news[indexPath.row].newsURL)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let queryItems = [
            URLQueryItem(name: "query", value: searchBar.text)
        ]
        
        loadData(withQuery: queryItems)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

