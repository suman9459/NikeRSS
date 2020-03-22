//
//  FeedModel.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

struct FeedModel: Decodable {
    let feed: feed?
}

struct feed: Decodable {
    let results: [results]?
}

struct results: Decodable {
    let artistName: String?
    let name: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let copyright: String?
    let url: String?
    let artistUrl: String?
    let genres: [genres]?
}
struct genres: Decodable {
    let genreId: String?
    let name: String?
}
