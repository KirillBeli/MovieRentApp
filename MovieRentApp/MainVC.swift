//
//  MainVC.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource {
    
    var launchVC = LaunchVC()
    var urlModel = URLModel()
    var bannerData = BannerData(banner: [Banner(isImage: String(), imageUrl: String(), videoUrl: String())])
    var moviesData = MoviesData(movies: [Movies(id: String(), name: String(), year: String(), category: String())])
    init?(launchVC: LaunchVC = LaunchVC(), urlModel: URLModel = URLModel(), bannerData: BannerData = BannerData(banner: [Banner(isImage: String(), imageUrl: String(), videoUrl: String())]), moviesData: MoviesData = MoviesData(movies: [Movies(id: String(), name: String(), year: String(), category: String())])) {
        super.init(coder: NSCoder())
        self.launchVC = launchVC
        self.urlModel = urlModel
        self.bannerData = bannerData
        self.moviesData = moviesData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchVC.uploadFomURL2(url: urlModel.url2!) { jsonRes2 in
            self.moviesData = jsonRes2
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = moviesData.movies[indexPath.row].name
        return cell!
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
