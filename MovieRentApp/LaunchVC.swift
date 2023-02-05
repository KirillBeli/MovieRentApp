//
//  ViewController.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import UIKit

class LaunchVC: UIViewController {
    
    var urlModel = URLModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadFomURL1(url: urlModel.url1!) { jsonRes1 in
            print(jsonRes1.banner[1].imageUrl!)
        }
        uploadFomURL2(url: urlModel.url2!) { jsonRes2 in
            print(jsonRes2.movies)
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
//                    print("imageUrl is: \(imageUrl)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.goToNextPage()
                    }
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
//                    let id = jsonRes2.movies[0].id
//                    let name = jsonRes2.movies[0].name
//                    let year = jsonRes2.movies[0].year
//                    let categoty = jsonRes2.movies[0].category
                    self.decoder.outputFormatting = .prettyPrinted
                    completion(jsonRes2)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.goToNextPage()
                    }
                } catch {
                    print("parse error \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func goToNextPage() {
        let advertisingVC = storyboard?.instantiateViewController (withIdentifier: "AdvertisingVC") as! AdvertisingVC
        present (advertisingVC, animated: true)
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
