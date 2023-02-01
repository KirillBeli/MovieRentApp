//
//  URLData.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 30.01.2023.
//

import Foundation

struct BannerData: Codable {
    var banner: [Banner]
    }
struct Banner: Codable  {
        var isImage: String
        var imageUrl: String
        var videoUrl: String
    }

struct MoviesData: Codable {
    var movies: [Movies]
}
struct Movies: Codable {
    var id: Int
    var name: String
    var year: String
    var category: String
}


