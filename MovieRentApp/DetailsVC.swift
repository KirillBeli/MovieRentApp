//
//  DetailsVC.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 12.02.2023.
//

import UIKit

class DetailsVC: UIViewController, URLSessionDelegate {
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var trailerURLLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var mainVC = MainVC()
    var detailsData = DetailsData(id: String(), name: String(), year: String(), category: String(), description: String(), imageURL: String(), promoURL: String(), rate: String(), hour: String())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var urlString: String = "\(detailsData.imageURL)"
            if !urlString.contains("https") {
                urlString = urlString.replacingOccurrences(of: "http", with: "https")
            }
        let url = URL(string: "\(urlString)")
        self.downloadImage(url: url!)
        nameLabel.text = "\(detailsData.name)"
        yearLabel.text = "Year: \(detailsData.year)"
        categoryLabel.text = "Category: \(detailsData.category)"
        rateLabel.text = "Rate: \(detailsData.rate)"
        trailerURLLabel.text = detailsData.promoURL
        descriptionLabel.text = detailsData.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Download Session
    func downloadImage(url: URL) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.downloadTask(with: url).resume()
    }

}

//MARK: - Download URLSession of image
extension DetailsVC: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else {
            print("we didn't get the data")
            return
        }
        let image = UIImage(data: data)
        movieImage.image = image
    }
}
