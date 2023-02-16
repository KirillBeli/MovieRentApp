//
//  MainVC.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var launchVC = LaunchVC()
    var urlModel = URLModel()
    var bannerData = BannerData(banner: [Banner(isImage: String(), imageUrl: String(), videoUrl: String())])
    var moviesData = MoviesData(movies: [Movies(id: String(), name: String(), year: String(), category: String())])
    var detailsData = DetailsData(id: String(), name: String(), year: String(), category: String(), description: String(), imageURL: String(), promoURL: String(), rate: String(), hour: String())
    let decoder = JSONEncoder()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        launchVC.uploadFomURL2(url: urlModel.url2!) { jsonRes2 in
            self.moviesData = jsonRes2
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Number Of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.movies.count
    }
    //MARK: - Cell for Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = moviesData.movies[indexPath.row].name
        cell?.detailTextLabel?.text = moviesData.movies[indexPath.row].id
        return cell!
    }
   
    var urlDetailsString: String = ""
    //MARK: - Did select row at
   @IBAction func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        urlDetails = tableView.didselec
        let urlDeatilsId = "\(moviesData.movies[indexPath.row].id).txt"
        urlDetailsString = "\(urlModel.urlDetailsBase)\(urlDeatilsId)"

        print("urlDetailsString:\(urlDetailsString)")
        
    }
    
    //MARK: - URLSession from URLDetails
    func uploadFomURLDetails(url: URL, completion: @escaping (DetailsData) -> Void) {
        let session = URLSession.shared
        let urlDetails = URL(string: "\(urlDetailsString)")
        let dataTask = session.dataTask(with: urlDetails!) { jsonData, response, error in
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
   
   @IBAction override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        let urlDetails = URL(string: "\(urlDetailsString)")
//       let detailsVC: DetailsVC = DetailsVC(nibName: nil, bundle: nil)
//        uploadFomURLDetails(url: urlDetails!) { jsonResDetails in
//            self.detailsData = jsonResDetails
//            detailsVC.detailsData = self.detailsData
//            print(self.detailsData)
//        }
    }
}

