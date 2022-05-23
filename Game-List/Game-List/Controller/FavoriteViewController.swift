//
//  FavoriteViewController.swift
//  Game-List
//
//  Created by MacBook Noob on 11/09/21.
//

import UIKit

class FavoriteViewController: UIViewController {
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
    
    var game = [FavGameModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.13, alpha: 1.00)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseManager.shared.getAllFavGame { results in
            DispatchQueue.main.async {
                self.game = results
                self.tableView.reloadData()
            }
        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
        self.parent?.title = "Favorites"
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath) as? GameListCell else {
            fatalError()
        }
        cell.hideAnimation()
        cell.gameNameLbl.text = game[indexPath.row].name
        cell.releasedDateLbl.text = game[indexPath.row].releasedDate
        cell.ratingLbl.text = "\(game[indexPath.row].rating)(\(game[indexPath.row].ratingCount))"
        cell.gameImage.image = UIImage(data: game[indexPath.row].image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let vc = GameDetailViewController(gameInfo: GameList(id: game[indexPath.row].id,
                                                             name: game[indexPath.row].name,
                                                             rating: (game[indexPath.row].rating as NSString).doubleValue,
                                                             released: game[indexPath.row].releasedDate,
                                                             imageURL: String(),
                                                             ratingCount: game[indexPath.row].ratingCount))
        vc.posterImageView.image = UIImage(data: game[indexPath.row].image)
        vc.gameTitleLbl.text = game[indexPath.row].name
        vc.gameID = game[indexPath.row].id
        vc.ratingCount = game[indexPath.row].ratingCount
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
