//
//  URLData.swift
//  MovieRentApp
//
//  Created by Kyrylo Bielykov on 30.01.2023.
//

import Foundation
extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
struct BannerData: Decodable {
    var banner: Banner
    }
struct Banner: Decodable  {
        var isImage: String
        var imageUrl: String
        var videoUrl: String
    }



