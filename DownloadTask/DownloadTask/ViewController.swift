//
//  ViewController.swift
//  DownloadTask
//
//  Created by MacBook Noob on 08/08/21.
//

import UIKit
 
class ViewController: UIViewController {
    
    let progressView: UIProgressView = {
        let v = UIProgressView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    let messageView: UILabel = {
        let v = UILabel()
        
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    lazy var btnDownload: UIButton = {
        let v = UIButton(type: .roundedRect)
        
        v.setTitle("Download", for: .normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(progressView)
        view.addSubview(messageView)
        view.addSubview(btnDownload)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 200),
            progressView.heightAnchor.constraint(equalToConstant: 20),
            
            messageView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            btnDownload.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 20),
            btnDownload.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let _ = DownloadManager.shared.session
        DownloadManager.shared.progress = { (totalBytesWritten, totalBytesExpectedToWrite) in
            let totalMB = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .binary)
            let writtenMB = ByteCountFormatter.string(fromByteCount: totalBytesWritten, countStyle: .binary)
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            
            DispatchQueue.main.async {
                self.btnDownload.isEnabled = false
                self.progressView.progress = progress
                self.messageView.text = "Downloading \(writtenMB) of \(totalMB)"
            }
        }
        
        DownloadManager.shared.completed = { (location) in
            print("Download Finished")
            
            try? FileManager.default.removeItem(at: location)
            
            DispatchQueue.main.async {
                self.btnDownload.isEnabled = true
            }
        }
        
        DownloadManager.shared.downloadError = { (task, error) in
            print("Task Completed: \(task), error: \(error)")
        }
    }
    
    @objc private func downloadFile() {
        let url = URL(string: "http://212.183.159.230/50MB.zip")
        
        let task = DownloadManager.shared.session.downloadTask(with: url!)
        
        task.resume()
    }
}

