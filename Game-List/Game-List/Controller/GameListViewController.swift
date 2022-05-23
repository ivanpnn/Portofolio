//
//  FirstViewController.swift
//  Game-List
//
//  Created by MacBook Noob on 11/08/21.
//

import UIKit

class GameListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 150
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.13, alpha: 1.00)
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GameListCell.nib(), forCellReuseIdentifier: "GameListCell")
        return view
    }()
    
    private let pendingOperations = PendingOperations()
    private var games = [GameContent]()
    private var isLoaded = false
    private var isMoveToNextVC = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        let queryItems = [
            URLQueryItem(name: "key", value: Constants.key),
        ]
        
        NetworkManager.shared.getJSONDataFrom(url: Constants.baseURL + Constants.gameList, queryItems: queryItems) { jsonData in
            let games = NetworkManager.shared.getGameList(data: jsonData)
            for game in games {
                self.games.append(GameContent(id: game.id,
                                              title: game.name,
                                              releasedDate: game.released,
                                              rating: game.rating,
                                              poster: URL(string: game.imageURL)!,
                                              ratingCount: game.ratingCount))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.13, alpha: 1.00)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.height() - (view.height() - 100)))
        ])
        
        isLoaded = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
        self.parent?.title = "Game List"
        
        if isMoveToNextVC {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.height() - (view.height() - 100)))
            ])
            isMoveToNextVC = false
            return
        }
        
        if isLoaded {
            guard let navBarHeight = self.navigationController?.navigationBar.frame.maxY else {
                return
            }
            
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.height() - (view.height() - 100)) - navBarHeight)
            ])
        }
        isLoaded = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    fileprivate func startOperations(movie: GameContent, indexPath: IndexPath) {
        if movie.state == .new {
            startDownload(game: movie, indexPath: indexPath)
        }
    }
    
    fileprivate func startDownload(game: GameContent, indexPath: IndexPath) {
        guard pendingOperations.downloadInProgress[indexPath] == nil else {
            return
        }
        
        let downloader = ImageDownloader(game: game)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func toggleSuspendOperations(isSuspended: Bool) {
        pendingOperations.downloadQueue.isSuspended = isSuspended
    }
    
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if games.count > 0 {
            return games.count
        } else {
            return 10
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath) as? GameListCell else {
            fatalError()
        }
        
        if games.count < 1 {
            cell.showAnimation()
            cell.gameNameLbl.text = ""
            cell.releasedDateLbl.text = ""
            cell.ratingLbl.text = ""
            cell.isUserInteractionEnabled = false
            
            return cell
        } else {
            let game = games[indexPath.row]
            cell.gameNameLbl.text = game.title
            cell.releasedDateLbl.text = game.releasedDate
            cell.ratingLbl.text = "\(String(game.rating))/5.0(\(game.ratingCount))"
            cell.gameImage.image = game.image
            
            if game.state == .new {
                cell.showAnimation()
                cell.gameNameLbl.text = ""
                cell.releasedDateLbl.text = ""
                cell.ratingLbl.text = ""
                cell.isUserInteractionEnabled = false
                
                if !tableView.isTracking || !tableView.isDecelerating {
                    startOperations(movie: game, indexPath: indexPath)
                }
            } else {
                cell.isUserInteractionEnabled = true
                cell.hideAnimation()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GameDetailViewController(gameInfo: GameList(id: games[indexPath.row].id,
                                                             name: games[indexPath.row].title,
                                                             rating: games[indexPath.row].rating,
                                                             released: games[indexPath.row].releasedDate,
                                                             imageURL: "null",
                                                             ratingCount: games[indexPath.row].ratingCount))
        vc.posterImageView.image = games[indexPath.row].image
        vc.gameTitleLbl.text = games[indexPath.row].title
        vc.gameID = games[indexPath.row].id
        vc.ratingCount = games[indexPath.row].ratingCount
        isMoveToNextVC = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: false)
    }


}
