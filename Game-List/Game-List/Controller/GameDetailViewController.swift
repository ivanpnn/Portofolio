//
//  GameDetailViewController.swift
//  Game-List
//
//  Created by MacBook Noob on 23/08/21.
//

import UIKit

class GameDetailViewController: UIViewController {
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var gameTitleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Bold", size: 24)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var gameRatingLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Bold", size: 24)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var gamePlatformsTitle: UILabel = {
        let label = UILabel()
        label.text = "Platforms:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var gamePlatformsContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var gameGenreTitle: UILabel = {
        let label = UILabel()
        label.text = "Genre:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var gameGenreContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var releasedDateTitle: UILabel = {
        let label = UILabel()
        label.text = "Release Date:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var releasedDateContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var developersTitle: UILabel = {
        let label = UILabel()
        label.text = "Developers:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var developersContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var publishersTitle: UILabel = {
        let label = UILabel()
        label.text = "Publishers:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var publishersContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var ageRatingTitle: UILabel = {
        let label = UILabel()
        label.text = "Age Rating:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var ageRatingContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var gameDescTitle: UILabel = {
        let label = UILabel()
        label.text = "About:"
        label.font = UIFont(name: "Futura Bold", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    var gameDescContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "Gill Sans", size: 24)
        button.setTitle("Add Game to Favorite", for: .normal)
        button.layer.cornerRadius = 10
        button.tag = 1
        button.addTarget(self, action: #selector(didTapFavoriteBtn), for: .touchUpInside)
        return button
    }()
    
    var scrollView = UIScrollView()
    var indicator = UIActivityIndicatorView()
    
    var gameID = Int()
    var ratingCount = Int()
    let gameInfo: GameList
        
    var favGame = FavGameModel(id: Int(),
                                  name: String(),
                                  rating: String(),
                                  releasedDate: String(),
                                  ratingCount: Int(),
                                  gameDescription: String(),
                                  parentPlatform: String(),
                                  genres: String(),
                                  developers: String(),
                                  publishers: String(),
                                  esrbRating: String(),
                                  image: Data())
    
    init(gameInfo: GameList) {
        self.gameInfo = gameInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.13, alpha: 1.00)
        title = "Game Information"
        
        view.addSubview(posterImageView)
        view.addSubview(gameTitleLbl)
        view.addSubview(gameRatingLbl)
        view.addSubview(scrollView)
        
        indicator.style = .large
        indicator.color = .white
        indicator.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.05)
        indicator.startAnimating()
        
        scrollView.addSubview(indicator)
        scrollView.addSubview(gamePlatformsTitle)
        scrollView.addSubview(gamePlatformsContent)
        scrollView.addSubview(gameGenreTitle)
        scrollView.addSubview(gameGenreContent)
        scrollView.addSubview(releasedDateTitle)
        scrollView.addSubview(releasedDateContent)
        scrollView.addSubview(developersTitle)
        scrollView.addSubview(developersContent)
        scrollView.addSubview(publishersTitle)
        scrollView.addSubview(publishersContent)
        scrollView.addSubview(ageRatingTitle)
        scrollView.addSubview(ageRatingContent)
        scrollView.addSubview(gameDescTitle)
        scrollView.addSubview(gameDescContent)
        scrollView.addSubview(favoriteButton)
        
        gameRatingLbl.text = "\(gameInfo.rating)/5.0"
        releasedDateContent.text = "\(gameInfo.released)"
        
        let queryItems = [
            URLQueryItem(name: "key", value: Constants.key),
        ]
        
        DatabaseManager.shared.isFavorite(gameID) { isFavorite, favoriteGame in
            if isFavorite && favoriteGame != nil {
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.gameDescContent.text = favoriteGame?.gameDescription
                    self.gamePlatformsContent.text = favoriteGame?.parentPlatform
                    self.gameGenreContent.text = favoriteGame?.genres
                    self.developersContent.text = favoriteGame?.developers
                    self.publishersContent.text = favoriteGame?.publishers
                    self.ageRatingContent.text =  favoriteGame?.esrbRating
                    
                    self.favoriteButton.setTitle("Delete Game from Favorite", for: .normal)
                    self.favoriteButton.backgroundColor = .red
                    self.favoriteButton.tag = 2
                    
                    self.getGameData()
                    self.setupView()
                }
                print("Data has been included in favorite list")
            } else {
                print("No data in favorite list")
                NetworkManager.shared.getJSONDataFrom(url: Constants.baseURL + Constants.gameDesc + String(self.gameID), queryItems: queryItems) { data in
                    let gameDetails = NetworkManager.shared.getGameDescription(data: data)
                    print("Description = \(gameDetails.description)")
                    print("Parent Platforms = \(gameDetails.parentPlatform)")
                    print("Genres = \(gameDetails.genres)")
                    print("Developers = \(gameDetails.developers)")
                    print("ESRB rating = \(gameDetails.esrbRating)")

                    var platforms = String()
                    var genres = String()
                    var developers = String()
                    var publishers = String()

                    for platform in gameDetails.parentPlatform {
                        if platforms == "" {
                            platforms += platform
                        } else {
                            platforms += ", \(platform)"
                        }
                    }

                    for genre in gameDetails.genres {
                        if genres == "" {
                            genres += genre
                        } else {
                            genres += ", \(genre)"
                        }
                    }

                    for developer in gameDetails.developers {
                        if developers == "" {
                            developers += developer
                        } else {
                            developers += ", \(developer)"
                        }
                    }

                    for publisher in gameDetails.publishers {
                        if publishers == "" {
                            publishers += publisher
                        } else {
                            publishers += ", \(publisher)"
                        }
                    }

                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.gameDescContent.text = gameDetails.description
                        self.gamePlatformsContent.text = platforms
                        self.gameGenreContent.text = genres
                        self.developersContent.text = developers
                        self.publishersContent.text = publishers
                        self.ageRatingContent.text =  gameDetails.esrbRating
                        
                        self.getGameData()
                        self.setupView()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var imageWidth: CGFloat = 0
        var imageHeight: CGFloat = 0
        var imageAspectRatio: CGFloat = 0
                
        if posterImageView.image != nil {
            imageWidth = posterImageView.image!.size.width
            imageHeight = posterImageView.image!.size.height
            imageAspectRatio = imageWidth / imageHeight
        }
        
        posterImageView.frame = CGRect(x: 5,
                                       y: view.safeAreaInsets.top + 5,
                                       width: view.width() - 10,
                                       height: (view.width() - 10) / imageAspectRatio)
        
        gameTitleLbl.frame = CGRect(x: 5,
                                    y: posterImageView.bottom() + 5,
                                    width: view.width() / 2,
                                    height: gameTitleLbl.labelFontSize().height)
        gameTitleLbl.sizeToFit()
        
        gameRatingLbl.frame = CGRect(x: posterImageView.width() - gameRatingLbl.labelFontSize().width + 5,
                                     y: posterImageView.bottom() + 5,
                                     width: gameRatingLbl.labelFontSize().width,
                                     height: gameRatingLbl.labelFontSize().height)
                
        scrollView.frame = CGRect(x: 5,
                                  y: gameTitleLbl.bottom() + 5,
                                  width: view.width() - 5,
                                  height: view.height() - gameTitleLbl.bottom())
        
        indicator.frame = CGRect(x: 0,
                                 y: 0,
                                 width: scrollView.width(),
                                 height: scrollView.height())

    }
    
    private func getGameData() {
        if let image = self.posterImageView.image, let data = image.pngData() as NSData? {
            self.favGame = FavGameModel(id: self.gameID,
                                        name: self.gameTitleLbl.text!,
                                        rating: self.gameRatingLbl.text!,
                                        releasedDate: self.releasedDateContent.text!,
                                        ratingCount: self.ratingCount,
                                        gameDescription: self.gameDescContent.text!,
                                        parentPlatform: self.gamePlatformsContent.text!,
                                        genres: self.gameGenreContent.text!,
                                        developers: self.developersContent.text!,
                                        publishers: self.publishersContent.text!,
                                        esrbRating: self.ageRatingContent.text!,
                                        image: data as Data)
        } else {
            print("Cannot save image")
        }
    }
    
    private func setupView() {
        self.gamePlatformsTitle.frame = CGRect(x: 5,
                                               y: 0,
                                               width: self.gamePlatformsTitle.labelFontSize().width,
                                               height: self.gamePlatformsTitle.labelFontSize().height)
        
        self.gameGenreTitle.frame = CGRect(x: self.scrollView.width() / 2,
                                           y: 0,
                                           width: self.gameGenreTitle.labelFontSize().width,
                                           height: self.gameGenreTitle.labelFontSize().height)
        
        self.gamePlatformsContent.frame = CGRect(x: 10,
                                          y: self.gamePlatformsTitle.bottom() + 1,
                                          width: self.scrollView.width() / 2 - 30,
                                          height: self.gamePlatformsContent.labelFontSize().height)
        self.gamePlatformsContent.sizeToFit()

        self.gameGenreContent.frame = CGRect(x: self.gameGenreTitle.left() + 10,
                                             y: self.gameGenreTitle.bottom() + 1,
                                             width: self.scrollView.width() / 2 - 30,
                                             height: self.gameGenreContent.labelFontSize().height)
        self.gameGenreContent.sizeToFit()

        self.releasedDateTitle.frame = CGRect(x: 5,
                                              y: max(self.gamePlatformsContent.bottom(), self.gameGenreContent.bottom()) + 5,
                                              width: self.releasedDateTitle.labelFontSize().width,
                                              height: self.releasedDateTitle.labelFontSize().height)
        self.releasedDateContent.frame = CGRect(x: 10,
                                                y: self.releasedDateTitle.bottom() + 1,
                                                width: self.releasedDateContent.labelFontSize().width,
                                                height: self.releasedDateContent.labelFontSize().height)

        self.developersTitle.frame = CGRect(x: self.gameGenreTitle.left(),
                                            y: self.releasedDateTitle.top(),
                                            width: self.developersTitle.labelFontSize().width,
                                            height: self.developersTitle.labelFontSize().height)
        self.developersContent.frame = CGRect(x: self.developersTitle.left() + 10,
                                              y: self.developersTitle.bottom() + 1,
                                              width: self.scrollView.width() / 2 - 30,
                                              height: self.developersContent.labelFontSize().height)
        self.developersContent.sizeToFit()

        self.publishersTitle.frame = CGRect(x: 5,
                                            y: self.developersContent.bottom() + 5,
                                            width: self.publishersTitle.labelFontSize().width,
                                            height: self.publishersTitle.labelFontSize().height)
        self.publishersContent.frame = CGRect(x: 10,
                                              y: self.publishersTitle.bottom() + 1,
                                              width: self.scrollView.width() / 2 - 30,
                                              height: self.publishersContent.labelFontSize().height)
        self.publishersContent.sizeToFit()

        self.ageRatingTitle.frame = CGRect(x: self.gameGenreTitle.left(),
                                           y: self.publishersTitle.top(),
                                           width: self.ageRatingTitle.labelFontSize().width,
                                           height: self.ageRatingTitle.labelFontSize().height)
        self.ageRatingContent.frame = CGRect(x: self.ageRatingTitle.left() + 10,
                                             y: self.ageRatingTitle.bottom() + 1,
                                             width: self.scrollView.width() / 2 - 30,
                                             height: self.ageRatingContent.labelFontSize().height)
        self.ageRatingContent.sizeToFit()

        self.gameDescTitle.frame = CGRect(x: 5,
                                          y: self.publishersContent.bottom() + 5,
                                          width: self.gameDescTitle.labelFontSize().width,
                                          height: self.gameDescTitle.labelFontSize().height)
        self.gameDescContent.frame = CGRect(x: 10,
                                        y: self.gameDescTitle.bottom() + 1,
                                        width: self.scrollView.width() - 20,
                                        height: self.gameDescContent.labelFontSize().height)
        self.gameDescContent.sizeToFit()
        
        self.favoriteButton.frame = CGRect(x: 10,
                                           y: self.gameDescContent.bottom() + 5,
                                           width: self.scrollView.width() - 20,
                                           height: 50)

        let contentSize = self.favoriteButton.bottom() + 5

        self.scrollView.contentSize = CGSize(width: self.view.frame.width - 5,
                                             height: contentSize)
    }
    
    @objc private func didTapFavoriteBtn(sender: UIButton) {
        if sender.tag == 1 {
            DatabaseManager.shared.addFavGame(favGame.id,
                                              favGame.name,
                                              favGame.rating,
                                              favGame.releasedDate,
                                              favGame.ratingCount,
                                              favGame.gameDescription,
                                              favGame.parentPlatform,
                                              favGame.genres,
                                              favGame.developers,
                                              favGame.publishers,
                                              favGame.esrbRating,
                                              favGame.image) {
                DispatchQueue.main.async {
                    self.favoriteButton.setTitle("Delete Game from Favorite", for: .normal)
                    self.favoriteButton.backgroundColor = .red
                    self.favoriteButton.tag = 2
                }
                print("Succesfully added to favorite")
            }
        } else if sender.tag == 2 {
            DatabaseManager.shared.deleteGame(gameID) {
                DispatchQueue.main.async {
                    self.favoriteButton.setTitle("Add Game to Favorite", for: .normal)
                    self.favoriteButton.backgroundColor = .systemGreen
                    self.favoriteButton.tag = 1
                }
                print("Succesfully Delete from favorite")
            }
        }

    }

}
