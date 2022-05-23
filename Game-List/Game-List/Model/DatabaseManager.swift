//
//  DatabaseManager.swift
//  Game-List
//
//  Created by MacBook Noob on 11/09/21.
//

import CoreData
import UIKit

class DatabaseManager {
    static let shared = DatabaseManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Game")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func addFavGame(_ id: Int,
                    _ name: String,
                    _ rating: String,
                    _ releasedDate: String,
                    _ ratingCount: Int,
                    _ gameDescription: String,
                    _ parentPlatform: String,
                    _ genres: String,
                    _ developers: String,
                    _ publishers: String,
                    _ esrbRating: String,
                    _ image: Data,
                    completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "GamesList", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(id, forKey: "id")
                game.setValue(name, forKey: "name")
                game.setValue(rating, forKey: "rating")
                game.setValue(releasedDate, forKey: "releasedDate")
                game.setValue(ratingCount, forKey: "ratingCount")
                game.setValue(gameDescription, forKey: "gameDescription")
                game.setValue(parentPlatform, forKey: "parentPlatform")
                game.setValue(genres, forKey: "genres")
                game.setValue(developers, forKey: "developers")
                game.setValue(publishers, forKey: "publishers")
                game.setValue(esrbRating, forKey: "esrbRating")
                game.setValue(image, forKey: "image")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func getAllFavGame(completion: @escaping(_ members: [FavGameModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamesList")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var game: [FavGameModel] = []
                for result in results {
                    game.append(FavGameModel(id: result.value(forKeyPath: "id") as! Int,
                                             name: result.value(forKeyPath: "name") as! String,
                                             rating: result.value(forKeyPath: "rating") as! String,
                                             releasedDate: result.value(forKeyPath: "releasedDate") as! String,
                                             ratingCount: result.value(forKeyPath: "ratingCount") as! Int,
                                             gameDescription: result.value(forKeyPath: "gameDescription") as! String,
                                             parentPlatform: result.value(forKeyPath: "parentPlatform") as! String,
                                             genres: result.value(forKeyPath: "genres") as! String,
                                             developers: result.value(forKeyPath: "developers") as! String,
                                             publishers: result.value(forKeyPath: "publishers") as! String,
                                             esrbRating: result.value(forKeyPath: "esrbRating") as! String,
                                             image: result.value(forKeyPath: "image") as! Data))
                }
                completion(game)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func isFavorite(_ id: Int, completion: @escaping(_ isFavorite: Bool, _ favoriteGame: FavGameModel?) -> (Void)) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamesList")
            do {
                let results = try taskContext.fetch(fetchRequest)
                for result in results {
                    if id == result.value(forKeyPath: "id") as! Int {
                        let game = FavGameModel(id: result.value(forKeyPath: "id") as! Int,
                                                name: result.value(forKeyPath: "name") as! String,
                                                rating: result.value(forKeyPath: "rating") as! String,
                                                releasedDate: result.value(forKeyPath: "releasedDate") as! String,
                                                ratingCount: result.value(forKeyPath: "ratingCount") as! Int,
                                                gameDescription: result.value(forKeyPath: "gameDescription") as! String,
                                                parentPlatform: result.value(forKeyPath: "parentPlatform") as! String,
                                                genres: result.value(forKeyPath: "genres") as! String,
                                                developers: result.value(forKeyPath: "developers") as! String,
                                                publishers: result.value(forKeyPath: "publishers") as! String,
                                                esrbRating: result.value(forKeyPath: "esrbRating") as! String,
                                                image: result.value(forKeyPath: "image") as! Data)
                        completion(true, game)
                        return
                    }
                }
                completion(false, nil)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteGame(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamesList")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
}
