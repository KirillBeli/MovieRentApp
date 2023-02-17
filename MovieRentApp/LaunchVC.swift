//
//  ViewController.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import UIKit

class LaunchVC: UIViewController {
    
    var urlModel = URLModel()
    var bannerData = BannerData(banner: [Banner(isImage: String(), imageUrl: String(), videoUrl: String())])
    var moviesData = MoviesData(movies: [Movies(id: String(), name: String(), year: String(), category: String())])
    let decoder = JSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RequestManager.shared.uploadFomURL2(url: urlModel.url2!) { jsonRes2 in
            self.moviesData = jsonRes2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.goToNextPage()
        }
    }
    
    //MARK: - Segue to next view
    func goToNextPage() {
        performSegue(withIdentifier: "AdvertisingVC", sender: nil)
    }
}


