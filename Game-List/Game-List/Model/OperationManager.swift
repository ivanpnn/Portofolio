//
//  OperationManager.swift
//  Game-List
//
//  Created by MacBook Noob on 05/09/21.
//

import UIKit

class ImageDownloader: Operation {
    private let game: GameContent
 
    init(game: GameContent) {
        self.game = game
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: game.poster) else {
            return
        }
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            game.image = UIImage(data: imageData)
            game.state = .downloaded
        } else {
            game.image = nil
            game.state = .failed
        }
    }
}

class PendingOperations {
    lazy var downloadInProgress: [IndexPath: Operation] = [:]
    
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.ivan.imagedownloader"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
}

