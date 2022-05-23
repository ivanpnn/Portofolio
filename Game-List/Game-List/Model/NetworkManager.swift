//
//  NetworkManager.swift
//  Game-List
//
//  Created by MacBook Noob on 14/08/21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func getJSONDataFrom(url: String, queryItems: [URLQueryItem], completion: @escaping (Data) -> ()) {
        
        print("URL = \(url)")
        var components = URLComponents(string: url)!

        components.queryItems = queryItems

        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            
            if let data = data {
                if response.statusCode == 200 {
                    print("DATA: \(data)")
                    completion(data)
                } else {
                    print("ERROR: \(data), Http Status: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func getGameList(data: Data) -> [GameList] {
        let decoder = JSONDecoder()
        var gameList = [GameList]()
        
        do {
            let games = try decoder.decode(Games.self, from: data)
            
            for i in 0..<games.results.count {
                gameList.append(GameList(id: games.results[i].id,
                                         name: games.results[i].name,
                                         rating: games.results[i].rating,
                                         released: games.results[i].released,
                                         imageURL: games.results[i].background_image,
                                         ratingCount: games.results[i].ratings_count))
            }

        } catch DecodingError.keyNotFound(let key, let context) {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            print("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
        
        return gameList
    }
    
    func getGameDescription(data: Data) -> DetailOfGame {
        let decoder = JSONDecoder()
        var gameDetails: DetailOfGame?
        
        do {
            let gameDetail = try decoder.decode(GameDetail.self, from: data)
            
            var platforms = [String]()
            for parentPlatform in gameDetail.parent_platforms {
                platforms.append(parentPlatform.platform.name)
            }
            
            var genres = [String]()
            for genre in gameDetail.genres {
                genres.append(genre.name)
            }
            
            var developers = [String]()
            for developer in gameDetail.developers {
                developers.append(developer.name)
            }
            
            var publishers = [String]()
            for publisher in gameDetail.publishers {
                publishers.append(publisher.name)
            }
            
            gameDetails = DetailOfGame(description: gameDetail.description_raw,
                                       parentPlatform: platforms,
                                       genres: genres,
                                       developers: developers,
                                       publishers: publishers,
                                       esrbRating: gameDetail.esrb_rating.name)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            print("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
        
        guard let gameDetail = gameDetails else {
            return DetailOfGame(description: "Error Getting Data", parentPlatform: ["-"], genres: ["-"], developers: ["-"], publishers: ["-"], esrbRating: "-")
        }
        
        return gameDetail
    }
}
