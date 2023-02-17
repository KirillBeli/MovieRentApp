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
    
    var urlModel = URLModel()
    var launchVC = LaunchVC()
    var bannerData = BannerData(banner: [Banner(isImage: String(), imageUrl: String(), videoUrl: String())])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUpload.backgroundColor = UIColor.black
        timerForNextPage()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestManager.shared.uploadFomURL1(url: urlModel.url1!) { jsonRes1 in
            self.bannerData = jsonRes1
            var imageUrl = jsonRes1.banner[1].imageUrl!
            if !imageUrl.contains("https") {
                imageUrl = imageUrl.replacingOccurrences(of: "http", with: "https")
            }
            imageUrl = imageUrl.replacingOccurrences(of: ".jpg.jpg", with: ".jpg")
            let url = URL(string: "\(imageUrl)")
            self.downloadImage(url: url!)
        }
    }
    
    //MARK: - Download Session
    func downloadImage(url: URL) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.downloadTask(with: url).resume()
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

