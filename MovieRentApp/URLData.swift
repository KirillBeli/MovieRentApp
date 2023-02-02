//
//  URLData.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 30.01.2023.
//

import Foundation

struct BannerData: Decodable {
    var banner: [Banner]
    }

struct Banner: Decodable  {
        var isImage: Bool
        var imageUrl: String
        var videoUrl: String
    }

struct MoviesData: Decodable {
    let movies: [Movies]
}
struct Movies: Decodable {
    let id, name, year, category: String
}


