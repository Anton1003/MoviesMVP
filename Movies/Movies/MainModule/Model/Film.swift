//
//  Movie.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import Foundation
import RealmSwift
///

// MARK: - Film

///
struct Film: Codable {
    let id: Int
    let results: [Movie]
}

// MARK: - Result

///
final class Movie: Object {
    @objc dynamic var id = 0
    @objc dynamic var overview = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var title = ""
    @objc dynamic var voteAverage = 0.0

    override class func primaryKey() -> String? {
        "title"
    }
}

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
