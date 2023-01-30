//
//  AdvertisingVC.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import Foundation
import UIKit

class AdvertisingVC: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    @IBOutlet weak var imageUpload: UIImageView!
    
    let url = "https://x-mode.co.il/exam/allMovies/bannerImage.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadImage(urlString: url)
    }
    
    func downloadImage(urlString: String) {
        guard let url = URL(string: url) else {
            print("error in url")
            return }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        URLSession.shared.downloadTask(with: url).resume()
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else {
            print("we didn't get the data")
            return
        }
        let image = UIImage(data: data)
        imageUpload.image = image
        
        
    }
    
}


    


