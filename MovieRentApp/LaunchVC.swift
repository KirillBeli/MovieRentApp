//
//  ViewController.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import UIKit

class LaunchVC: UIViewController {

    let urlModel = URLModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadFomURL1(from: urlModel.url1!)
        uploadFomURL2(from: urlModel.url2!)
    }
    
   
    func uploadFomURL1(from url: URL) {
        let session = URLSession.shared.dataTask(with: urlModel.url1!) { data, response, error in
            if let error = error {
                print("There was an error from url1: \(error.localizedDescription)")
                return
            } else {

                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response of url1: \(jsonRes)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.goToNextPage()
            }
        }.resume()
    }

    func uploadFomURL2(from url: URL) {
        let session = URLSession.shared.dataTask(with: urlModel.url2!) { data, response, error in
            if let error = error {
                print("There was an error from url2: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response of url2: \(jsonRes)")
//                self.parseJSON(movieData: jsonRes as! Data)
            }
            // Store the data on the device
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.goToNextPage()
            }
        }.resume()
    }


    func goToNextPage() {
        let advertisingVC = storyboard?.instantiateViewController (withIdentifier: "AdvertisingVC") as! AdvertisingVC
        present (advertisingVC, animated: true)
    }
}

