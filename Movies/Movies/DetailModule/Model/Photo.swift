//
//  Photo.swift
//  Movies
//
//  Created by User on 09.05.2021.
//

import Foundation
import RealmSwift

///
struct PhotoModel: Codable {
    let id: Int
    let backrops: [Photo]
}

final class Photo: Object {
    @objc dynamic var filmId = 0
    @objc dynamic var aspectRatio = 0.0
    @objc dynamic var filmPath = ""

    override class func primaryKey() -> String? {
        "filmPath"
    }
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filmPath = "file_path"
    }
}
