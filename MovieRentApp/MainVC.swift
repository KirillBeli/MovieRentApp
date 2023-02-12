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
    
    var urlDetailsNew = URL(string: String())
    
    //MARK: - Did select row at
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let urlDeatilsId = "\(moviesData.movies[indexPath.row].id).txt"
        let urlDetails = URL(string: "\(urlModel.urlDetailsBase)\(urlDeatilsId)")
        urlDetailsNew = urlDetails
    }
    
    //MARK: - URLSession from URLDetails
    func uploadFomURLDetails(url: URL, completion: @escaping (DetailsData) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlDetailsNew!) { jsonData, response, error in
            if jsonData != nil && error == nil {
                do {
                    let jsonResDetails = try JSONDecoder().decode(DetailsData.self, from: jsonData!)
                    self.decoder.outputFormatting = .prettyPrinted
                    completion(jsonResDetails)
                    //print(jsonResDetails)
                } catch {
                    print("parse error \(error)")
                }
            }
        }.resume()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        uploadFomURLDetails(url: urlDetailsNew!) { jsonResDetails in
            self.detailsData = jsonResDetails
            //                        print(jsonResDetails)
            //                        print(self.detailsData)
            //                    print(self.urlDetailsNew!)
        }
    }
}

