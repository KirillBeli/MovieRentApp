//
//  ViewController.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import UIKit

class LaunchVC: UIViewController {

    let url1 = URL(string: "https://x-mode.co.il/exam/allMovies/generalDeclaration.txt")
    let url2 = URL(string: "https://x-mode.co.il/exam/allMovies/allMovies.txt#")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadFomURL1(from: url1!, on: UIViewController())
        uploadFomURL2(from: url2!, on: UIViewController())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    func goToNextPage() {
        let advertisingVC = storyboard?.instantiateViewController (withIdentifier: "AdvertisingVC") as! AdvertisingVC
        present (advertisingVC, animated: true)
    }
    func uploadFomURL1(from url: URL, on viewController: UIViewController) {
        let session = URLSession.shared.dataTask(with: url1!) { data, response, error in
            if let error = error {
                print("There was an error from url1: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response of url1: \(jsonRes)")
            }
            // Store the data on the device
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.goToNextPage()
            }
        }.resume()
    }
    
    func uploadFomURL2(from url: URL, on viewController: UIViewController) {
        let session = URLSession.shared.dataTask(with: url2!) { data, response, error in
            if let error = error {
                print("There was an error from url2: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response of url2: \(jsonRes)")
            }
            // Store the data on the device
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.goToNextPage()
            }
        }.resume()
    }


}

