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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadFomURL1(url: urlModel.url1!) { jsonRes1 in
            self.bannerData = jsonRes1
         }
        uploadFomURL2(url: urlModel.url2!) { jsonRes2 in
            self.moviesData = jsonRes2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.goToNextPage()
        }
    }
    
    
    
    let decoder = JSONEncoder()
    
    func uploadFomURL1(url: URL, completion: @escaping (BannerData) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlModel.url1!) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonRes1 = try JSONDecoder().decode(BannerData.self, from: jsonData!)
                    self.decoder.outputFormatting = .prettyPrinted
                    let imageUrl = jsonRes1.banner[1].imageUrl!
                    completion(jsonRes1)
                } catch {
                    print("parse error \(error)")
                }
            }
        }.resume()
    }
//    func uploadFomURL1(from url: URL) {
//        let session = URLSession.shared.dataTask(with: urlModel.url1!) { jsonData, response, error in
//            if let error = error {
//                print("There was an error from url1: \(error.localizedDescription)")
//                return
//            } else {
//                let jsonRes1 = try? JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String:Any]
//                var goodJson: [String:Any] = [:]
//                let banner = jsonRes1?["banner"] as? [[String:Any]]
//                for json in banner ?? [] {
//                    for (key, value) in json {
//                        goodJson[key] = value
//                    }
//                }
//                print("goodJson1 \(goodJson)")
//                //self.decoder.outputFormatting = .prettyPrinted
//                //   print(jsonRes1)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                    self.goToNextPage()
//                }
//            }
//
//        }.resume()
//    }
    
    
    func uploadFomURL2(url: URL, completion: @escaping (MoviesData) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlModel.url2!) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonRes2 = try JSONDecoder().decode(MoviesData.self, from: jsonData!)
                    self.decoder.outputFormatting = .prettyPrinted
                    completion(jsonRes2)
                } catch {
                    print("parse error \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func goToNextPage() {
        performSegue(withIdentifier: "AdvertisingVC", sender: nil)
    }
}


//    func uploadFomURL2(from url: URL) {
//        let session = URLSession.shared.dataTask(with: urlModel.url2!) { data, response, error in
//            if let error = error {
//                print("There was an error from url2: \(error.localizedDescription)")
//            } else {
//                let jsonRes2 = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
////                var goodJson: [String:Any] = [:]
////                let movies = jsonRes2?["movies"] as? [[String:Any]]
////                for json in movies ?? [] {
////                    for (key, value) in json {
////                        goodJson[key] = value
////                    }
////                }
////                print("goodJson2 \(goodJson)")
//                print("the resulte of url2: \(String(describing: jsonRes2))")
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                self.goToNextPage()
//            }
//        }.resume()
//    }
