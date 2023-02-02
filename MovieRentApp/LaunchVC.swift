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
        uploadFomURL1(from: urlModel.url1!)
        uploadFomURL2(url: urlModel.url2!) { praseData in
            print("succses")
        }
    }
    
    let decoder = JSONEncoder()
    
    func uploadFomURL1(from url: URL) {
        let session = URLSession.shared.dataTask(with: urlModel.url1!) { data, response, error in
            if let error = error {
                print("There was an error from url1: \(error.localizedDescription)")
                return
            } else {
                let jsonRes1 = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                var goodJson: [String:Any] = [:]
                let banner = jsonRes1?["banner"] as? [[String:Any]]
                for json in banner ?? [] {
                    for (key, value) in json {
                        goodJson[key] = value
                    }
                }
                print("goodJson1 \(goodJson)") //use goodJson
                
                //self.decoder.outputFormatting = .prettyPrinted
             //   print(jsonRes1)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.goToNextPage()
            }
        }.resume()
    }
    
    func uploadFomURL2(url: URL, completion: @escaping (MoviesData) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlModel.url2!) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonRes2 = try JSONDecoder().decode(MoviesData.self, from: jsonData!) //as? [String:Any]
                  //  completion[praseData]
                    self.decoder.outputFormatting = .prettyPrinted
                    print("This is URL2: \(jsonRes2)")
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
