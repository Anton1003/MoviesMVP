//
//  Movie.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import Foundation
///

// MARK: - Film

///
struct Film: Codable {
    let id: Int
    let results: [Result]
}

// MARK: - Result

///
struct Result: Codable {
    let backdropPath: String
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
