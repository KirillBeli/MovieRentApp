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
        
        RequestManager.shared.uploadFomURL2(url: urlModel.url2!) { jsonRes2 in
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
   
    //MARK: - Did select row at
    @IBAction func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlDeatilsId = "\(moviesData.movies[indexPath.row].id).txt"
        let urlDetailsString = "\(urlModel.urlDetailsBase)\(urlDeatilsId)"
        let urlDetails = URL(string: "\(urlDetailsString)")
        RequestManager.shared.uploadFomURLDetails(url: urlDetails!) { jsonResDetails in
            DispatchQueue.main.async {
                let detailsData = jsonResDetails
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC")
                if let detailsVC = vc as? DetailsVC {
                    detailsVC.detailsData = detailsData
                    self.navigationController?.pushViewController(detailsVC , animated: true)
                }
            }
        }
    }
   
}

