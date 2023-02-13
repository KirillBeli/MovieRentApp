//
//  AdvertisingVC.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import Foundation
import UIKit

class AdvertisingVC: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var imageUpload: UIImageView!

    let url = "https://x-mode.co.il/exam/allMovies/bannerImage.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerForNextPage()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadImage(urlString: url)
    }
    //MARK: - func of dowload
    func downloadImage(urlString: String) {
        guard let url = URL(string: url) else {
            print("error in url")
            return }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.downloadTask(with: url).resume()
        imageUpload.backgroundColor = UIColor.black
    }
    
    func timerForNextPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){
            self.goToNextPage()
        }
    }
    //MARK: - Segue to next view
    func goToNextPage() {
        performSegue(withIdentifier: "MainVC", sender: nil)
//        let MainVC = storyboard?.instantiateViewController (withIdentifier: "MainVC") as! MainVC
//        present (MainVC, animated: true)
    }
}
//MARK: - Download URLSession of image
extension AdvertisingVC: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else {
            print("we didn't get the data")
            return
        }
        let image = UIImage(data: data)
        imageUpload.image = image
    }
}

