//
//  RequestManager.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 16.02.2023.
//

import UIKit

class RequestManager {
    
    static let shared = RequestManager()
    private init() {
    }
    
    let decoder = JSONEncoder()
    
    //MARK: - URLSession BannerURL
    func uploadFomURL1(url: URL, completion: @escaping (BannerData) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonRes1 = try JSONDecoder().decode(BannerData.self, from: jsonData!)
                    self.decoder.outputFormatting = .prettyPrinted
//                    var imageUrl = jsonRes1.banner[1].imageUrl!
//                    if !imageUrl.contains("https") {
//                        imageUrl = imageUrl.replacingOccurrences(of: "http", with: "https")
//                    }
//                    imageUrl = imageUrl.replacingOccurrences(of: ".jpg.jpg", with: ".jpg")
                    completion(jsonRes1)
                } catch {
                    print("parse error \(error)")
                }
            }
        }.resume()
    }
    
   
    
    //MARK: - URLSession MoviesURL
    func uploadFomURL2(url: URL, completion: @escaping (MoviesData) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonRes2 = try JSONDecoder().decode(MoviesData.self, from: jsonData!)
                    self.decoder.outputFormatting = .prettyPrinted
                    completion(jsonRes2)
                } catch {
                    print("parse error \(error)")
                }
            }
        }.resume()
    }
    
    //MARK: - URLSession from URLDetails
    func uploadFomURLDetails(url: URL, completion: @escaping (DetailsData) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonResDetails = try JSONDecoder().decode(DetailsData.self, from: jsonData!)
                    self.decoder.outputFormatting = .prettyPrinted
                    completion(jsonResDetails)
                } catch {
                    print("parse error \(error)")
                }
            }
        }.resume()
    }
    
    
    
}
