//
//  DetailsVC.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 12.02.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var trailerURLLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var mainVC = MainVC()
    var detailsData = DetailsData(id: String(), name: String(), year: String(), category: String(), description: String(), imageURL: String(), promoURL: String(), rate: String(), hour: String())
    var urlDetails: String?
    let decoder = JSONEncoder()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        uploadFomURLDetails(url: urlDetails!) { jsonResDetails in
//            self.detailsData = jsonResDetails
//            print(jsonResDetails)
//            print(self.detailsData)
//            print(self.mainVC.urlDetails!)
//        }
//        print(urlDetails)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(mainVC.urlDetailsNew)
        nameLabel.text = "\(detailsData.name)"
        yearLabel.text = "Year: \(detailsData.year)"
        categoryLabel.text = "Category: \(detailsData.category)"
        rateLabel.text = "Rate: \(detailsData.rate)"
        trailerURLLabel.text = detailsData.promoURL
        descriptionLabel.text = detailsData.description
        
    }
    
    //MARK: - URLSession from URLDetails
//    func uploadFomURLDetails(url: URL, completion: @escaping (DetailsData) -> Void) {
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: urlDetails!) { jsonData, response, error in
//            if jsonData != nil && error == nil {
//                do {
//                    let jsonResDetails = try JSONDecoder().decode(DetailsData.self, from: jsonData!)
//                    self.decoder.outputFormatting = .prettyPrinted
//                    completion(jsonResDetails)
//                    print(jsonResDetails)
//                } catch {
//                    print("parse error \(error)")
//                }
//            }
//        }.resume()
//    }
    

}
