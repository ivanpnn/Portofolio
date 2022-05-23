//
//  NetworkManager.swift
//  Halodoc_Exercise
//
//  Created by MacBook Noob on 29/09/21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func getJSONDataFrom(url: String, queryItems: [URLQueryItem], completion: @escaping (Data) -> ()) {
        
        var components = URLComponents(string: url)!

        components.queryItems = queryItems

        let request = URLRequest(url: components.url!)
        print("URL = \(request)")

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
    
    func getNews(data: Data) -> [News] {
        let decoder = JSONDecoder()
        var newsList = [News]()
        
        do {
            let news = try decoder.decode(Datas.self, from: data)

            for i in 0..<news.hits.count {
                newsList.append(News(title: news.hits[i].title,
                                     newsURL: news.hits[i].url ?? "null"))
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
        
        return newsList
    }
}


