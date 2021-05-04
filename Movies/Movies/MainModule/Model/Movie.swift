//
//  Movie.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import Foundation
///

// MARK: - LoaderModel

///
struct LoaderModel: Codable {
    let averageRating: Double
    let backdropPath: String
    let comments: [String: String?]
    let createdBy: CreatedBy
    let loaderModelDescription: String
    let id: Int
    let name: String
    let objectIDS: [String: String?]
    let page: Int
    let posterPath: String
    let loaderModelPublic: Bool
    let results: [Result]
    let revenue, runtime: Int
    let sortBy: String
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case averageRating = "average_rating"
        case backdropPath = "backdrop_path"
        case comments
        case createdBy = "created_by"
        case loaderModelDescription = "description"
        case id
        case name
        case objectIDS = "object_ids"
        case page
        case posterPath = "poster_path"
        case loaderModelPublic = "public"
        case results, revenue, runtime
        case sortBy = "sort_by"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - CreatedBy

///
struct CreatedBy: Codable {
    let gravatarHash, id, name, username: String

    enum CodingKeys: String, CodingKey {
        case gravatarHash = "gravatar_hash"
        case id, name, username
    }
}

// MARK: - Result

///
struct Result: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
