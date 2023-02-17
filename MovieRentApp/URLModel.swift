//
//  URLController.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 29.01.2023.
//

import Foundation

var mainVC = MainVC()

struct URLModel {
    var moviesData = MoviesData(movies: [Movies(id: String(), name: String(), year: String(), category: String())])
    var url1 = URL(string: "https://x-mode.co.il/exam/allMovies/generalDeclaration.txt")
    var url2 = URL(string: "https://x-mode.co.il/exam/allMovies/allMovies.txt#")
    var urlDetailsBase = "https://x-mode.co.il/exam/descriptionMovies/"
    
}




